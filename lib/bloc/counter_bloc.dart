import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(count: 1)) {
    on<Increment>((event, emit) {
      emit(CounterState(count: state.count+1));
    });

    on<Decrement>((event, emit) {
      if(state.count>1){
         emit(CounterState(count:  state.count - 1));
      }
     
    });
    on<ResetCounter>((event, emit) => {
      emit( CounterState(count: 1))
    },);
  }
}
