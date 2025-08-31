import 'package:cartify/controllers/order_controller.dart';
import 'package:cartify/models/order.dart';
import 'package:cartify/provider/order_provider.dart';
import 'package:cartify/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  Future<void> fetchOrders() async{
    final user = ref.read(userProvider);
    if (user != null){
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
      body: orders.isEmpty
          ? const Center(
              child: Text('No orders found'),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final Order order = orders[index];
                return ListTile(
                  leading: Image.network(order.image, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(order.productName),
                  subtitle: Text('Quantity: ${order.quantity}\nPrice: \$${order.productPrice}'),
                  isThreeLine: true,
                );
              },
            ),
    );
  }
}