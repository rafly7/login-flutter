import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smm_project/blocs/login/flare_animated.dart';
import 'package:smm_project/blocs/progress_indicator/progress_indicator_bloc.dart';
import 'package:smm_project/widgets/authenticate/button_authenticate.dart';
import 'package:smm_project/widgets/authenticate/login_authenticate.dart';

class AuthenticateView extends StatelessWidget {
  const AuthenticateView({Key key}) : super(key: key);

  static const ROUTE = '/authenticate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RoundedButton(
              title: 'Login with form',
              color: Color(0xCCCB81D0),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  // return BlocProvider(
                  //   create: (_) => ProgressIndicatorBloc(),
                  //   child: AuthenticateLogin(),
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (_) => ProgressIndicatorBloc(),
                      ),
                      BlocProvider(
                        create: (_) => AnimatedLoginBloc(),
                      )
                    ],
                    child: AuthenticateLogin()
                  );
                }));
              }
            ),
            RoundedButton(
              title: 'Login with Gmail',
              color: Color(0xCCCB81D0),
              onPressed: () {}
            ),
          ],
        ),
      )
    );
  }
}