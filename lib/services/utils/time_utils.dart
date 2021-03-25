class TimeUtils {
  static String formatTimeSection(int number) {
    if (number < 10) {
      return "0$number";
    }
    return "$number";
  }

  static String formatElapsedTime(int elapsedTime) {
    if (elapsedTime > 3600) {
      int hour = (elapsedTime / 3600).floor();
      return "${formatTimeSection(hour)}:${formatTimeSection(((elapsedTime - (hour * 3600)) / 60).floor())}:${formatTimeSection(elapsedTime % 60)}";
    }
    if (elapsedTime > 60) {
      return "${formatTimeSection((elapsedTime / 60).floor())}:${formatTimeSection(elapsedTime % 60)}";
    }

    return "00:${formatTimeSection(elapsedTime)}";
  }
}
