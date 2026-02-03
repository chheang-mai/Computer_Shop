part of 'cart_bloc.dart';

@immutable
class CartState {
 
  final List<Product> cartList;

  const CartState({required this.cartList});
}
