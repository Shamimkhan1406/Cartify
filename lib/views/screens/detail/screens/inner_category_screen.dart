import 'package:cartify/models/category.dart';
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
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: Center(child:Text("Inner Category Screen")),
    );
  }
}
