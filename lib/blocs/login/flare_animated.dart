import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AnimatedLoginEvents { idle, test, success, fail}

class AnimatedLoginBloc extends Bloc<AnimatedLoginEvents, String> {

  @override
  String get initialState => "idle";

  @override
  Stream<String> mapEventToState(AnimatedLoginEvents event) async* {
    switch (event) {
      case AnimatedLoginEvents.idle:
        yield 'idle';
        break;
      case AnimatedLoginEvents.test:
        yield 'test';
        break;
      case AnimatedLoginEvents.success:
        yield 'success';
        break;
      case AnimatedLoginEvents.fail:
        yield 'fail';
        break;
    }
  }
}