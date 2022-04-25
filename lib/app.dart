import 'package:amawfinance_mobile/pages/login/login.dart';
import 'package:amawfinance_mobile/pages/notifications/notifications.dart';
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
      initialRoute: '/notifications',
      routes: {
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/recover-password': (context) => const RecoverPassword(),
        '/profile': (context) => const Profile(),
        '/transactions': (context) => const Transactions(),
        '/notifications': (context) => const Notifications(),
      },
    );
  }
}
