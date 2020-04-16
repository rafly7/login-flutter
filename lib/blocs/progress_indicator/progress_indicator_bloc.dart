import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

enum ProgressIndicatorEvents { show, hide }

class ProgressIndicatorBloc extends Bloc<ProgressIndicatorEvents, bool> {

  @override
  bool get initialState => false;

  @override
  Stream<bool> mapEventToState(ProgressIndicatorEvents event) async* {
    switch(event) {
      case ProgressIndicatorEvents.hide:
        yield false;
        break;
      case ProgressIndicatorEvents.show:
        yield true;
        break;
    }
  }
}
