class User {
  final String? createdAt;
  final String name;
  final String? avatar;
  final String emailId;
  final String mobile;
  final String country;
  final String? state;
  final String? district;
  final String id;
  final String? email;

  User({
    this.createdAt,
    required this.name,
    this.avatar,
    required this.emailId,
    required this.mobile,
    required this.country,
    this.state,
    this.district,
    required this.id,
    this.email,
  });

  // A factory constructor to convert JSON to a User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      createdAt: json['createdAt'] ?? null,
      name: json['name'] ?? 'Unknown',
      avatar: json['avatar'] ?? null,
      emailId: json['emailId'] ?? '',
      mobile: json['mobile'] ?? '',
      country: json['country'] ?? '',
      state: json['state'] ?? null,
      district: json['district'] ?? null,
      id: json['id'] ?? '',
      email: json['email'] ?? null,
    );
  }
}
