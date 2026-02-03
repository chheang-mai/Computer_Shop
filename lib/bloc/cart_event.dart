part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddToCart extends CartEvent {
  // int count;
  final Product item;
  AddToCart({required this.item});
}
class Increments extends CartEvent{
  int index;
  Increments({required this.index});
}
class Decrements extends CartEvent{
  int index;
  Decrements({required this.index});
}


class RemoveFromCart extends CartEvent {
  final int productId;
  RemoveFromCart({required this.productId});
}

class ClearCart extends CartEvent {}
