import 'package:cartify/models/product.dart';
import 'package:cartify/provider/cart_provider.dart';
import 'package:cartify/provider/favorite_provider.dart';
import 'package:cartify/services/manage_http_response.dart';
import 'package:cartify/views/screens/detail/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductItemWidget extends ConsumerStatefulWidget {
  final Product product;

  const ProductItemWidget({super.key, required this.product});

  @override
  ConsumerState<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends ConsumerState<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    final cartProviderData = ref.read(cartProvider.notifier);
    final cartData = ref.watch(cartProvider);
    final isInCart = cartData.containsKey(widget.product.id);
    final favoriteProviderData = ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: widget.product),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.blueGrey,
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Image.network(
                      widget.product.images[0],
                      height: 170,
                      width: 170,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 5,
                    child: InkWell(
                      onTap: () {
                        favoriteProviderData.addFavorite(
                          productName: widget.product.productName,
                          productPrice: widget.product.productPrice,
                          category: widget.product.category,
                          images: widget.product.images,
                          vendorId: widget.product.vendorId,
                          productQuantity: widget.product.quantity,
                          quantity: 1,
                          productId: widget.product.id,
                          description: widget.product.description,
                          fullName: widget.product.fullName,
                        );
                        showSnackBar(
                          context,
                          'added ${widget.product.productName} to favorites',
                        );
                      },
                      child:
                          favoriteProviderData.getFavoriteItems.containsKey(
                                widget.product.id,
                              )
                              ? Icon(Icons.favorite, color: Colors.red)
                              : Icon(Icons.favorite_border, color: Colors.grey),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: InkWell(
                      onTap:
              isInCart
                  ? null
                  : () {
                    cartProviderData.addProductToCart(
                      productName: widget.product.productName,
                      productPrice: widget.product.productPrice,
                      category: widget.product.category,
                      images: widget.product.images,
                      vendorId: widget.product.vendorId,
                      productQuantity: widget.product.quantity,
                      quantity: 1,
                      productId: widget.product.id,
                      description: widget.product.description,
                      fullName: widget.product.fullName,
                    );
                    showSnackBar(
                      context,
                      '${widget.product.productName} added to cart',
                    );
                  },
                      child: Image.asset(
                        'assets/icons/cart.png',
                        width: 26,
                        height: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2),
            Text(
              widget.product.productName,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            widget.product.avgRating == 0
                ? const SizedBox()
                : Row(
                  children: [
                    Icon(Icons.star, size: 16, color: Colors.amber),
                    Text(
                      widget.product.avgRating.toStringAsFixed(1),
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
            SizedBox(height: 1),
            Text(
              widget.product.category,
              style: GoogleFonts.quicksand(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 1),
            Text(
              '₹${widget.product.productPrice.toStringAsFixed(2)}',
              style: GoogleFonts.roboto(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
