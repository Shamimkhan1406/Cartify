import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Image.asset(
            "assets/icons/searchBanner.jpeg",
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 50,
            top: 70,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.2,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(fontSize: 15, color: Colors.white),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  prefixIcon: Image.asset(
                    "assets/icons/search.png",
                    width: 28,
                    height: 28,
                  ),
                  suffixIcon: Image.asset(
                    'assets/icons/cam.png',
                    width: 20,
                    height: 20,
                  ),
                  filled: true,
                  fillColor: Color(0x523A3A3A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 311,
            top: 82,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {},
                overlayColor: WidgetStateProperty.all(Color(0x523A3A3A),),
                child: Ink(
                  width: 31,
                  height: 31,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/bell.png"),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 364,
            top: 82,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {},
                overlayColor: WidgetStateProperty.all(Color(0x523A3A3A),),
                child: Ink(
                  width: 31,
                  height: 31,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/message.png"),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
