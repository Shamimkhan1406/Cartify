import 'package:cartify/views/screens/nav_screens/widgets/banner_widget.dart';
import 'package:cartify/views/screens/nav_screens/widgets/category_item_widget.dart';
import 'package:cartify/views/screens/nav_screens/widgets/header_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(),
            BannerWidget(),
            CategoryItemWidget(),
            Center(child: Text("Home Screen"),),
          ],
        ),
      ),
    );
  }
}
