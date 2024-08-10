import 'package:equatable/equatable.dart';
import 'package:shopping_cart/Models/Cart.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final Cart cartItem;

  AddToCart(this.cartItem);

  @override
  List<Object?> get props => [cartItem];
}

class RemoveFromCart extends CartEvent {
  final int productId;

  RemoveFromCart(this.productId);

  @override
  List<Object?> get props => [productId];
}

class RemoveCart extends CartEvent {
  RemoveCart();
}

class UpdateQuantity extends CartEvent {
  final int productId;
  final int quantity;

  UpdateQuantity({required this.productId, required this.quantity});

  @override
  List<Object?> get props => [productId, quantity];
}
