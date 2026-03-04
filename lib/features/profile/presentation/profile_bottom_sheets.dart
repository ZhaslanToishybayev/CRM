part of '../../../main.dart';

class AchievementsBottomSheet extends StatelessWidget {
  final UserStats userStats;

  const AchievementsBottomSheet({super.key, required this.userStats});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Достижения',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildAchievementCard(
                  'Первая задача',
                  'Выполните первую задачу',
                  Icons.check_circle,
                  Colors.green,
                  true,
                ),
                _buildAchievementCard(
                  'Мастер задач',
                  'Выполните 10 задач',
                  Icons.stars,
                  Colors.blue,
                  userStats.xp >= 250,
                ),
                _buildAchievementCard(
                  'Хранитель серии',
                  'Поддерживайте серию 7 дней',
                  Icons.local_fire_department,
                  Colors.orange,
                  userStats.streak >= 7,
                ),
                _buildAchievementCard(
                  'Новый уровень',
                  'Достигните 5 уровня',
                  Icons.emoji_events,
                  Colors.purple,
                  userStats.level >= 5,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAchievementCard(
    String title,
    String description,
    IconData icon,
    Color color,
    bool unlocked,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: unlocked ? color.withValues(alpha: 0.1) : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: unlocked ? color : Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: unlocked ? color : Colors.grey, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: unlocked ? Colors.black87 : Colors.grey,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: unlocked ? Colors.grey[600] : Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          if (unlocked)
            Icon(Icons.check_circle, color: color, size: 24)
          else
            Icon(Icons.lock, color: Colors.grey, size: 24),
        ],
      ),
    );
  }
}

class NotificationsBottomSheet extends StatelessWidget {
  const NotificationsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.5,
        maxChildSize: 0.8,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Уведомления',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildNotificationItem(
                  'Напоминания о задачах',
                  'Уведомления о ближайших дедлайнах',
                  const Color(0xFF3B82F6),
                  true,
                ),
                _buildNotificationItem(
                  'Оповещения о достижениях',
                  'Получайте уведомления о новых достижениях',
                  const Color(0xFFFFA500),
                  true,
                ),
                _buildNotificationItem(
                  'Ежедневная сводка',
                  'Краткий отчет по продуктивности',
                  const Color(0xFF10B981),
                  false,
                ),
                _buildNotificationItem(
                  'Недельные отчеты',
                  'Сводка прогресса за неделю',
                  const Color(0xFF8B5CF6),
                  true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationItem(
    String title,
    String description,
    Color color,
    bool enabled,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.notifications, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: enabled,
            onChanged: (value) {},
            activeThumbColor: color,
          ),
        ],
      ),
    );
  }
}

// ========== TASK DETAILS BOTTOM SHEET ==========
