import 'package:flutter/material.dart';

import '../../shared/themes/app_colors.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60, right: 40, left: 40),
        color: AppColors.background,
        child: ListView(
          children: [
            SizedBox(
                width: 200,
                height: 200,
                child: Image.asset('assets/images/logo.png')),
          ],
        ),
      ),
    );
  }
}
