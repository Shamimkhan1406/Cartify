import 'dart:convert';

import 'package:cartify/models/vendor_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../global_variables.dart';


class VendorController {
  final String cloudName =
      dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? 'default_cloud';
  final String uploadPreset =
      dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? 'default_preset';

  // fetch banner
  Future <List<Vendor>> loadVendors() async {
    try {
      // http get request to fetch banners
      http.Response response = await http.get(Uri.parse("$uri/api/vendors"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }
      );
      print(response.body);
      if (response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List <Vendor> vendors = data.map((vendor)=>Vendor.fromJson(vendor)).toList();
        return vendors;
      }
      else if(response.statusCode == 404){
        return [];
      }
      else{
        throw Exception("Failed to load vendors");
      }

    } catch (e) {
      throw Exception("Error fetching vendors: $e");
    }
  }
}