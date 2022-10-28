
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/blocs/signup_bloc/signup_bloc.dart';
import '../authenticate_view_model.dart';



class SignUpProvider extends ChangeNotifier {

  BuildContext context;
  SignUpProvider({required this.context}){
    _emailController.addListener(onEmailChange);
    _passController.addListener(onPassChange);
  }
  toggleScreen(BuildContext context){

     final auth =
     Provider.of<AuthProvider>(context, listen: false);
     auth.toggleView();
     clearAll();

  }



  bool _rememberMe=false;
  bool get rememberMe=>_rememberMe;
  setRememberMe(bool val){
    _rememberMe=val;
    notifyListeners();
  }





  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();



  TextEditingController get nameController=>_nameController;
  TextEditingController get phoneController=>_phoneController;
  TextEditingController get addressController=>_addressController;
  TextEditingController get emailController=>_emailController;
  TextEditingController get passController=>_passController;

  setName(TextEditingController nameController){
    _nameController=nameController;
    notifyListeners();
  }
  setNameClear(){
    _nameController.clear();
    notifyListeners();
  }
  setPhone(TextEditingController phoneController){
    _phoneController=phoneController;
    notifyListeners();
  }
  setPhoneClear(){
    _phoneController.clear();
    notifyListeners();
  }
  setAddress(TextEditingController addressController){
    _addressController=addressController;
    notifyListeners();
  }
  setAddressClear(){
    _addressController.clear();
    notifyListeners();
  }
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
    context.read<SignupBloc>().add(SignupEmailChange(email: _emailController.text));

  }
  onPassChange(){
    context.read<SignupBloc>().add(SignupPasswordChange(password: _passController.text));

  }
  onSubmit(){

    context.read<SignupBloc>().add(SignupWithCredentials(email: _emailController.text,password: _passController.text));
  }


  clearAll(){
    _emailController.clear();
    _passController.clear();
    _phoneController.clear();
    _addressController.clear();
  }



}
