import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../global_variables.dart';
import '../models/banner_model.dart';


class BannerController {
  final String cloudName =
      dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? 'default_cloud';
  final String uploadPreset =
      dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? 'default_preset';

  // fetch banner
  Future <List<BannerModel>> loadBanners() async {
    try {
      // http get request to fetch banners
      http.Response response = await http.get(Uri.parse("$uri/api/banner"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }
      );
      print(response.body);
      if (response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List <BannerModel> banners = data.map((banner)=>BannerModel.fromJson(banner)).toList();
        return banners;
      }
      else{
        throw Exception("Failed to load banners");
      }

    } catch (e) {
      throw Exception("Error fetching banners: $e");
    }
  }
}