import 'package:cartify/controllers/subcategory_controller.dart';
import 'package:cartify/models/category.dart';
import 'package:cartify/models/subcategory.dart';
import 'package:cartify/views/screens/detail/screens/widgets/inner_banner_widget.dart';
import 'package:cartify/views/screens/detail/screens/widgets/inner_header_widget.dart';
import 'package:cartify/views/screens/nav_screens/widgets/subcategory_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InnerCategoryContentWidget extends StatefulWidget {
  final Category category;

  const InnerCategoryContentWidget({super.key, required this.category});



  @override
  State<InnerCategoryContentWidget> createState() => _InnerCategoryContentWidgetState();
}

class _InnerCategoryContentWidgetState extends State<InnerCategoryContentWidget> {
  late Future<List<SubCategory>> subCategories;
  SubCategoryController subcategoryController = SubCategoryController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subCategories = subcategoryController.getSubCategoryByCategoryName(widget.category.name);
  }
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
            Text("Shop by Category", style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
              fontSize: 19,

            ),
            ),
            FutureBuilder(
              future: subCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No sub categories available'));
                } else {
                  final subcategories = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                        children: List.generate((subcategories.length/7).ceil(), (setIndex){
                          // for each row calculate the starting index and ending index
                          final start = setIndex * 7;
                          final end = start + 7;
                          // create a padding widget around each row
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              // create a row of subcategory tiles
                              children: subcategories.sublist(start,end>subcategories.length ? subcategories.length : end).map((subcategory)=>SubcategoryTileWidget(title: subcategory.subCategoryName, image: subcategory.image)).toList(),
                            ),
                          );
                        })
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
