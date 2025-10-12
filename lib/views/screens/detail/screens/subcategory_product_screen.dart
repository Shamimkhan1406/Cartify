import 'package:cartify/models/subcategory.dart';
import 'package:flutter/material.dart';

class SubcategoryProductScreen extends StatefulWidget {
  final SubCategory subCategory;

  const SubcategoryProductScreen({super.key, required this.subCategory});

  @override
  State<SubcategoryProductScreen> createState() => _SubcategoryProductScreenState();
}

class _SubcategoryProductScreenState extends State<SubcategoryProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subCategory.subCategoryName),
      ),
      body: Center(
        child: Text('Products for ${widget.subCategory.subCategoryName} will be displayed here.'),
      ),
    );
  }
}