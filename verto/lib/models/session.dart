class Session {
  String id;
  String hostID;
  int price;
  bool isBooked;
  DateTime startTime;

  Session({
    required this.id,
    required this.hostID,
    required this.price,
    required this.startTime,
    this.isBooked = false,
  });

  static fromJson(Map<String, dynamic> data) => Session(
      id: data["id"],
      hostID: data["host_id"],
      price: data["price"],
      startTime: data["start_time"],
      isBooked: data["is_booked"],
    );
}
