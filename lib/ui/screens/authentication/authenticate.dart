import 'dart:async';

import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_bloc/ui/screens/authentication/sign_in_screen/sign_in_screen.dart';
import 'package:firebase_auth_bloc/ui/screens/authentication/sign_up_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../../core/repositories/user_repository.dart';
import '../../widgets/background_painter.dart';
import 'authenticate_view_model.dart';

class Authenticate extends StatefulWidget {
  final UserRepository _userRepository;
  const Authenticate({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository, super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> with SingleTickerProviderStateMixin {


  late AnimationController c;


@override
  initState(){
  super.initState();
  c= AnimationController(vsync: this, duration: const Duration(seconds: 2));
  final auth = Provider.of<AuthProvider>(context, listen: false);
  auth.setController(c);



}


  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, auth, child) {

          return Stack(
            children: [
              SizedBox.expand(
                child: CustomPaint(
                  painter: BackgroundPainter(
                    animation: auth.controller,
                  ),
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: auth.showSignInPage,
                    builder: (context, value, child) {
                      return SizedBox.expand(
                        child: PageTransitionSwitcher(
                          reverse: !value,
                          duration: const Duration(milliseconds: 800),
                          transitionBuilder:
                              (child, animation, secondaryAnimation) {
                            return SharedAxisTransition(
                              animation: animation,
                              secondaryAnimation: secondaryAnimation,
                              transitionType: SharedAxisTransitionType.vertical,
                              fillColor: Colors.transparent,
                              child: child,
                            );
                          },
                          child: auth.showSignIn
                              ?  SignInScreen(
                            key:  auth.key,
                            userRepository: widget._userRepository,

                          )
                              : SignUpScreen(
                            key:  auth.key,
                            userRepository: widget._userRepository,

                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          );
          // return auth.showSignIn ? const SignInScreen() : const SignUpScreen();
        },
      )
    ;
  }
}
