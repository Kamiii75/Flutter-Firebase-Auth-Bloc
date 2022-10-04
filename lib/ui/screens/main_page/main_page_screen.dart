import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
class MainPage extends StatelessWidget {
  final User firebaseUser;
   MainPage({Key? key,required this.firebaseUser}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey();
  @override
  Widget build(BuildContext context) {
    return     Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: kPrimaryColor,
        title: const Text(
          "Auth Bloc",

          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading:

          GestureDetector(
              onTap: (){
                // Auth.funcLogout(context!);
              },child:const Padding(
            padding:  EdgeInsets.all(8.0),
            child:  Icon(Icons.logout,color: Colors.white,),
          )),

      ),

      body: Scaffold(
        key: _scaffoldKey,

        body: Container(child: Center(child: Text('Hi ${firebaseUser.email}'),),),
      ),
      //
    );

  }
}


