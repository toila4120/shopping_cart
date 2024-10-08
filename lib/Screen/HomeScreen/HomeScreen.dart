import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/Screen/CartScreen/CartScreen.dart';
import 'package:shopping_cart/Screen/HomeScreen/widget/AllProduct.dart';
import 'package:shopping_cart/Screen/HomeScreen/widget/HotProduct.dart';
import 'package:shopping_cart/Models/Product.dart';
import 'package:shopping_cart/Database/data.dart';
import 'package:shopping_cart/Service/CartBloc.dart';
import 'package:shopping_cart/Service/CartState.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  int cartItemCount = 0;
  List<Product> listProduct = [];

  @override
  void initState() {
    super.initState();
    _loadData(2);
  }

  Future<void> _loadData(int time) async {
    await Future.delayed(Duration(seconds: time));
    listProduct = products;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 171, 64),
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartScreen(
                              cartItemCount: cartItemCount,
                            )),
                  );
                },
              ),
              BlocListener<CartBloc, CartState>(
                listenWhen: (previous, current) {
                  final previousTotalQuantity = previous.cartItems
                      .fold(0, (total, cartItem) => total + cartItem.quantity);

                  final currentTotalQuantity = current.cartItems
                      .fold(0, (total, cartItem) => total + cartItem.quantity);
                  return previousTotalQuantity != currentTotalQuantity;
                },
                listener: (context, state) {
                  setState(() {
                    cartItemCount =
                        context.read<CartBloc>().totalCartItemsCount;
                  });
                },
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return cartItemCount > 0
                        ? Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '$cartItemCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : Container();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16, top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'HOT Products 🔥',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 239, 108, 0)),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                        width: size,
                        height: 215,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: listProduct.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final item = listProduct[index];
                            return Hotproduct(
                              item: item,
                            );
                          },
                        )),
                    const SizedBox(height: 20),
                    const Text(
                      'All Products',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 239, 108, 0)),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listProduct.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 250),
                        itemBuilder: (context, index) {
                          final item = listProduct[index];
                          return GridItemProduct(
                            product: item,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
