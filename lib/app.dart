import 'package:amawfinance_mobile/pages/login/login.dart';
import 'package:amawfinance_mobile/pages/profile/profile.dart';
import 'package:amawfinance_mobile/pages/recover_passsword/recover_password.dart';
import 'package:amawfinance_mobile/pages/register/register.dart';
import 'package:amawfinance_mobile/pages/transactions/transactions.dart';
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
      initialRoute: '/transactions',
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/recover-password': (context) => RecoverPassword(),
        '/profile': (context) => Profile(),
        '/transactions': (context) => Transactions(),
      },
    );
  }
}
