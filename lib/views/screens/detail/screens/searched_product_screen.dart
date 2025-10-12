import 'package:cartify/controllers/product_controller.dart';
import 'package:cartify/models/product.dart';
import 'package:cartify/views/screens/nav_screens/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';

class SearchedProductScreen extends StatefulWidget {
  const SearchedProductScreen({super.key});

  @override
  State<SearchedProductScreen> createState() => _SearchedProductScreenState();
}

class _SearchedProductScreenState extends State<SearchedProductScreen> {
  final TextEditingController searchController = TextEditingController();
    final ProductController productController = ProductController();
    List<Product> searchedProducts = [];
    bool isLoading = false;
    void _searchProducts() async {
      setState(() {
        isLoading = true;
      });
      try {
        final query = searchController.text.trim();
        if (query.isNotEmpty) {
          final products = await productController.searchProducts(query);
          setState(() {
            searchedProducts = products;
          });
        }
      } catch (e) {
        print('Error searching products: $e');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // set the crossAxisCount based on screen width
    // if screen width is less than 600, set crossAxisCount to 2
    // if screen width is greater than 600, set crossAxisCount to 4
    final crossAxisCount = screenWidth < 600 ? 2 : 4;
    // set the expect ration (screen to height ) of each grid based on the screen width
    // for smaller screen, set the expect ratio to 3.4 taller items
    // for larger screen, set the expect ratio to 4.5 square items
    final childAspectRatio = screenWidth < 600 ? 3 / 4 : 4 / 5;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            labelText: 'Search products...',
            suffixIcon: IconButton(
              onPressed: _searchProducts,
              icon: Icon(Icons.search),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          if (isLoading)
            Center(child: CircularProgressIndicator())
          else if (searchedProducts.isEmpty)
            Center(child: Text('No products found'))
          else
            Expanded(
              child: GridView.builder(
                itemCount: searchedProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final product = searchedProducts[index];
                  return ProductItemWidget(product: product);
                },
              ),
            ),
        ],
      ),
    );
  }
}
