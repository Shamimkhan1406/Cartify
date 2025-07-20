import 'package:cartify/models/category.dart';
import 'package:cartify/views/screens/detail/screens/widgets/inner_banner_widget.dart';
import 'package:cartify/views/screens/detail/screens/widgets/inner_header_widget.dart';
import 'package:flutter/material.dart';

class InnerCategoryScreen extends StatefulWidget {
  final Category category;

  const InnerCategoryScreen({super.key, required this.category});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 1.5,
        ),
        child: InnerHeaderWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InnerBannerWidget(image: widget.category.banner,),
          ],
        ),
      ),
    );
  }
}
