// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentXPHash() => r'401b0332b54b015faa6bb3cea83613dfcf1b6984';

/// Provider for the current user's XP
///
/// Copied from [currentXP].
@ProviderFor(currentXP)
final currentXPProvider = Provider<XPModel?>.internal(
  currentXP,
  name: r'currentXPProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentXPHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentXPRef = ProviderRef<XPModel?>;
String _$currentLevelInfoHash() => r'bc2f0ae9c1aa6fa1396aac68f6b167ecdd76cb7c';

/// Provider for the current level info
///
/// Copied from [currentLevelInfo].
@ProviderFor(currentLevelInfo)
final currentLevelInfoProvider = Provider<LevelInfo>.internal(
  currentLevelInfo,
  name: r'currentLevelInfoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentLevelInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentLevelInfoRef = ProviderRef<LevelInfo>;
String _$nextLevelInfoHash() => r'a13490e6873a45b78301fbd7340dd191947352c5';

/// Provider for next level info
///
/// Copied from [nextLevelInfo].
@ProviderFor(nextLevelInfo)
final nextLevelInfoProvider = Provider<LevelInfo>.internal(
  nextLevelInfo,
  name: r'nextLevelInfoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$nextLevelInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NextLevelInfoRef = ProviderRef<LevelInfo>;
String _$gamificationNotifierHash() =>
    r'fb698dba7dcf5e6cc9f326c4d5890fc4f1103bd9';

/// Provider for gamification state
///
/// Copied from [GamificationNotifier].
@ProviderFor(GamificationNotifier)
final gamificationNotifierProvider =
    NotifierProvider<GamificationNotifier, void>.internal(
  GamificationNotifier.new,
  name: r'gamificationNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gamificationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GamificationNotifier = Notifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
