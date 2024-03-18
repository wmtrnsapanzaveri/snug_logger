class CommonUtils {
  static String getHorizontalLine() {
    return List.filled(110, '─').join();
  }

  static String resetColor = "\u001b[0m";
}

bool kDebugMode = !bool.fromEnvironment('dart.vm.product') &&
    !bool.fromEnvironment('dart.vm.profile');
