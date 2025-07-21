import 'package:cartify/controllers/subcategory_controller.dart';
import 'package:cartify/models/category.dart';
import 'package:cartify/models/subcategory.dart';
import 'package:cartify/views/screens/detail/screens/widgets/inner_banner_widget.dart';
import 'package:cartify/views/screens/detail/screens/widgets/inner_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InnerCategoryScreen extends StatefulWidget {
  final Category category;

  const InnerCategoryScreen({super.key, required this.category});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  late Future<List<SubCategory>> _subCategories;
  SubCategoryController _subcategoryController = SubCategoryController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subCategories = _subcategoryController.getSubCategoryByCategoryName(widget.category.name);
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
            Text("Shop by SubCategory", style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
              fontSize: 19,

            ),
            ),
            FutureBuilder(
              future: _subCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No categories available'));
                } else {
                  final subcategories = snapshot.data!;
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: subcategories.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemBuilder: (context, index) {
                      final subcategory = subcategories[index];
                      return InkWell(
                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context){
                          //   return InnerCategoryScreen(category: category,);
                          // }));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (subcategory.image.isNotEmpty)
                              Image.network(subcategory.image, height: 72, width: 75,),
                            Text(
                              subcategory.subCategoryName,
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
