import 'package:dio/dio.dart';

String getKratosMessagesFromNodes(DioException e) {
  String messages = '';

  final json = e.response?.data as Map?;

  final error = json?['error'] as Map?;
  final ui = json?['ui'] as Map?;

  if (error != null && error.isNotEmpty) {
    messages = error['reason'] as String;
  } else if (ui != null && ui.isNotEmpty) {
    final nodeMessages = ui['messages'] as List?;

    if (nodeMessages != null && nodeMessages.isNotEmpty) {
      final text = nodeMessages.first as Map?;
      messages = text?['text'] ?? '';
    } else {
      final nodes = ui['nodes'] as List;
      messages = '';
      List? temp1;
      Map? temp2;
      for (var element in nodes) {
        temp1 = element['messages'] as List?;
        if (temp1 != null && temp1.isNotEmpty) {
          temp2 = temp1.first as Map?;
          messages += temp2?['text'];
        }
      }
    }
  }
  return messages;
}