import 'package:cartify/models/order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order orders;
  const OrderDetailScreen({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          orders.productName,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            height: 1.1,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: 335,
            height: 153,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(),
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 335,
                      height: 153,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xffe0e0e0),
                          width: 1,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3f000000),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 13,
                            top: 9,
                            child: Container(
                              width: 78,
                              height: 78,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 246, 215, 251),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    top: 5,
                                    left: 10,
                                    child: Image.network(
                                      orders.image,
                                      width: 58,
                                      height: 67,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 101,
                            top: 14,

                            child: SizedBox(
                              width: 216,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              orders.productName,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                height: 1.1,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              orders.category,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: const Color(0xff9e9e9e),
                                                height: 1.1,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Align(
                                            alignment: Alignment.centerLeft,

                                            child: Text(
                                              'Quantity: ${orders.quantity}',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: const Color(0xff9e9e9e),
                                                height: 1.1,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '₹${orders.productPrice}',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              height: 1.1,
                                              color: const Color(0xff4caf50),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 13,
                            top: 113,
                            child: Container(
                              width: 100,
                              height: 25,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color:
                                    orders.delivered == true
                                        ? Colors.green
                                        : orders.processing == true
                                        ? Colors.purpleAccent
                                        : Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    left: 9,
                                    top: 2,
                                    child: Text(
                                      orders.delivered == true
                                          ? 'Delivered'
                                          : orders.processing == true
                                          ? 'Processing'
                                          : 'Cancelled',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 12,
                                        letterSpacing: 1.3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 115,
                            left: 298,
                            child: Image.asset(
                              'assets/icons/delete.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
