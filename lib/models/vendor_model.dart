import 'dart:convert';

class Vendor {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String role;
  final String? password;
  final String? token;
  final String? storeImage;
  final String? storeDescription;
  final String? storeName;

  Vendor({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.role,
    this.password,
    this.token,
    this.storeImage,
    this.storeDescription,
    this.storeName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'role': role,
      'password': password,
      'token': token,
      'storeImage': storeImage,
      'storeDescription': storeDescription,
      'storeName': storeName,
    };
  }

  String toJson() => json.encode(toMap());

  factory Vendor.fromJson(Map<String, dynamic> map) {
    return Vendor(
      id: map['_id']?.toString() ?? '',
      fullName: map['fullName']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      state: map['state']?.toString() ?? '',
      city: map['city']?.toString() ?? '',
      locality: map['locality']?.toString() ?? '',
      role: map['role']?.toString() ?? '',
      password: map['password']?.toString(),
      token: map['token']?.toString(),
      storeImage: map['storeImage']?.toString(),
      storeDescription: map['storeDescription']?.toString(),
      storeName: map['storeName']?.toString(),
    );
  }
}
