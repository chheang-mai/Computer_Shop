import 'package:bloc/bloc.dart';
import 'package:computer_shop/view/bottom_navbar.dart';
import 'package:meta/meta.dart';



part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super( BottomNavState(index: 0)) {
    on<SelectedBottomNav>((event, emit) {
      emit(BottomNavState(index: event.index));
    });
  }
}

