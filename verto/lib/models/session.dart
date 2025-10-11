class Session {
  String id;
  String title;
  String description;
  String hostID;
  int price;
  bool isBooked;
  DateTime startTime;
  //constructor:-
  Session({
    required this.id,
    required this.title,
    required this.description,
    required this.hostID,
    required this.price,
    required this.startTime,
    this.isBooked = false,
  });

  static fromJson(Map<String, dynamic> data) => Session(
      title: data["title"],
      description: data["description"],
      id: data["id"],
      hostID: data["host_id"],
      price: data["price"],
      startTime: data["start_time"],
      isBooked: data["is_booked"],
    );
}
