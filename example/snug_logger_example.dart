import 'package:snug_logger/snug_logger.dart';
import 'package:snug_logger/src/utlis/log_type.dart';

void main() {
  snugLog("[DEBUG]: 🐞 This is a debug message", LogType.debug);
  snugLog("[INFO]: 🔍 This is an info message", LogType.info);
  snugLog("[PRODUCTION]: 🚀  This is a production message", LogType.production);
  snugLog("[ERROR]: ❌ This is an error message", LogType.error);
}
