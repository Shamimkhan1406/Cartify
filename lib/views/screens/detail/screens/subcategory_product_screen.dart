import 'package:cartify/controllers/product_controller.dart';
import 'package:cartify/models/subcategory.dart';
import 'package:cartify/provider/subcategory_product_provider.dart';
import 'package:cartify/views/screens/nav_screens/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubcategoryProductScreen extends ConsumerStatefulWidget {
  final SubCategory subCategory;

  const SubcategoryProductScreen({super.key, required this.subCategory});

  @override
  ConsumerState<SubcategoryProductScreen> createState() => _SubcategoryProductScreenState();
}

class _SubcategoryProductScreenState extends ConsumerState<SubcategoryProductScreen> {
  bool isLoading = true;
  // a Future that will hold the list of popular products
  //late Future<List<Product>> futurePopularProductsFuture;
  @override
  void initState() {
    super.initState();
    //futurePopularProductsFuture = ProductController().loadPopularProducts();

    _fetchProducts();

    // final products = ref.read(subcategoryProductProvider);
    // if (products.isEmpty) {
    //  _fetchProducts();
    // }
    // else{
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
  }

  Future<void> _fetchProducts() async {
    final ProductController productController = ProductController();
    try {
      final products = await productController.loadProductsBySubCategory(widget.subCategory.subCategoryName);
      ref.read(subcategoryProductProvider.notifier).setProducts(products);
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(subcategoryProductProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    // set the crossAxisCount based on screen width
    // if screen width is less than 600, set crossAxisCount to 2
    // if screen width is greater than 600, set crossAxisCount to 4
    final crossAxisCount = screenWidth < 600 ? 2 : 4;
    // set the expect ration (screen to height ) of each grid based on the screen width
    // for smaller screen, set the expect ratio to 3.4 taller items
    // for larger screen, set the expect ratio to 4.5 square items
    final childAspectRatio = screenWidth < 600 ? 3/4 : 4/5;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subCategory.subCategoryName),
      ),
      body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
          padding: const EdgeInsets.all(8.0),
          child: products.isEmpty ? const Center(child: Text('No products found')) : GridView.builder( itemCount: products.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, childAspectRatio: childAspectRatio, mainAxisSpacing: 8, crossAxisSpacing: 8), itemBuilder: (context, index){
            final product = products[index];
            return ProductItemWidget(product: product);
          }),
        )
    );
  }
}