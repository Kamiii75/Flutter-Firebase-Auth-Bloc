import 'package:firebase_auth_bloc/core/blocs/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class SignInProvider extends ChangeNotifier{
  BuildContext context;
  SignInProvider({required this.context}){
    _emailController.addListener(onEmailChange);
    _passController.addListener(onPassChange);
  }



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


  onEmailChange(){
    context.read<LoginBloc>().add(LoginEmailChange(email: _emailController.text));

  }
  onPassChange(){
    context.read<LoginBloc>().add(LoginPasswordChange(password: _passController.text));

  }
onSubmit(){

  context.read<LoginBloc>().add(LoginWithCredentials(email: _emailController.text,password: _passController.text));
}


  clearAll(){
    _emailController.dispose();
    _passController.dispose();
  }
}