import 'package:flutter/material.dart';
class SignInProvider extends ChangeNotifier{




  bool _rememberMe=false;
  bool get rememberMe=>_rememberMe;
  setRememberMe(bool val){
    _rememberMe=val;
    notifyListeners();
  }





  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  TextEditingController get emailController=>_emailController;
  TextEditingController get passController=>_passController;

  setEmail(TextEditingController emailController){
    _emailController=emailController;
    notifyListeners();
  }
  setEmailClear(){
    _emailController.clear();
    notifyListeners();
  }
  setPassClear(){
    _passController.clear();
    notifyListeners();
  }
  setPassword(TextEditingController passController){
    _passController=passController;
    notifyListeners();
  }




}