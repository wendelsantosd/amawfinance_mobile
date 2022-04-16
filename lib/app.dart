import 'package:amawfinance_mobile/pages/login/login.dart';
import 'package:amawfinance_mobile/pages/register/register.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amaw Finance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/register',
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => Register(),
      },
    );
  }
}
