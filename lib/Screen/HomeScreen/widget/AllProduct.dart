import 'package:flutter/material.dart';
import 'package:shopping_cart/Models/Product.dart';
import 'package:shopping_cart/Widget/BottomSheet.dart';

class GridItemProduct extends StatelessWidget {
  final Product product;

  const GridItemProduct({
    super.key,
    required this.product,
  });

  void _showBottomSheet(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Bottomsheet(item: product);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              product.image,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      product.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${product.price} VND',
                      style:
                          const TextStyle(color: Colors.orange, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  _showBottomSheet(context, product);
                },
                icon: const Icon(
                  Icons.add_shopping_cart,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
