import 'package:cartify/models/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;

  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Image.network(
                  product.images[0],
                  height: 170,
                  width: 170,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  right: 4,
                  top: 15,
                  child: Image.asset(
                    'assets/icons/love.png',
                    width: 26,
                    height: 26,
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Image.asset(
                    'assets/icons/cart.png',
                    width: 26,
                    height: 26,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(
            product.productName,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 4),
          Text(product.category,
              style: GoogleFonts.quicksand(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey,
              ))
        ],
      ),
    );
  }
}
