class Session {
  String id;
  String title;
  String description;
  String hostID;
  String hostName;
  int price;
  bool isBooked;
  DateTime startTime;

  Session({
    required this.id,
    required this.title,
    required this.description,
    required this.hostID,
    required this.price,
    required this.startTime,
    required this.hostName,
    this.isBooked = false,
  });

  static Session fromJson(Map<String, dynamic> data) {
    return Session(
      id: data["id"],
      hostID: data["host_id"],
      price: data["price"],
      startTime: DateTime.parse(data["start_time"]),
      title: data["title"],
      description: data["description"],
      hostName: data["host_name"],
      isBooked: data["is_booked"],
    );
  }
}
