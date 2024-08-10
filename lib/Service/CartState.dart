import 'package:equatable/equatable.dart';
import 'package:shopping_cart/Models/Cart.dart';

class CartState extends Equatable {
  final List<Cart> cartItems;

  const CartState({required this.cartItems});

  @override
  List<Object?> get props => [cartItems];
}
