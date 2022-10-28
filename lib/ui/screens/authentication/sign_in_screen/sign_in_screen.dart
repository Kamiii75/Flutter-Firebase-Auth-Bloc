import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../../../core/blocs/login_bloc/login_bloc.dart';
import '../../../../core/repositories/user_repository.dart';
import '../../../widgets/already_have_an_account_acheck.dart';
import '../../../widgets/rounded_button.dart';
import '../../../widgets/rounded_input_field.dart';
import '../../../widgets/rounded_password_field.dart';
import '../authenticate_view_model.dart';
import 'sign_in_screen_view_model.dart';

class SignInScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const SignInScreen({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => SignInProvider(context: context),
      child: Consumer<SignInProvider>(
        builder: (context, login, child) {
          return BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.isFailure) {
                ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:const  [
                          Text('Failure...'),
                          Icon(Icons.warning_amber),
                       //   CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)
                        ],
                      ))
                    );
              }
              if (state.isSubmitting) {    ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                    SnackBar(content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:const  [
                        Text('Submitting...'),
                        CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)
                      ],
                    ))
                );}
              if (state.isSucess) {    ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                    SnackBar(content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:const  [
                        Text('Success'),
                        Icon(Icons.done_all),
                        //CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)
                      ],
                    ))
                );}
            },
            child: SizedBox(
              width: double.infinity,
              height: size.height,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "LOGIN",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                        SizedBox(height: size.height * 0.03),
                        const Center(
                            child: Text(
                          "Welcome back! Login with your Credentials",
                          style: TextStyle(color: Colors.white),
                        )),
                        SizedBox(height: size.height * 0.03),
                        RoundedInputField(
                          textInputType: TextInputType.emailAddress,
                          controller: login.emailController,
                          icon: Icons.mail,
                          hintText: "Email",
                          onChanged: (value) {
                            login.onEmailChange();
                          },
                        ),
                        RoundedPasswordField(
                          controller: login.passController,
                          onChanged: (value) {},
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 25.0),
                          child: CheckboxListTile(
                            title: const Text("Remember Me"),
                            value: login.rememberMe,
                            onChanged: (newValue) {
                              login.setRememberMe(newValue!);
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                        ),
                        RoundedButton(
                          text: "Login",
                          press: () async {
                            EasyLoading.show(status: 'loading...');
                            await login.onSubmit();
                            //
                            // if (emailValidatorRegExp.hasMatch(login.emailController.text)) {
                            //   Future<void> isLogin=  Auth.funcLogin(login.emailController.text, login.passController.text);
                            //   isLogin.whenComplete(()  {
                            //      Auth.funcGetUser(FirebaseAuth.instance.currentUser!.uid).then((value) {
                            //
                            //
                            //       HelperFunction.saveUserTypeSharedPreference(value.get("type"));
                            //       HelperFunction.saveUserLoggedInSharedPreference(login.rememberMe);
                            //       HelperFunction.saveUserNameSharedPreference(value.get("name"));
                            //       HelperFunction.saveUserEmailSharedPreference(value.get("email"));
                            //     }).whenComplete(() {
                            //
                            //        FocusManager.instance.primaryFocus?.unfocus();
                            //        login.clearAll();
                            //        EasyLoading.dismiss();
                            //        Navigator.of(context).pushAndRemoveUntil(
                            //            MaterialPageRoute(builder: (context) => const MainPage()),
                            //                (Route<dynamic> route) => false);
                            //      });
                            //
                            //
                            //
                            //   }).onError((error, stackTrace) {
                            //
                            //     EasyLoading.showError("User not found");
                            //
                            //     EasyLoading.dismiss();
                            //     login.setEmailClear();
                            //     login.setPassClear();
                            //   });
                            // } else {
                            //
                            //   EasyLoading.dismiss();
                            //   login.setEmailClear();
                            //
                            // }
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                        AlreadyHaveAnAccountCheck(
                          press: () {
                            final auth = Provider.of<AuthProvider>(context,
                                listen: false);
                            auth.toggleView();
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) {
                            //       return const SignUpScreen();
                            //     },
                            //   ),
                            // );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
