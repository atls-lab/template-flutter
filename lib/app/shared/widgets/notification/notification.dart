import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'notification_props.dart';
import 'notification_styles.dart';

class AppNotification extends StatelessWidget {
  final AppNotificationProps props;

  const AppNotification({super.key, required this.props});

  @override
  Widget build(BuildContext context) {
    final styles =
        NotificationStyles(theme: Theme.of(context), type: props.type);

    RenderObjectWidget showIcon() {
      if (props.icon == null) {
        return const SizedBox.shrink();
      }
      final icon = props.icon;
      icon!.props.color = styles.typeColor;

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: props.icon,
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: styles.shapeStyle,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showIcon(),
                Expanded(
                    child: Text(props.headline, style: styles.headlineStyle)),
                SizedBox(
                  height: 24,
                  width: 24,
                  child: IconButton.filledTonal(
                    iconSize: 16,
                    constraints:
                        const BoxConstraints(maxHeight: 24, maxWidth: 24),
                    padding: const EdgeInsets.all(4),
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    onPressed:
                        ScaffoldMessenger.of(context).hideCurrentSnackBar,
                    alignment: Alignment.center,
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                    )),
                    icon: const Icon(Icons.close),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  props.content,
                  style: styles.contentStyle,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationDisplay {
  final AppNotification notification;

  NotificationDisplay({required this.notification});

  static void show(BuildContext context, AppNotification notification) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.none,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: notification,
      duration: Duration(
          seconds: int.parse(dotenv.env['NOTIFICATIONS_DURATION'] ?? '10')),
    ));
  }
}
