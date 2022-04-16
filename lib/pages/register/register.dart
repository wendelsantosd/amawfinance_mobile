import 'package:amawfinance_mobile/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../shared/themes/app_colors.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool showPassword = false;
  bool loading = false;

  setLoading(state) {
    setState(() {
      loading = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 40,
            color: const Color(0xFFB22222),
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
        color: AppColors.background,
        child: ListView(
          children: [
            Text('Crie sua conta', style: TextStyles.primaryTitle),
            const SizedBox(height: 20),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      labelStyle: TextStyles.primaryStyleFont,
                    ),
                    style: TextStyles.primaryStyleFont,
                    onChanged: (value) {
                      name = value;
                    },
                    validator: (value) {
                      if (value!.length < 2) {
                        return 'Nome curto demais';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      labelStyle: TextStyles.primaryStyleFont,
                    ),
                    style: TextStyles.primaryStyleFont,
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.length < 5) {
                        return 'E-mail curto demais';
                      } else if (!value.contains('@') || !value.contains('.')) {
                        return 'E-mail inválido';
                      }

                      return null;
                    },
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
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.grey300,
                          ),
                          onTap: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          }),
                    ),
                    style: TextStyles.primaryStyleFont,
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'No mínimo 6 caracteres';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: showPassword ? false : true,
                    decoration: InputDecoration(
                      labelText: 'Confirmar Senha',
                      labelStyle: TextStyles.primaryStyleFont,
                      suffixIcon: GestureDetector(
                          child: Icon(
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.grey300,
                          ),
                          onTap: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          }),
                    ),
                    style: TextStyles.primaryStyleFont,
                    onChanged: (value) {
                      confirmPassword = value;
                    },
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'No mínimo 6 caracteres';
                      } else if (value != password) {
                        return 'Senhas não conferem';
                      }

                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            Container(
              height: 50,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: AppColors.blue500,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: SizedBox.expand(
                child: loading
                    ? SpinKitFadingCircle(
                        color: AppColors.white,
                        size: 25.0,
                      )
                    : TextButton(
                        onPressed: () => print('submit'),
                        child: Text(
                          'REGISTRAR',
                          style: TextStyles.fontInnerPrimaryButton,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
