import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/crm_notification_service.dart';

class NotificationBadge extends ConsumerWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? textColor;

  const NotificationBadge({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationService = ref.read(crmNotificationServiceProvider);

    return Stack(
      children: [
        child,
        FutureBuilder<int>(
          future: notificationService.getUnreadCount(),
          builder: (context, snapshot) {
            final unreadCount = snapshot.data ?? 0;

            if (unreadCount == 0) {
              return const SizedBox.shrink();
            }

            return Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: backgroundColor ?? Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.surface,
                    width: 2,
                  ),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  unreadCount > 99 ? '99+' : unreadCount.toString(),
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
