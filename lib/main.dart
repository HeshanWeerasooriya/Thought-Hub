import 'package:flutter/material.dart';
import 'package:thought_hub/screens/signup_screen.dart';
import 'package:thought_hub/screens/thought_screen.dart';
import 'package:thought_hub/theme.dart';
import 'package:change_app_package_name/change_app_package_name.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: ThemeMode.system,
      home: SignupScreen(),
    );
  }
}
