import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smm_project/views/authenticate/index_authenticate.dart';
import 'package:smm_project/views/root/index_root.dart';

import 'blocs/simple_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AuthenticateView.ROUTE,
      routes: {
        AuthenticateView.ROUTE: (_) => AuthenticateView(),
        RootView.ROUTE: (_) => RootView(),
      },
    );
  }
}