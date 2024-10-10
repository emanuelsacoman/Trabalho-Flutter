import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto/models/Login.dart';
import 'package:projeto/services/authentication_service.dart';
import 'package:projeto/view/forgot_password.dart';
import 'package:projeto/view/home_page.dart';
import 'package:projeto/view/login.dart';
import 'package:projeto/view/register.dart';
import 'package:projeto/view/telaInicial.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:projeto/widgets/snack_bar_widget.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      routes: {
        '/telaInicial': (context) => Telainicial(),
        '/register': (context) => Register(),
        '/forgotPassword': (context) => ForgotPassword(),
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Login? login;
  const MyHomePage({super.key, this.login});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return HomePage(user: snapshot.data!);
        }else {
          return LoginPage();
        }
      }
    );
  }
}
