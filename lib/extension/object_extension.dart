import 'package:logger/logger.dart';

extension LoggerExtension on Object {
  void logDebug({String? message}) {
    Logger().d('$this: $message');
  }

  void logInfo({String? message}) {
    Logger().i('$this: $message');
  }

  void logWarning({String? message}) {
    Logger().w('$this: $message');
  }

  void logError({String? message}) {
    Logger().e('$this: $message');
  }
}