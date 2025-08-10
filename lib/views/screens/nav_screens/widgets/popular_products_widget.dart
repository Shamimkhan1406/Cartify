import 'package:cartify/controllers/product_controller.dart';
import 'package:cartify/models/product.dart';
import 'package:cartify/views/screens/nav_screens/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';

class PopularProductsWidget extends StatefulWidget {
  const PopularProductsWidget({super.key});

  @override
  State<PopularProductsWidget> createState() => _PopularProductsWidgetState();
}

class _PopularProductsWidgetState extends State<PopularProductsWidget> {
  // a Future that will hold the list of popular products
  late Future<List<Product>> futurePopularProductsFuture;
  @override
  void initState() {
    super.initState();
    futurePopularProductsFuture = ProductController().loadPopularProducts();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: futurePopularProductsFuture, builder: (context, snapshot){
      if (snapshot.connectionState==ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator());
      }
      else if (snapshot.hasError){
        return Center(child: Text('Error: ${snapshot.error}'));
      }
      else if (!snapshot.hasData || snapshot.data!.isEmpty){
        return const Center(child: Text('No popular products found'));
      }
      else{
        final products = snapshot.data!;
        return SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductItemWidget(product: product,);
            },
          ),
        );

      }
    });
  }
}