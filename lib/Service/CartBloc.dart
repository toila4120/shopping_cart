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
        final updatedQuantity =
            existingCartItem.quantity + event.cartItem.quantity;

        currentCartItems.removeAt(existingCartItemIndex);

        final updatedCartItem = Cart(existingCartItem.product, updatedQuantity);
        currentCartItems.add(updatedCartItem);
      } else {
        currentCartItems.add(event.cartItem);
      }

      emit(CartState(cartItems: currentCartItems));
    });

    on<RemoveFromCart>((event, emit) {
      final updatedCartItems = state.cartItems
          .where((item) => item.product.id != event.productId)
          .toList();
      emit(CartState(cartItems: updatedCartItems));
    });

    on<UpdateQuantity>((event, emit) {
      final currentCartItems = List<Cart>.from(state.cartItems);

      final existingCartItemIndex = currentCartItems.indexWhere(
        (item) => item.product.id == event.productId,
      );

      if (existingCartItemIndex != -1) {
        final updatedCartItem = Cart(
          currentCartItems[existingCartItemIndex].product,
          event.quantity,
        );
        currentCartItems[existingCartItemIndex] = updatedCartItem;
      }

      emit(CartState(cartItems: currentCartItems));
    });

    on<RemoveCart>(
      (event, emit) {
        emit(const CartState(cartItems: []));
      },
    );
  }

  int get totalCartItemsCount {
    return state.cartItems
        .fold(0, (total, cartItem) => total + cartItem.quantity);
  }
}
