import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/Models/Cart.dart';
import 'package:shopping_cart/Models/Product.dart';
import 'package:shopping_cart/Service/CartBloc.dart';
import 'package:shopping_cart/Service/CartEvent.dart';
import 'QuantityDialog.dart'; // Import lớp QuantityDialog mới

class Bottomsheet extends StatefulWidget {
  final Product item;
  const Bottomsheet({super.key, required this.item});

  @override
  State<Bottomsheet> createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  late Product item1;
  int dem = 1;

  @override
  void initState() {
    super.initState();
    item1 = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 170,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      item1.image,
                      width: 80,
                      height: 80,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        item1.name,
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
                              setState(() {
                                if (dem > 1) dem--;
                              });
                            },
                          ),
                          TextButton(
                            onPressed: () async {
                              final result = await showDialog<int>(
                                context: context,
                                builder: (context) => QuantityDialog(
                                  initialQuantity: dem,
                                  productName: item1.name,
                                ),
                              );

                              setState(
                                () {
                                  dem = result!;
                                },
                              );
                            },
                            child: Text('$dem'),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                if (dem < 999) dem++;
                              });
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
                          Navigator.of(context).pop();
                        },
                      ),
                      Text(
                        '${item1.price * dem} ₫',
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
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final cartItem = Cart(widget.item, dem);
                    context.read<CartBloc>().add(AddToCart(cartItem));
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Add to cart'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
