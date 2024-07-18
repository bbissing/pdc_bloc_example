import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ColorEvent {}

class ColorChange extends ColorEvent {
  @override
  String toString() {
    return 'Color Changed!';
  }
}

class ColorBLoC extends Bloc<ColorEvent, MaterialColor> {
  ColorBLoC() : super(Colors.blue) {
    on<ColorChange>((event, emit) => emit(Colors.primaries[Random().nextInt(Colors.primaries.length)]));
  }

  @override
  void onTransition(Transition<ColorEvent, MaterialColor> transition) {
    print(transition);

    super.onTransition(transition);
  }
}