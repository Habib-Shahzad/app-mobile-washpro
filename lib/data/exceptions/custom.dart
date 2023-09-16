import 'package:washpro/logger.dart';

abstract class CustomException implements Exception {
  final String message;
  CustomException(String eMessage) : message = _parseExceptionMessage(eMessage);

  static String _parseExceptionMessage(String message) {
    String tempMessage = message.toLowerCase();
    List<String> stopWords = ['exception:', 'error:', 'socket'];
    for (String word in stopWords) {
      if (tempMessage.contains(word)) {
        logger.e(message);
        return "Something went wrong!";
      }
    }
    return message;
  }
}
