import 'package:flutter/cupertino.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

import '../../../app/shared/widgets/widgets.dart';


void showNotification(
  UiTextTypeEnum type,
  String content,
  BuildContext context,
) {
  if (!context.mounted) return;
  if (content.contains('OK') != true && content != '') {
    NotificationType notificationType = NotificationType.info;
    String headline = '';

    switch (type) {
      case UiTextTypeEnum.success:
        notificationType = NotificationType.info;
        headline = 'Success';
      case UiTextTypeEnum.error:
        notificationType = NotificationType.error;
        headline = 'Error';
      case UiTextTypeEnum.info:
        notificationType = NotificationType.warning;
        headline = 'Info';
    }

    NotificationDisplay.show(
        context,
        AppNotification(
            props: AppNotificationProps(
          content: content,
          headline: headline,
          type: notificationType,
        )));
  }
}
