import '../icon/icon.dart';

enum NotificationType { info, warning, error }

class AppNotificationProps {
  NotificationType type;
  final String headline;
  final String content;
  final AppIcon? icon;

  AppNotificationProps({
    this.type = NotificationType.info,
    required this.headline,
    required this.content,
    this.icon,
  });
}
