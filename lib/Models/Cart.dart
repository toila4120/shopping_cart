import 'package:shopping_cart/Models/Product.dart';

class Cart {
  Product product;
  int quantity;

  Cart(this.product, this.quantity);

  double get totalPrice => product.price * quantity;
}
