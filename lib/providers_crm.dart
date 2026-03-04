// CRM providers for app state management.

import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'auth/auth_service.dart';
import 'core/config/runtime_flags.dart';
import 'core/database/supabase_config.dart';

part 'providers_crm.g.dart';

// ========== CRM MODELS ==========

@HiveType(typeId: 0)
class Client extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String firstName;
  @HiveField(2)
  String lastName;
  @HiveField(3)
  String email;
  @HiveField(4)
  String? phone;
  @HiveField(5)
  String? company;
  @HiveField(6)
  String? position;
  @HiveField(7)
  ClientStatus status;
  @HiveField(8)
  ClientSource source;
  @HiveField(9)
  DateTime createdAt;

  Client({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.company,
    this.position,
    this.status = ClientStatus.lead,
    this.source = ClientSource.other,
    required this.createdAt,
  });

  String get fullName => '$firstName $lastName';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'company': company,
      'position': position,
      'status': status.name,
      'source': source.name,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      company: json['company'],
      position: json['position'],
      status: ClientStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => ClientStatus.lead,
      ),
      source: ClientSource.values.firstWhere(
        (s) => s.name == json['source'],
        orElse: () => ClientSource.other,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
    );
  }

  Client copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? company,
    String? position,
    ClientStatus? status,
    ClientSource? source,
    DateTime? createdAt,
  }) {
    return Client(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      company: company ?? this.company,
      position: position ?? this.position,
      status: status ?? this.status,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

@HiveType(typeId: 1)
enum ClientStatus {
  @HiveField(0)
  lead,
  @HiveField(1)
  prospect,
  @HiveField(2)
  active,
  @HiveField(3)
  inactive,
}

@HiveType(typeId: 2)
enum ClientSource {
  @HiveField(0)
  website,
  @HiveField(1)
  referral,
  @HiveField(2)
  coldCall,
  @HiveField(3)
  email,
  @HiveField(4)
  socialMedia,
  @HiveField(5)
  event,
  @HiveField(6)
  advertisement,
  @HiveField(7)
  partner,
  @HiveField(8)
  other,
}

// ========== CLIENTS PROVIDER ==========

class ClientsNotifier extends StateNotifier<List<Client>> {
  ClientsNotifier() : super([]);

  final String clientsBoxKey = 'clients';
  bool _isSyncing = false;

  bool get _useDemoStorage => kDemoMode || AuthService.debugForceDemoMode;
  bool get _canUseBackend =>
      !_useDemoStorage &&
      SupabaseConfig.isConfigured &&
      AuthService.currentUser != null;

  void _ensureBackendReady({required String operation}) {
    if (_useDemoStorage) return;
    if (!SupabaseConfig.isConfigured) {
      throw StateError(
        'Backend mode is enabled, but SUPABASE_URL/SUPABASE_ANON_KEY are missing. '
        'Unable to $operation.',
      );
    }
    if (AuthService.currentUser == null) {
      throw StateError('Authentication is required to $operation.');
    }
  }

  ClientStatus _statusFromDb(dynamic value) {
    final raw = (value ?? '').toString().toLowerCase();
    switch (raw) {
      case 'prospect':
        return ClientStatus.prospect;
      case 'active':
        return ClientStatus.active;
      case 'inactive':
      case 'churned':
        return ClientStatus.inactive;
      case 'lead':
      default:
        return ClientStatus.lead;
    }
  }

  ClientSource _sourceFromDb(dynamic value) {
    final raw = (value ?? '').toString().toLowerCase();
    switch (raw) {
      case 'website':
        return ClientSource.website;
      case 'referral':
        return ClientSource.referral;
      case 'coldcall':
      case 'cold_call':
        return ClientSource.coldCall;
      case 'email':
        return ClientSource.email;
      case 'socialmedia':
      case 'social_media':
        return ClientSource.socialMedia;
      case 'event':
        return ClientSource.event;
      case 'advertisement':
      case 'campaign':
        return ClientSource.advertisement;
      case 'partner':
        return ClientSource.partner;
      case 'manual':
      case 'other':
      default:
        return ClientSource.other;
    }
  }

  String _statusToDb(ClientStatus status) {
    switch (status) {
      case ClientStatus.lead:
        return 'lead';
      case ClientStatus.prospect:
        return 'prospect';
      case ClientStatus.active:
        return 'active';
      case ClientStatus.inactive:
        return 'inactive';
    }
  }

  String _sourceToDb(ClientSource source) {
    switch (source) {
      case ClientSource.website:
        return 'website';
      case ClientSource.referral:
        return 'referral';
      case ClientSource.coldCall:
        return 'cold_call';
      case ClientSource.email:
        return 'email';
      case ClientSource.socialMedia:
        return 'social_media';
      case ClientSource.event:
        return 'event';
      case ClientSource.advertisement:
        return 'advertisement';
      case ClientSource.partner:
        return 'partner';
      case ClientSource.other:
        return 'other';
    }
  }

  DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }
    return null;
  }

  Client _clientFromDb(Map<String, dynamic> row) {
    return Client(
      id: row['id']?.toString() ?? '',
      firstName: row['first_name']?.toString() ?? '',
      lastName: row['last_name']?.toString() ?? '',
      email: row['email']?.toString() ?? '',
      phone: row['phone']?.toString(),
      company: row['company_name']?.toString(),
      position: row['position']?.toString(),
      status: _statusFromDb(row['status']),
      source: _sourceFromDb(row['source']),
      createdAt:
          _parseDate(row['created_at']) ??
          _parseDate(row['updated_at']) ??
          DateTime.now(),
    );
  }

  bool _looksLikeUuid(String value) {
    final regex = RegExp(
      r'^[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}$',
    );
    return regex.hasMatch(value);
  }

  Map<String, dynamic> _clientToDb(Client client, {bool includeId = true}) {
    return {
      if (includeId && _looksLikeUuid(client.id)) 'id': client.id,
      'first_name': client.firstName,
      'last_name': client.lastName,
      'email': client.email,
      'phone': client.phone,
      'company_name': client.company,
      'position': client.position,
      'status': _statusToDb(client.status),
      'source': _sourceToDb(client.source),
      'updated_at': DateTime.now().toIso8601String(),
    };
  }

  Future<void> _syncAllClients(List<Client> clients) async {
    if (!_canUseBackend) {
      _ensureBackendReady(operation: 'sync clients');
      return;
    }
    if (_isSyncing) return;
    _isSyncing = true;
    try {
      final rawRemote = await SupabaseConfig.client
          .from('crm_clients')
          .select();
      final remoteRows = (rawRemote as List)
          .map((row) => Map<String, dynamic>.from(row as Map))
          .toList();

      final remoteIds = remoteRows
          .map((row) => row['id']?.toString())
          .whereType<String>()
          .toSet();
      final desiredIds = clients.map((client) => client.id).toSet();

      for (final client in clients) {
        if (remoteIds.contains(client.id)) {
          await SupabaseConfig.client
              .from('crm_clients')
              .update(_clientToDb(client))
              .eq('id', client.id);
        } else {
          await SupabaseConfig.client
              .from('crm_clients')
              .insert(_clientToDb(client, includeId: false));
        }
      }

      final staleIds = remoteIds.difference(desiredIds);
      for (final staleId in staleIds) {
        await SupabaseConfig.client
            .from('crm_clients')
            .delete()
            .eq('id', staleId);
      }
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> loadClients() async {
    if (!_useDemoStorage) {
      _ensureBackendReady(operation: 'load clients');
      final response = await SupabaseConfig.client
          .from('crm_clients')
          .select()
          .order('created_at', ascending: false);

      state = (response as List)
          .map((row) => _clientFromDb(Map<String, dynamic>.from(row as Map)))
          .toList();
      return;
    }

    try {
      final clientsBox = await Hive.openBox<Client>(clientsBoxKey);
      state = clientsBox.values.toList();
    } catch (e) {
      developer.log('event=client_load_local_failed error=$e');
    }
  }

  Future<void> saveClients() async {
    if (!_useDemoStorage) return;
    try {
      final clientsBox = await Hive.openBox<Client>(clientsBoxKey);
      await clientsBox.clear(); // Clear existing data
      for (final client in state) {
        await clientsBox.add(client);
      }
    } catch (e) {
      developer.log('event=client_save_local_failed error=$e');
    }
  }

  Future<void> addClient(Client client) async {
    if (!_useDemoStorage) {
      _ensureBackendReady(operation: 'create client');
    }
    final previousState = List<Client>.from(state);
    state = [client, ...state];
    if (_useDemoStorage) {
      await saveClients();
      return;
    }

    try {
      final response = await SupabaseConfig.client
          .from('crm_clients')
          .insert(_clientToDb(client, includeId: false))
          .select()
          .single();
      final savedClient = _clientFromDb(Map<String, dynamic>.from(response));
      final idx = state.indexWhere((item) => item.id == client.id);
      if (idx >= 0) {
        state = [
          ...state.sublist(0, idx),
          savedClient,
          ...state.sublist(idx + 1),
        ];
      }
    } catch (error) {
      state = previousState;
      developer.log('event=client_create_failed error=$error');
      rethrow;
    }
  }

  Future<void> updateClient(int index, Client client) async {
    if (index < 0 || index >= state.length) return;
    if (!_useDemoStorage) {
      _ensureBackendReady(operation: 'update client');
    }
    final previousState = List<Client>.from(state);
    state = [...state.sublist(0, index), client, ...state.sublist(index + 1)];
    if (_useDemoStorage) {
      await saveClients();
      return;
    }

    try {
      final response = await SupabaseConfig.client
          .from('crm_clients')
          .update(_clientToDb(client))
          .eq('id', client.id)
          .select()
          .single();
      final savedClient = _clientFromDb(Map<String, dynamic>.from(response));
      state = [
        ...state.sublist(0, index),
        savedClient,
        ...state.sublist(index + 1),
      ];
    } catch (error) {
      state = previousState;
      developer.log('event=client_update_failed error=$error');
      rethrow;
    }
  }

  Future<void> deleteClient(int index) async {
    if (index < 0 || index >= state.length) return;
    if (!_useDemoStorage) {
      _ensureBackendReady(operation: 'delete client');
    }
    final previousState = List<Client>.from(state);
    final client = state[index];
    state = [...state.sublist(0, index), ...state.sublist(index + 1)];
    if (_useDemoStorage) {
      await saveClients();
      return;
    }

    try {
      await SupabaseConfig.client
          .from('crm_clients')
          .delete()
          .eq('id', client.id);
    } catch (error) {
      state = previousState;
      developer.log('event=client_delete_failed error=$error');
      rethrow;
    }
  }

  Future<void> replaceClients(List<Client> clients) async {
    if (!_useDemoStorage) {
      _ensureBackendReady(operation: 'replace clients');
    }
    state = List<Client>.from(clients);
    if (_useDemoStorage) {
      await saveClients();
      return;
    }

    try {
      await _syncAllClients(clients);
    } catch (error) {
      developer.log('event=client_replace_failed error=$error');
    }
  }

  Future<void> loadAll() async {
    await loadClients();
  }
}

final clientsProvider = StateNotifierProvider<ClientsNotifier, List<Client>>((
  ref,
) {
  return ClientsNotifier();
});

// ========== CRM FILTERS PROVIDER ==========

class CRMFiltersNotifier extends StateNotifier<Map<String, String>> {
  CRMFiltersNotifier() : super({'status': 'All', 'source': 'All'});

  void setStatusFilter(String status) {
    state = {...state, 'status': status};
  }

  void setSourceFilter(String source) {
    state = {...state, 'source': source};
  }

  String get statusFilter => state['status'] ?? 'All';
  String get sourceFilter => state['source'] ?? 'All';
}

final crmFiltersProvider =
    StateNotifierProvider<CRMFiltersNotifier, Map<String, String>>((ref) {
      return CRMFiltersNotifier();
    });

// ========== COMBINED CRM PROVIDER ==========

class CRMState {
  final List<Client> clients;
  final Map<String, String> filters;

  CRMState({required this.clients, required this.filters});

  List<Client> get filteredClients {
    return clients.where((client) {
      final statusMatch =
          filters['status'] == 'All' ||
          client.status.name == filters['status']!.toLowerCase();
      final sourceMatch =
          filters['source'] == 'All' ||
          client.source.name == filters['source']!.toLowerCase();
      return statusMatch && sourceMatch;
    }).toList();
  }
}

final crmStateProvider = Provider<CRMState>((ref) {
  final clients = ref.watch(clientsProvider);
  final filters = ref.watch(crmFiltersProvider);

  return CRMState(clients: clients, filters: filters);
});
