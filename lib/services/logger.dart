
import 'package:flutter/foundation.dart';

class Logger {
  Logger._();

  static void debug(String message) {
    if (kDebugMode) {
      debugPrint('[DEBUG] $message');
    }
  }

  static void info(String message) {
    if (kDebugMode) {
      debugPrint('[INFO] $message');
    }
  }

  static void warning(String message) {
    if (kDebugMode) {
      debugPrint('[WARNING] $message');
    }
  }

  static void error(String message) {
    if (kDebugMode) {
      debugPrint('[ERROR] $message');
    }
  }
}
