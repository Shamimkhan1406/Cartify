import 'package:cartify/controllers/banner_controller.dart';
import 'package:cartify/models/banner_model.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  // a future that will hold the list of banners once loaded from the api
  late Future<List<BannerModel>> futureBanners;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureBanners = BannerController().loadBanners();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.red, //Color(0xFFF7F7F7)
        ),
        clipBehavior: Clip.hardEdge,
        child: FutureBuilder(
          future: futureBanners,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No banners available'));
            } else {
              final banners = snapshot.data!;
              return PageView.builder(

                itemCount: banners.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final banner = banners[index];
                  if (banner.image.isEmpty) {
                    return Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.broken_image,
                        size: 48,
                        color: Colors.grey[700],
                      ),
                    );
                  }
                  return Image.network(
                    banner.image,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.broken_image,
                            size: 48,
                            color: Colors.grey[700],
                          ),
                        ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
