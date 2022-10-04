
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
  BuildContext? context;
  AuthProvider({this.context});

  ValueNotifier<bool> showSignInPage = ValueNotifier<bool>(true);


  Key key= const ValueKey('SignIn');
  bool _showSignIn=true;


  bool get showSignIn=>_showSignIn;

  late AnimationController _controller;
  setController(AnimationController controller){

    _controller =controller;
  }
  get controller=>_controller;
   setShowSignIn(bool showSignIn){
    _showSignIn=showSignIn;
    showSignIn?
      _controller.forward():_controller.reverse();
    key=showSignIn?
     const ValueKey('SignIn'):const ValueKey('SignUp');

    notifyListeners();
  }

  void toggleView() {

      _showSignIn = !_showSignIn;
      showSignInPage.value=_showSignIn;
      showSignIn?
      _controller.reverse():_controller.forward();
      key=showSignIn?
      const ValueKey('SignIn'):const ValueKey('SignUp');

    notifyListeners();
  }


}