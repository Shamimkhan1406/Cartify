import 'package:cartify/controllers/order_controller.dart';
import 'package:cartify/provider/cart_provider.dart';
import 'package:cartify/provider/user_provider.dart';
import 'package:cartify/views/screens/detail/screens/shipping_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final OrderController _orderController = OrderController();
  String selectedPaymentMethod = 'stripe'; // Default payment method
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    // Fetch the cart items from the cart provider
    final cartData = ref.watch(cartProvider);
    final _cartProvider = ref.read(cartProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShippingAddressScreen(),
                    ),
                  );
                },
                child: SizedBox(
                  width: 335,
                  height: 74,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 335,
                          height: 74,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color.fromARGB(255, 168, 137, 255),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 70,
                        top: 17,
                        child: SizedBox(
                          width: 215,
                          height: 41,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: -1,
                                top: -1,
                                child: SizedBox(
                                  width: 219,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          width: 114,
                                          child:
                                              user!.state.isNotEmpty
                                                  ? Text(
                                                    'Address',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      height: 1.1,
                                                    ),
                                                  )
                                                  : Text(
                                                    'Add address',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      height: 1.1,
                                                    ),
                                                  ),
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child:
                                            user.state.isNotEmpty
                                                ? Text(
                                                  user.locality,
                                                  style: GoogleFonts.lato(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                                : Text(
                                                  'India',
                                                  style: GoogleFonts.lato(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child:
                                            user.city.isNotEmpty
                                                ? Text(
                                                  user.city,
                                                  style: GoogleFonts.lato(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.blueGrey,
                                                  ),
                                                )
                                                : Text(
                                                  'Enter City',
                                                  style: GoogleFonts.lato(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.blueGrey,
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
                        left: 16,
                        top: 16,
                        child: SizedBox.square(
                          dimension: 42,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 43,
                                  height: 43,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      237,
                                      231,
                                      253,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        left: 9,
                                        top: 9,
                                        child: Image.network(
                                          height: 26,
                                          width: 26,
                                          'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F2ee3a5ce3b02828d0e2806584a6baa88.png',
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
                        left: 305,
                        top: 25,
                        child: Image.network(
                          width: 20,
                          height: 20,
                          'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F6ce18a0efc6e889de2f2878027c689c9caa53feeedit%201.png?alt=media&token=a3a8a999-80d5-4a2e-a9b7-a43a7fa8789a',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Your items',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              SizedBox(height: 10),
              Flexible(
                child: ListView.builder(
                  itemCount: cartData.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final cartItem = cartData.values.toList()[index];
                    return InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Container(
                          width: 316,
                          height: 91,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color.fromARGB(255, 168, 137, 255),
                            ),
                          ),
                          child: Stack(
                            clipBehavior: Clip.hardEdge,
                            children: [
                              Positioned(
                                left: 6,
                                top: 6,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 78,
                                      height: 78,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9),
                                        color: const Color.fromARGB(
                                          255,
                                          214,
                                          199,
                                          255,
                                        ),
                                      ),
                                      child: Image.network(
                                        cartItem.images[0],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      height: 78,
                                      alignment: Alignment(0, -0.51),
                                      child: SizedBox(
                                        //width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              //width: double.infinity,
                                              child: Text(
                                                cartItem.productName,
                                                style: GoogleFonts.lato(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1.3,
                                                ),
                                                //overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                cartItem.category,
                                                style: GoogleFonts.lato(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.blueGrey,
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
                              Positioned(
                                left: 270,
                                top: 30,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '₹ ${cartItem.productPrice.toStringAsFixed(2)}',
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              //SizedBox(height: 10),
              Text(
                'Choose payment method',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              SizedBox(height: 10),
              RadioListTile<String>(
                title: Text(
                  'Stripe',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: 'stripe',
                groupValue: selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text(
                  'Cash on Delivery',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: 'cashOnDelivery',
                groupValue: selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            //ref.watch(userProvider)!.state == ""
            user.state.isEmpty
                ? TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShippingAddressScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Please enter your address",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 168, 137, 255),
                    ),
                  ),
                )
                : InkWell(
                  onTap: () async {
                    if (selectedPaymentMethod == 'stripe') {
                      // Handle Stripe payment logic here
                      // For example, navigate to a Stripe payment screen
                    } else {
                      // Handle Cash on Delivery logic here
                      // For example, place the order directly
                      await Future.forEach(_cartProvider.getCartItems.entries, (
                        entry,
                      ) {
                        var item = entry.value;
                        _orderController.uploadOrder(
                          id: '',
                          fullName: ref.read(userProvider)!.fullName,
                          email: ref.read(userProvider)!.email,
                          state:
                              "west bengal", // You can replace this with actual state
                          city:
                              "kolkata", // You can replace this with actual city
                          locality:
                              "sector 5", // You can replace this with actual locality
                          //state: ref.read(userProvider)!.state,
                          //city: ref.read(userProvider)!.city,
                          //locality: ref.read(userProvider)!.locality,
                          productName: item.productName,
                          productPrice: item.productPrice,
                          quantity: item.quantity,
                          category: item.category,
                          image: item.images[0],
                          buyerId: ref.read(userProvider)!.id,
                          vendorId: item.vendorId,
                          processing: true,
                          delivered: false,
                          context: context,
                        );
                      });
                    }
                  },

                  child: Container(
                    width: 338,
                    height: 58,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 168, 137, 255),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        selectedPaymentMethod == 'stripe'
                            ? 'Pay now'
                            : 'Place order',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
      ),
    );
  }
}
