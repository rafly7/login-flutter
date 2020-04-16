import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:smm_project/blocs/login/flare_animated.dart';
import 'package:smm_project/blocs/progress_indicator/progress_indicator_bloc.dart';
import 'package:smm_project/widgets/authenticate/button_authenticate.dart';
import 'package:smm_project/widgets/authenticate/text_form_field.dart';

class AuthenticateLogin extends StatefulWidget {
  AuthenticateLogin({Key key}) : super(key: key);

  final spinkit = SpinKitFoldingCube(
    color: Color(0xBBB02CB9),
    size: 50.0,
  );

  @override
  _AuthenticateLoginState createState() => _AuthenticateLoginState();
}

class _AuthenticateLoginState extends State<AuthenticateLogin> {

  final password = TextEditingController();
  final passwordFN = FocusNode();
  AnimatedLoginBloc _animateLoginBloc;
  bool hidden = true;
  
  @override
  void initState() { 
    passwordFN.addListener(() {
      if(passwordFN.hasFocus) {
        _animateLoginBloc.add(AnimatedLoginEvents.test);
      } else {
        _animateLoginBloc.add(AnimatedLoginEvents.idle);
      }
    });
    super.initState();
  }

  @override
  void dispose() { 
    passwordFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final _progressIndicatorBloc =
        BlocProvider.of<ProgressIndicatorBloc>(context);

    return Scaffold(
      body: BlocBuilder<ProgressIndicatorBloc, bool>(
        builder: (BuildContext context, bool state) {
          return ModalProgressHUD(
            inAsyncCall: state,
            progressIndicator: widget.spinkit,
            child: Center(
              child: SingleChildScrollView(
                child: BlocBuilder<AnimatedLoginBloc, String>(
                  builder: (BuildContext context, String animate) {
                    _animateLoginBloc = BlocProvider.of<AnimatedLoginBloc>(context);
                    return Column(
                      children: <Widget>[
                        //Icon(Icons.)
                        //BlocProvider(
                          //create: (_) => AnimatedLoginBloc(),
                          //child: BlocBuilder<AnimatedLoginBloc, String>(
                            //builder: (BuildContext context, String animate) {
                        Center(
                          child: Container(
                            height: 300,
                            width: 300,
                            child: CircleAvatar(
                              backgroundImage: ExactAssetImage('assets/images/smm.png'),
                              child: ClipOval(
                                child: FlareActor('assets/images/teddy.flr', alignment: Alignment.center, fit: BoxFit.contain, animation: animate,)
                              ),
                            ),
                          )
                        ),
                            //}
                          //),
                        //),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CustomTextFormField(
                            inputType: TextInputType.emailAddress,
                            hintText:'Enter your E-mail',
                            obscureText: false,
                            //prefixIcon: Icon(Icons.email),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: CustomTextFormField(
                            inputType: TextInputType.emailAddress,
                            hintText:'Enter your password',
                            focusNode: passwordFN,
                            controller: password,
                            obscureText: true,
                            //prefixIcon: Icon(Icons.pad),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: RoundedButton(
                            title: 'Login',
                            color: Color(0xBBB02CB9),
                            onPressed: () {
                              if(password.text == '123456') {
                                _animateLoginBloc.add(AnimatedLoginEvents.success);
                                _progressIndicatorBloc.add(ProgressIndicatorEvents.show);
                                _progressIndicatorBloc.close();
                              } else {
                                _animateLoginBloc.add(AnimatedLoginEvents.fail);
                              }                              
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            )
          );
        },
      ),
    );
  }
}