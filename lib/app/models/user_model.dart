class UserModel {
  final int id;
  final String email;
  final String username;
  final String? password;
  final String firstname;
  final String lastname;
  final String phone;
  final Map<String, dynamic> address;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    this.password,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.address,
  });

  String get fullName => '$firstname $lastname';

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final name = json['name'] ?? {};
    final address = json['address'] ?? {};
    return UserModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      password: json['password']?.toString(),
      firstname: name['firstname'] ?? '',
      lastname: name['lastname'] ?? '',
      phone: json['phone'] ?? '',
      address: Map<String, dynamic>.from(address),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'password': password,
      'name': {'firstname': firstname, 'lastname': lastname},
      'phone': phone,
      'address': address,
    };
  }
}