import 'dart:convert';

class User {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
  });
  // serialization: convert user object to a map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "fulName": fullName,
      "email": email,
      "state": state,
      "city": city,
      "locality": locality,
      "password": password,
    };
  }

  // convert map to json string
  String toJson() => json.encode(toMap());
  // deserialization: convert json string to user object
  // so it can be easily manipulated and use within the app
  // the factory constructor takes map (usually comes from a json string)
  // and returns a user object
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["_id"] as String? ?? "",
      fullName: map["fullName"] as String? ?? "",
      email: map["email"] as String? ?? "",
      state: map["state"] as String? ?? "",
      city: map["city"] as String? ?? "",
      locality: map["locality"] as String? ?? "",
      password: map["password"] as String? ?? "",
    );
  }
}
