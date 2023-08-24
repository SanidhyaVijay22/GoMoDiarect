import 'package:flutter/material.dart';
import 'package:gomodiarect/screens/login_page.dart';
import 'package:gomodiarect/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gomodiarect/widgets/auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'gomodiarect',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GoMoDiarect',
        home: AuthPage());
  }
}
