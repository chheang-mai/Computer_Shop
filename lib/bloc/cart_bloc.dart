import 'package:bloc/bloc.dart';
import 'package:computer_shop/bloc/counter_bloc.dart';
import 'package:computer_shop/model/product.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState(cartList: [])) {
    on<AddToCart>((event, emit) {
      emit(
        CartState(cartList: [...state.cartList, event.item]),
      );
    });
    on<Increments>((event, emit) {
      state.cartList[event.index].stock=state.cartList[event.index].stock!+1;
      emit(CartState(cartList: state.cartList));
    
    }
  );
   on<Decrements>((event, emit) {
      state.cartList[event.index].stock=state.cartList[event.index].stock!-1;
      emit(CartState(cartList: state.cartList));
    
    }
  );

    on<RemoveFromCart>((event, emit) {
      emit(
        CartState(
          cartList: state.cartList
              .where((p) => p.id != event.productId)
              .toList(),
        ),
      );
    });

    on<ClearCart>((event, emit) {
      emit(const CartState(cartList: []));
    });
  }
}
