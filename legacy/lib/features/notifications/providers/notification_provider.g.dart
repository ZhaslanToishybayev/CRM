// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationNotifierHash() =>
    r'b38dcb3c6a5ad62fac8aeba3be856c74183bb69f';

/// See also [NotificationNotifier].
@ProviderFor(NotificationNotifier)
final notificationNotifierProvider = AutoDisposeNotifierProvider<
    NotificationNotifier, List<NotificationModel>>.internal(
  NotificationNotifier.new,
  name: r'notificationNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NotificationNotifier = AutoDisposeNotifier<List<NotificationModel>>;
String _$notificationSettingsNotifierHash() =>
    r'895b52da2ad28f897871c93a8c7e82795ee18406';

/// See also [NotificationSettingsNotifier].
@ProviderFor(NotificationSettingsNotifier)
final notificationSettingsNotifierProvider = NotifierProvider<
    NotificationSettingsNotifier, NotificationSettingsModel>.internal(
  NotificationSettingsNotifier.new,
  name: r'notificationSettingsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationSettingsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NotificationSettingsNotifier = Notifier<NotificationSettingsModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
