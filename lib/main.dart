import 'package:flutter/material.dart';
import 'package:login_and_register/providers/auth.dart';
import 'package:login_and_register/screens/signin_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
      ],
      builder: (context, child) => const MaterialApp(
        home: SignInPage(),
      ),
    );
  }
}
