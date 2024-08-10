import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/Screen/CartScreen/Widget/CardProduct.dart';
import 'package:shopping_cart/Screen/CartScreen/Widget/order_dialog.dart';
import 'package:shopping_cart/Service/CartBloc.dart';
import 'package:shopping_cart/Models/Cart.dart';
import 'package:shopping_cart/Service/CartEvent.dart';
import 'package:shopping_cart/Service/CartState.dart';

class CartScreen extends StatefulWidget {
  int cartItemCount;
  CartScreen({super.key, required this.cartItemCount});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Cart> listCart = [];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 171, 64),
        centerTitle: true,
        title: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            int cartItemCount = state.cartItems
                .fold(0, (total, cartItem) => total + cartItem.quantity);
            return Text('Cart ($cartItemCount)');
          },
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.cartItems.isEmpty) {
            return const Center(
              child: Text('Your cart is empty'),
            );
          }

          double totalPrice = state.cartItems.fold(0, (total, item) {
            return total + (item.product.price * item.quantity);
          });

          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = state.cartItems[index];
                      return CardProduct(
                          key: ValueKey(cartItem.product.id), item: cartItem);
                    },
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 240, 236, 236)),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total price:'),
                          Text('\$${totalPrice.toStringAsFixed(2)}'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: width * 0.9,
                        child: ElevatedButton(
                          onPressed: () async {
                            context.read<CartBloc>().add(RemoveCart());
                            showDialog(
                              context: context,
                              builder: (context) => const OrderDialog(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Order'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
