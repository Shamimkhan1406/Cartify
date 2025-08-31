import 'package:cartify/controllers/order_controller.dart';
import 'package:cartify/models/order.dart';
import 'package:cartify/provider/order_provider.dart';
import 'package:cartify/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  void initState() {
    super.initState();
    // fetch orders when the screen is initialized
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    final user = ref.read(userProvider);
    if (user != null) {
      // fetch orders using the user id
      // final orders = await OrderController().fetchOrders(user.id);
      // update the order provider with the fetched orders
      // ref.read(orderProvider.notifier).setOrders(orders);
      final OrderController orderController = OrderController();
      try {
        final orders = await orderController.loadOrders(buyerId: user.id);
        ref.read(orderProvider.notifier).setOrders(orders);
      } catch (e) {
        print('Error fetching orders: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(orderProvider);
    return Scaffold(
      body:
          orders.isEmpty
              ? const Center(child: Text('No orders found'))
              : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final Order order = orders[index];
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Container(
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
                                          color: const Color.fromARGB(
                                            255,
                                            246,
                                            215,
                                            251,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Positioned(
                                              top: 5,
                                              left: 10,
                                              child: Image.network(
                                                order.image,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      width: double.infinity,
                                                      child: Text(
                                                        order.productName,
                                                        style:
                                                            GoogleFonts.montserrat(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              height: 1.1,
                                                            ),
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        order.category,
                                                        style:
                                                            GoogleFonts.montserrat(
                                                              fontSize: 12,
                                                              color:
                                                                  const Color(
                                                                    0xff9e9e9e,
                                                                  ),
                                                              height: 1.1,
                                                            ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,

                                                      child: Text(
                                                        'Quantity: ${order.quantity}',
                                                        style:
                                                            GoogleFonts.montserrat(
                                                              fontSize: 12,
                                                              color:
                                                                  const Color(
                                                                    0xff9e9e9e,
                                                                  ),
                                                              height: 1.1,
                                                            ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      '₹${order.productPrice}',
                                                      style:
                                                          GoogleFonts.montserrat(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            height: 1.1,
                                                            color: const Color(
                                                              0xff4caf50,
                                                            ),
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
                                              order.delivered == true
                                                  ? Colors.green
                                                  : order.processing == true
                                                  ? Colors.purpleAccent
                                                  : Colors.red,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Positioned(
                                              left: 9,
                                              top: 2,
                                              child: Text(
                                                order.delivered == true
                                                    ? 'Delivered'
                                                    : order.processing == true
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
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  // ListTile(
                  //   leading: Image.network(order.image, width: 50, height: 50, fit: BoxFit.cover),
                  //   title: Text(order.productName),
                  //   subtitle: Text('Quantity: ${order.quantity}\nPrice: \$${order.productPrice}'),
                  //   isThreeLine: true,
                  // );
                },
              ),
    );
  }
}
