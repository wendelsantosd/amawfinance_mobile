import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../services/api.dart';
import '../../shared/themes/app_colors.dart';
import '../../shared/themes/app_images.dart';
import '../../shared/themes/app_text_styles.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final api = Api();
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  String email = '';
  String password = '';
  bool loading = false;
  bool isButtonDisabled = false;

  setLoading(state) {
    setState(() {
      loading = state;
      isButtonDisabled = state;
    });
  }

  void submit() async {
    setLoading(true);

    if (_formKey.currentState!.validate()) {
      final result = await api.login(email, password);
      print(email);
      print(password);

      if (result == 'OK') {
        print('Usuário logado com sucesso !');
      } else if (result == 401 || result == 404) {
        print('E-mail ou senha incorreto');
      } else {
        print(result);
      }

      print('VALIDATE OK');
    } else {
      setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
            Form(
                key: _formKey,
                child: Column(
                  children: [
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
                        } else if (!value.contains('@') ||
                            !value.contains('.')) {
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
                  ],
                )),
            Container(
              height: 50,
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => setLoading(!loading),
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
                child: loading
                    ? SpinKitFadingCircle(
                        color: AppColors.white,
                        size: 25.0,
                      )
                    : TextButton(
                        onPressed: isButtonDisabled ? null : submit,
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
                onPressed: isButtonDisabled ? null : submit,
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
