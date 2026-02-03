// import 'package:computer_shop/model/cartItem.dart';
// import 'package:computer_shop/model/product.dart';


// class CartStore {
//   static final List<CartItem> items = [];

//   static void add(Product product, int qty) {
//     final id = product.id ?? -1;

//     final index = items.indexWhere((e) => (e.product.id ?? -2) == id);

//     if (index >= 0) {
//       // already in cart -> increase qty
//       items[index].qty += qty;
//     } else {
//       // new product
//       items.add(CartItem(product: product, qty: qty));
//     }
//   }

//   static void clear() => items.clear();
// }
