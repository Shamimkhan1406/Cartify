import 'package:cartify/controllers/category_controller.dart';
import 'package:cartify/controllers/subcategory_controller.dart';
import 'package:cartify/models/category.dart';
import 'package:cartify/provider/category_provider.dart';
import 'package:cartify/provider/subcategory_provider.dart';
import 'package:cartify/views/screens/nav_screens/widgets/header_widget.dart';
import 'package:cartify/views/screens/nav_screens/widgets/subcategory_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  // a future that will hold the list of categories once loaded from the api
  // late Future<List<Category>> futureCategories;
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    fetchCategeories();
  }

  Future<void> fetchCategeories() async {
    final categories = await CategoryController().loadCategories();
    ref.read(categoryProvider.notifier).setCategories(categories);

    // set the default selected category Fashion if available
    for (var category in categories) {
      if (category.name == "Fashion") {
        setState(() {
          _selectedCategory = category;
        });
        // load the subcategories of the Fashion category
        _fetchSubcategories(category.name);
      }
    }
  }

  Future<void> _fetchSubcategories(String categoryName) async {
    final subcategories = await SubCategoryController().getSubCategoryByCategoryName(categoryName);
    ref.read(subCategoryProvider.notifier).setSubcategories(subcategories);
  }
  // List<SubCategory> _subcategories =
  //     []; // list to hold the subcategories of the selected category <SubCategory>
  // final SubCategoryController _subcategoryController =
  //     SubCategoryController(); // instance of the SubCategoryController
  // @override
  // void initState() {
  //   // T implement initState
  //   super.initState();
  //   futureCategories = CategoryController().loadCategories();
  //   // once the categories are loaded, load the subcategories of the first category
  //   futureCategories.then((categories){
  //     // iterate over the categories and load the fashion subcategories
  //     for (var category in categories){
  //       if (category.name == "Fashion"){
  //         // if Fashion category is found, set it as the selected category
  //         setState(() {
  //           _selectedCategory = category;
  //         });
  //         // load the subcategories of the Fashion category
  //         _loadSubcategories(category.name);
  //       }
  //     }
  //   });
  // }

  // // this function will load subcategories of the selected category based on the category name
  // Future<void> _loadSubcategories(String categoryName) async {
  //   final subcategories = await _subcategoryController
  //       .getSubCategoryByCategoryName(categoryName);
  //   print(
  //     "Fetched ${subcategories.length} subcategories for $categoryName",
  //   ); // Debug print
  //   setState(() {
  //     _subcategories = subcategories;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    final subcategories = ref.watch(subCategoryProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.15,
        ),
        child: HeaderWidget(),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade50,
              child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return ListTile(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                            });
                            _fetchSubcategories(category.name);
                          },
                          title: Text(
                            category.name,
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color:
                                  _selectedCategory == category
                                      ? Colors.blue
                                      : Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
          // display the selected category banner
          Expanded(
            flex: 5,
            child:
                _selectedCategory != null
                    ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Text("Subcategories Count: ${_subcategories.length}"),// display the number of subcategories
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _selectedCategory!.name,
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(_selectedCategory!.banner),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          subcategories.isNotEmpty
                              ? GridView.builder(
                                
                                shrinkWrap: true,
                                itemCount: subcategories.length,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 4,
                                      mainAxisSpacing: 4,
                                      childAspectRatio: 2/3
                                    ),
                                itemBuilder: (context, index) {
                                  final subcategory = subcategories[index];
                                  return SubcategoryTileWidget(title: subcategory.subCategoryName, image: subcategory.image);
                                },
                              )
                              : Center(
                                child: Text(
                                  "No subcategories available",
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                        ],
                      ),
                    )
                    : Container(),
          ),
        ],
      ),
    );
  }
}
