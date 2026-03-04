/// Level Up Celebration Screen
/// Educational Project - Gamified Task Management App
///
/// Full-screen modal celebrating level up achievement

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../models/xp_model.dart';
import '../models/level_model.dart';
import '../providers/gamification_provider.dart';

class LevelUpCelebrationScreen extends ConsumerStatefulWidget {
  final XPModel oldXP;
  final XPModel newXP;

  const LevelUpCelebrationScreen({
    super.key,
    required this.oldXP,
    required this.newXP,
  });

  @override
  ConsumerState<LevelUpCelebrationScreen> createState() => _LevelUpCelebrationScreenState();
}

class _LevelUpCelebrationScreenState extends ConsumerState<LevelUpCelebrationScreen>
    with TickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Setup confetti animation
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    // Setup animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    // Start animations
    _animationController.forward();
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final oldLevelInfo = ref.read(gamificationNotifierProvider.notifier).getLevelInfo(widget.oldXP.currentLevel);
    final newLevelInfo = ref.read(gamificationNotifierProvider.notifier).getLevelInfo(widget.newXP.currentLevel);
    final isMilestone = ref.read(gamificationNotifierProvider.notifier).isMilestoneLevel(widget.newXP.currentLevel);

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      body: Stack(
        children: [
          // Confetti animation
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 3.14159 / 2, // Point down
              maxBlastForce: 100,
              minBlastForce: 50,
              emissionFrequency: 0.03,
              numberOfParticles: 50,
              gravity: 0.3,
              shouldLoop: false,
              colors: [
                AppTheme.xpColor,
                AppTheme.levelColor,
                AppTheme.achievementColor,
                AppTheme.primary,
              ],
            ),
          ),

          // Main content
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  margin: const EdgeInsets.all(32),
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    gradient: AppTheme.getLevelGradient(),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: newLevelInfo.color == '#FFD54F'
                            ? AppTheme.levelColor.withOpacity(0.5)
                            : Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Level up text
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          isMilestone ? 'MILESTONE ACHIEVED!' : 'LEVEL UP!',
                          key: ValueKey(isMilestone),
                          style: TextStyle(
                            fontSize: isMilestone ? 24 : 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 2,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: const Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Level badge
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Glowing effect
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.2),
                              boxShadow: [
                                BoxShadow(
                                  color: newLevelInfo.color == '#FFD54F'
                                      ? Colors.orange.withOpacity(0.5)
                                      : AppTheme.levelColor.withOpacity(0.5),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                          ),
                          // Level number
                          Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: _parseColor(newLevelInfo.color),
                                width: 4,
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.newXP.currentLevel.toString(),
                                    style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w900,
                                      color: _parseColor(newLevelInfo.color),
                                    ),
                                  ),
                                  Text(
                                    'LEVEL',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textSecondary,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Level title
                      Text(
                        newLevelInfo.title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Level subtitle
                      Text(
                        newLevelInfo.subtitle,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Divider
                      Container(
                        height: 2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.white.withOpacity(0.5),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Stats
                      if (isMilestone) ...[
                        Icon(
                          Icons.workspace_premium,
                          color: AppTheme.achievementColor,
                          size: 40,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Special Milestone!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // XP info
                      Text(
                        '${widget.newXP.formattedTotalXP} Total XP',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        '${widget.newXP.xpToNextLevel} XP to next level',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Continue button
                      ElevatedButton(
                        onPressed: () {
                          context.pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppTheme.levelColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 4,
                        ),
                        child: const Text(
                          'CONTINUE',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _parseColor(String hexColor) {
    final hex = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }
}

/// Helper function to show level up celebration
void showLevelUpCelebration({
  required BuildContext context,
  required XPModel oldXP,
  required XPModel newXP,
}) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LevelUpCelebrationScreen(
        oldXP: oldXP,
        newXP: newXP,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
      barrierColor: Colors.black.withOpacity(0.8),
      barrierDismissible: false,
    ),
  );
}
