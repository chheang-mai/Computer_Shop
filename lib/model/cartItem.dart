import 'package:computer_shop/model/product.dart';

class CartItem {
  final Product product;
  int qty;

  CartItem({required this.product, required this.qty});
}
