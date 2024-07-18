import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CounterEvent {}

class CounterIncrementPressedEvent extends CounterEvent {
  @override
  String toString() {
    return 'Count goes up!';
  }
}

class CounterDecrementPressedEvent extends CounterEvent {
  @override
  String toString() {
    return 'Count goes down!';
  }
}

class CounterBLoC extends Bloc<CounterEvent, int> {
  CounterBLoC() : super(0) {
    on<CounterIncrementPressedEvent>((event, emit) => emit(state + 1));
    on<CounterDecrementPressedEvent>((event, emit) => emit(state - 1));
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    print(transition);

    super.onTransition(transition);
  }
}
