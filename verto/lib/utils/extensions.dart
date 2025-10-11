extension DateFormat on DateTime {
  String customFormat() {
    int startHour = hour <= 12 ? 12 : hour % 12;
    int endHour = (hour + 1) <= 12 ? 12 : (hour + 1) % 12;
    return "${startHour < 10 ? "0$startHour" : startHour}:${minute < 10 ? "0$minute" : minute}${hour < 12 ? "AM" : "PM"} - ${endHour < 10 ? "0$endHour" : endHour}:${minute < 10 ? "0$minute" : minute}${hour + 1 < 12 ? "AM" : "PM"}";
  }
}
