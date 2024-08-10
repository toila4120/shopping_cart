import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/Models/Cart.dart';
import 'package:shopping_cart/Service/CartBloc.dart';
import 'package:shopping_cart/Service/CartEvent.dart';
import 'package:shopping_cart/Widget/QuantityDialog.dart';

class CardProduct extends StatefulWidget {
  final Cart item;
  const CardProduct({super.key, required this.item});

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  late Cart cart;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    cart = widget.item;
    quantity = cart.quantity;
  }

  void _updateQuantity(int newQuantity) {
    context.read<CartBloc>().add(UpdateQuantity(
          productId: cart.product.id,
          quantity: newQuantity,
        ));
    setState(() {
      quantity = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    cart.product.image,
                    width: 80,
                    height: 80,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cart.product.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (quantity > 1) {
                              _updateQuantity(quantity - 1);
                            }
                          },
                        ),
                        TextButton(
                          onPressed: () async {
                            final result = await showDialog<int>(
                              context: context,
                              builder: (context) => QuantityDialog(
                                initialQuantity: quantity,
                                productName: cart.product.name,
                              ),
                            );

                            if (result != null) {
                              _updateQuantity(result);
                            }
                          },
                          child: Text('$quantity'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            if (quantity < 999) {
                              _updateQuantity(quantity + 1);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        context
                            .read<CartBloc>()
                            .add(RemoveFromCart(cart.product.id));
                      },
                    ),
                    Text(
                      '${cart.product.price * quantity} ₫',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
