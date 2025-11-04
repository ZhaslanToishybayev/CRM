// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$achievementRepositoryHash() =>
    r'b9b81d7ce35e389e44bdfe965168cad0517e71bf';

/// See also [achievementRepository].
@ProviderFor(achievementRepository)
final achievementRepositoryProvider = Provider<AchievementRepository>.internal(
  achievementRepository,
  name: r'achievementRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$achievementRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AchievementRepositoryRef = ProviderRef<AchievementRepository>;
String _$achievementsListHash() => r'18cff8574b777ff3f0e203d0120f0ef08d8c8a91';

/// See also [achievementsList].
@ProviderFor(achievementsList)
final achievementsListProvider =
    AutoDisposeFutureProvider<List<AchievementModel>>.internal(
  achievementsList,
  name: r'achievementsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$achievementsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AchievementsListRef
    = AutoDisposeFutureProviderRef<List<AchievementModel>>;
String _$userAchievementsHash() => r'79e93728fefbe897c70230d7586d9524390d782c';

/// See also [userAchievements].
@ProviderFor(userAchievements)
final userAchievementsProvider =
    AutoDisposeFutureProvider<List<UserAchievement>>.internal(
  userAchievements,
  name: r'userAchievementsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userAchievementsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserAchievementsRef
    = AutoDisposeFutureProviderRef<List<UserAchievement>>;
String _$achievementStatsHash() => r'd5f696745c9fa16ddc18682544996e09cda6f16d';

/// See also [achievementStats].
@ProviderFor(achievementStats)
final achievementStatsProvider =
    AutoDisposeFutureProvider<AchievementStats>.internal(
  achievementStats,
  name: r'achievementStatsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$achievementStatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AchievementStatsRef = AutoDisposeFutureProviderRef<AchievementStats>;
String _$achievementsByCategoryHash() =>
    r'd7381cd17f3d0e50ecf085e5af5cb0f82311b919';

/// See also [achievementsByCategory].
@ProviderFor(achievementsByCategory)
final achievementsByCategoryProvider = AutoDisposeFutureProvider<
    Map<AchievementCategory, List<AchievementModel>>>.internal(
  achievementsByCategory,
  name: r'achievementsByCategoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$achievementsByCategoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AchievementsByCategoryRef = AutoDisposeFutureProviderRef<
    Map<AchievementCategory, List<AchievementModel>>>;
String _$unlockedAchievementsHash() =>
    r'54c3ae1ac15b1a17d43ab9f809b507ba99a158eb';

/// See also [unlockedAchievements].
@ProviderFor(unlockedAchievements)
final unlockedAchievementsProvider =
    AutoDisposeProvider<List<UserAchievement>>.internal(
  unlockedAchievements,
  name: r'unlockedAchievementsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$unlockedAchievementsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UnlockedAchievementsRef = AutoDisposeProviderRef<List<UserAchievement>>;
String _$lockedAchievementsHash() =>
    r'96da01fa64bb1bc83bee8c0ea4ac430774bd98ae';

/// See also [lockedAchievements].
@ProviderFor(lockedAchievements)
final lockedAchievementsProvider =
    AutoDisposeProvider<List<AchievementModel>>.internal(
  lockedAchievements,
  name: r'lockedAchievementsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lockedAchievementsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LockedAchievementsRef = AutoDisposeProviderRef<List<AchievementModel>>;
String _$achievementNotifierHash() =>
    r'b634438fd404c2a0407c52499846f87ce5316d30';

/// Achievement Notifier
///
/// Copied from [AchievementNotifier].
@ProviderFor(AchievementNotifier)
final achievementNotifierProvider =
    AutoDisposeNotifierProvider<AchievementNotifier, void>.internal(
  AchievementNotifier.new,
  name: r'achievementNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$achievementNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AchievementNotifier = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
