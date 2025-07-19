// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Category {
  final String id;
  final String name;
  final String image;
  final String banner;

  Category(this.id, this.name, this.image, this.banner);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'banner': banner,
    };
  }
  String toJson() => json.encode(toMap());

  factory Category.fromJson(Map<String, dynamic> map) {
    return Category(
      map['_id'] as String,
      map['name'] as String,
      map['image'] as String,
      map['banner'] as String,
    );
  }



//factory Category.fromJson(String source) => Category.fromMap(json.decode(source) as Map<String, dynamic>);
}
