import 'package:flutter/material.dart';

class OrderDialog extends StatelessWidget {
  const OrderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Order Successful'),
      content: const Text('Your order has been placed successfully!'),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
          ),
          child: const Text('Back to Home'),
        ),
      ],
    );
  }
}
