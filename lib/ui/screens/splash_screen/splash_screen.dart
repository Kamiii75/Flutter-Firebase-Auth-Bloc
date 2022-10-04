import 'dart:async';

import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_bloc/ui/screens/main_page/main_page_screen.dart';
import 'package:firebase_auth_bloc/ui/screens/splash_screen/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/blocs/auth_bloc/auth_bloc.dart';
import '../../../core/repositories/user_repository.dart';
import '../../widgets/background_painter.dart';
import '../authentication/authenticate.dart';
import '../authentication/authenticate_view_model.dart';

class SplashScreen extends StatefulWidget {
  final UserRepository _userRepository;

  SplashScreen({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController c;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.setController(c);
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return
      ChangeNotifierProvider(
          create: (context) => SplashProvider(),child:
      Consumer<SplashProvider>(
      builder: (context, splash, child) {
        final auth = Provider.of<AuthProvider>(context, listen: false);

        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            print(state.toString());
           if(state is AuthSuccess){
             print(state.toString());
             Navigator.of(context).pushAndRemoveUntil(
                 MaterialPageRoute(builder: (context) =>  MainPage(firebaseUser: state.firebaseUser)),
                     (Route<dynamic> route) => false);
           }else{
              print(state.toString());
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) =>  Authenticate(userRepository: widget._userRepository,)),
                      (Route<dynamic> route) => false);

            }
          },
          child: Scaffold(
            body: SizedBox(
              height: size.height,
              width: double.infinity,
              child: Stack(
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
                                  transitionType:
                                  SharedAxisTransitionType.vertical,
                                  fillColor: Colors.transparent,
                                  child: child,
                                );
                              },
                              child: SizedBox(
                                height: size.height / 3,
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/worker.png",
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
