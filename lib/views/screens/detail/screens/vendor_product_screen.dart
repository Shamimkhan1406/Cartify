import 'package:cartify/controllers/product_controller.dart';
import 'package:cartify/models/vendor_model.dart';
import 'package:cartify/provider/vendor_product_provider.dart';
import 'package:cartify/views/screens/nav_screens/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class VendorProductScreen extends ConsumerStatefulWidget {
  final Vendor vendor;
  const VendorProductScreen({super.key, required this.vendor});

  @override
  ConsumerState<VendorProductScreen> createState() =>
      _VendorProductScreenState();
}

class _VendorProductScreenState extends ConsumerState<VendorProductScreen> {
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
      final products = await productController.loadVendorProduct(
        widget.vendor.id,
      );
      ref.read(vendorProductProvider.notifier).setProducts(products);
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
    final products = ref.watch(vendorProductProvider);
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.2,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 118,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/icons/cartb.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 322,
                top: 52,
                child: Stack(
                  children: [
                    Image.asset("assets/icons/not.png", width: 25, height: 25),
                    Positioned(
                      top: 0,
                      right: 0,

                      child: Container(
                        height: 20,
                        width: 20,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 250, 201),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            products.length.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 61,
                top: 51,
                child: Text(
                  widget.vendor.fullName.toUpperCase(),
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
      
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              widget.vendor.storeImage!.isNotEmpty
                  ? CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.vendor.storeImage!),
                  )
                  : CircleAvatar(
                    radius: 50,
                    child: Text(
                      widget.vendor.fullName[0].toUpperCase(),
                      style: GoogleFonts.lato(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              widget.vendor.storeDescription!.isEmpty
                  ? Text('')
                  : Text(
                    widget.vendor.storeDescription!,
                    style: GoogleFonts.lato(fontSize: 16),
                  ),
              const SizedBox(height: 10),
              Divider(thickness: 1, color: Colors.grey),
              const SizedBox(height: 10),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        products.isEmpty
                            ? const Center(child: Text('No products found'))
                            : GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: products.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    childAspectRatio: childAspectRatio,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                  ),
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return ProductItemWidget(product: product);
                              },
                            ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
