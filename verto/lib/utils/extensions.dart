extension DateFormat on DateTime {
  String customFormat() {
    return "${hour < 10 ? "0$hour" : hour}:${minute < 10 ? "0$minute" : minute}";
  }
}
