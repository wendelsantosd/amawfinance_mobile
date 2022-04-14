import 'package:flutter/material.dart';

import '../../shared/themes/app_colors.dart';
import '../../shared/themes/app_images.dart';
import '../../shared/themes/app_text_styles.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60, right: 40, left: 40),
        color: AppColors.background,
        child: ListView(
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset(AppImages.logo),
            ),
            Center(
              child: Text(
                'Amaw Finance',
                style: TextStyles.title,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'E-mail',
                labelStyle: TextStyles.primaryStyleFont,
              ),
              style: TextStyles.primaryStyleFont,
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: showPassword ? false : true,
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyles.primaryStyleFont,
                suffixIcon: GestureDetector(
                    child: Icon(
                      showPassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.grey300,
                    ),
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    }),
              ),
              style: TextStyles.primaryStyleFont,
            ),
            Container(
              height: 50,
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => print('Navigate'),
                child: Text(
                  'Recuperar Senha',
                  textAlign: TextAlign.right,
                  style: TextStyles.smallFont,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: AppColors.blue500,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  onPressed: () => print('Login'),
                  child: Text(
                    'ENTRAR',
                    style: TextStyles.fontInnerPrimaryButton,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: AppColors.white400,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: SizedBox.expand(
                child: TextButton.icon(
                  icon: Image.network(
                    'http://pngimg.com/uploads/google/google_PNG19635.png',
                    fit: BoxFit.cover,
                  ),
                  onPressed: () => print('Login'),
                  label: Text(
                    'ENTRAR COM GOOGLE',
                    style: TextStyles.fontInnerGoogleButton,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 50,
              child: TextButton(
                onPressed: () => print('Navigate'),
                child: Text(
                  'Criar Conta',
                  textAlign: TextAlign.center,
                  style: TextStyles.smallFont,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
