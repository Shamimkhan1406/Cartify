import 'package:flutter/material.dart';

class InnerBannerWidget extends StatelessWidget {
  final String image;

  const InnerBannerWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 170,
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(4),
        //   color: Colors.red, //Color(0xFFF7F7F7)
        // ),
        // clipBehavior: Clip.hardEdge,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(image, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
