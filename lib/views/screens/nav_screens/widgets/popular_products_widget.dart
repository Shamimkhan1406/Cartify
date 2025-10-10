import 'package:cartify/controllers/product_controller.dart';
import 'package:cartify/provider/product_provider.dart';
import 'package:cartify/views/screens/nav_screens/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularProductsWidget extends ConsumerStatefulWidget {
  const PopularProductsWidget({super.key});

  @override
  ConsumerState<PopularProductsWidget> createState() =>
      _PopularProductsWidgetState();
}

class _PopularProductsWidgetState extends ConsumerState<PopularProductsWidget> {
  bool isLoading = true;
  // a Future that will hold the list of popular products
  //late Future<List<Product>> futurePopularProductsFuture;
  @override
  void initState() {
    super.initState();
    //futurePopularProductsFuture = ProductController().loadPopularProducts();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final ProductController productController = ProductController();
    try {
      final products = await productController.loadPopularProducts();
      ref.read(productProvider.notifier).setProducts(products);
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
    // return FutureBuilder(future: futurePopularProductsFuture, builder: (context, snapshot){
    //   if (snapshot.connectionState==ConnectionState.waiting){
    //     return const Center(child: CircularProgressIndicator());
    //   }
    //   else if (snapshot.hasError){
    //     return Center(child: Text('Error: ${snapshot.error}'));
    //   }
    //   else if (!snapshot.hasData || snapshot.data!.isEmpty){
    //     return const Center(child: Text('No popular products found'));
    //   }
    //   else{
    //     final products = snapshot.data!;
    //     return

    //   }
    // });
    final products = ref.watch(productProvider);
    if (products.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductItemWidget(product: product);
            },
          ),
        );
  }
}
