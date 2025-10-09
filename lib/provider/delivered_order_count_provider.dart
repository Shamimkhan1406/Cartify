// state notifier for delivered order count

import 'package:cartify/controllers/order_controller.dart';
import 'package:cartify/services/manage_http_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeliveredOrderCountNotifier extends StateNotifier<int> {
  DeliveredOrderCountNotifier() : super(0);

  // methode to fetch delivered order count
  Future<void> fetchDeliveredOrderCount(String buyerId, BuildContext context) async {
    try {
      OrderController orderController = OrderController();
      int count = await orderController.countDeliveredOrders(buyerId: buyerId);
      state = count;
    
    } catch (e) {
      showSnackBar(context, 'Error fetching delivered order count: $e');
    }
  }
}

final deliveredOrderCountProvider = StateNotifierProvider<DeliveredOrderCountNotifier, int>(
  (ref) => DeliveredOrderCountNotifier(),
);