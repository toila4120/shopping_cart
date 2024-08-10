import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/Models/Cart.dart';
import 'package:shopping_cart/Service/CartEvent.dart';
import 'package:shopping_cart/Service/CartState.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(cartItems: [])) {
    on<AddToCart>((event, emit) {
      final currentCartItems = List<Cart>.from(state.cartItems);
      final existingCartItemIndex = currentCartItems.indexWhere(
        (item) => item.product.id == event.cartItem.product.id,
      );

      if (existingCartItemIndex != -1) {
        final existingCartItem = currentCartItems[existingCartItemIndex];
        existingCartItem.quantity += event.cartItem.quantity;
      } else {
        currentCartItems.add(event.cartItem);
      }

      emit(CartState(cartItems: currentCartItems));
    });

    on<RemoveFromCart>((event, emit) {
      final currentCartItems = state.cartItems
          .where((item) => item.product.id != event.productId)
          .toList();
      emit(CartState(cartItems: currentCartItems));
    });

    on<UpdateQuantity>((event, emit) {
      final currentCartItems = List<Cart>.from(state.cartItems);
      final cartItemIndex = currentCartItems.indexWhere(
        (item) => item.product.id == event.productId,
      );

      if (cartItemIndex != -1) {
        final cartItem = currentCartItems[cartItemIndex];
        cartItem.quantity = event.quantity;
      }

      emit(CartState(cartItems: currentCartItems));
    });
  }

  int get totalCartItemsCount {
    return state.cartItems
        .fold(0, (total, cartItem) => total + cartItem.quantity);
  }
}
