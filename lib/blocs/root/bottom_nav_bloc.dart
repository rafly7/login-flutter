import 'dart:async';

import 'package:bloc/bloc.dart';
abstract class NumberIndex {

}

class BottomNavigationInitial extends NumberIndex {}

class BottomNavigationSuccess extends NumberIndex {
  final int result;
  BottomNavigationSuccess(this.result);
}

class BottomNavigationEvent {
  final int index;
  BottomNavigationEvent(this.index);
}

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, NumberIndex> {
  
  @override
  NumberIndex get initialState => BottomNavigationInitial();

  @override
  Stream<NumberIndex> mapEventToState(BottomNavigationEvent event) async* {
    switch (event.index) {
      case 0:
        yield BottomNavigationSuccess(0);
        break;
      case 1:
        yield BottomNavigationSuccess(1);
        break;
      case 2:
        yield BottomNavigationSuccess(2);
        break;
    }
  }
}