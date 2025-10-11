class User {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  int coins;
  int level;
  int xp;

  User({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.coins,
    required this.level,
    required this.xp,
  });

  static fromJson(Map<String, dynamic> json) => User(
    firstName: json["first_name"],
    lastName: json["last_name"],
    username: json["username"],
    email: json["email"],
    coins: json["coins"],
    level: json["level"],
    xp: json["xp"],
  );
}