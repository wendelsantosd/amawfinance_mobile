import 'package:amawfinance_mobile/pages/charts/charts.dart';
import 'package:amawfinance_mobile/pages/login/login.dart';
import 'package:amawfinance_mobile/pages/notifications/notifications.dart';
import 'package:amawfinance_mobile/pages/profile/profile.dart';
import 'package:amawfinance_mobile/pages/recover_passsword/recover_password.dart';
import 'package:amawfinance_mobile/pages/register/register.dart';
import 'package:amawfinance_mobile/pages/transactions/transactions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String? token;

  setToken(state) {
    setState(() {
      token = state;
    });
  }

  Future getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  void initState() {
    getToken().then((value) {
      setToken(value);
      print(value);
    });

    print(token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amaw Finance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // initialRoute: token == null ? '/login' : '/transactions',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/recover-password': (context) => const RecoverPassword(),
        '/profile': (context) => const Profile(),
        '/transactions': (context) => const Transactions(),
        '/notifications': (context) => const Notifications(),
        '/charts': (context) => const Charts(),
      },
    );
  }
}
