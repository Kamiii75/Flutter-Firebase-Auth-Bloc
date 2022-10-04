import 'package:firebase_auth_bloc/core/blocs/auth_bloc/auth_bloc.dart';
import 'package:firebase_auth_bloc/core/blocs/login_bloc/login_bloc.dart';
import 'package:firebase_auth_bloc/core/blocs/simpleBlocObserver.dart';
import 'package:firebase_auth_bloc/core/repositories/user_repository.dart';
import 'package:firebase_auth_bloc/ui/screens/authentication/authenticate.dart';
import 'package:firebase_auth_bloc/ui/screens/authentication/authenticate_view_model.dart';
import 'package:firebase_auth_bloc/ui/screens/main_page/main_page_screen.dart';
import 'package:firebase_auth_bloc/ui/screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  runApp(BlocProvider(
    create: (context) => AuthBloc(userRepository: userRepository),
    child: MyApp(
      userRepository: userRepository,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;

  const MyApp({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (BuildContext context) =>
                AuthBloc(userRepository: _userRepository),
          ),
          BlocProvider<LoginBloc>(
            create: (BuildContext context) =>
                LoginBloc(userRepository: _userRepository),
          ),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (context) => AuthProvider(context: context)),
          ],
          child: MaterialApp(
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: SplashScreen(
              userRepository: _userRepository,
            ),

            // home: BlocBuilder<AuthBloc, AuthState>(
            //   builder: (context, state) {
            //   if(state is AuthSuccess){
            //
            //       return MainPage(firebaseUser: state.firebaseUser);
            //     }else{
            //
            //       return Authenticate(userRepository: _userRepository,);
            //     }
            //   },
            // ),
          ),
        ));
  }
}
