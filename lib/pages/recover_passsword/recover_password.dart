import 'package:amawfinance_mobile/services/api.dart';
import 'package:amawfinance_mobile/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../shared/themes/app_colors.dart';

class RecoverPassword extends StatefulWidget {
  const RecoverPassword({Key? key}) : super(key: key);

  @override
  _RecoverPasswordState createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  final _formKey = GlobalKey<FormState>();
  final api = Api();
  String email = '';
  String errorMessage = '';
  bool loading = false;
  bool isEmailSent = false;

  setIsEmailSent(state) {
    setState(() {
      isEmailSent = state;
    });
  }

  setLoading(state) {
    setState(() {
      loading = state;
    });
  }

  void submit() async {
    setLoading(true);

    if (_formKey.currentState!.validate()) {
      final result = await api.recoverPassword(email);

      if (result == 200) {
        setIsEmailSent(true);
        errorMessage = '';
      } else {
        errorMessage = 'Ocorreu um erro';
      }

      setLoading(false);
    } else {
      setLoading(false);
    }
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
            Text('Recupere sua senha', style: TextStyles.primaryTitle),
            const SizedBox(height: 20),
            !isEmailSent
                ? Form(
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
                            if (value == '') {
                              return 'Não pode ser vazio';
                            } else if (value!.length < 5) {
                              return 'E-mail curto demais';
                            } else if (!value.contains('@') ||
                                !value.contains('.')) {
                              return 'E-mail inválido';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 60),
                        Container(
                          height: 20,
                          child: errorMessage != ''
                              ? Text(
                                  errorMessage,
                                  textAlign: TextAlign.center,
                                  style: TextStyles.smallFont,
                                )
                              : null,
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: AppColors.blue500,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: SizedBox.expand(
                            child: loading
                                ? SpinKitFadingCircle(
                                    color: AppColors.white,
                                    size: 25.0,
                                  )
                                : TextButton(
                                    onPressed: submit,
                                    child: Text(
                                      'RECUPERAR',
                                      style: TextStyles.fontInnerPrimaryButton,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 60)),
                      Text("E-mail enviado com sucesso!",
                          textAlign: TextAlign.center,
                          style: TextStyles.h1Notification),
                      const SizedBox(height: 10),
                      Text(
                        "Enviamos um e-mail com instruções!",
                        textAlign: TextAlign.center,
                        style: TextStyles.h2Notification,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Por favor, se necessário, verifique a caixa de spam.",
                        textAlign: TextAlign.center,
                        style: TextStyles.h2Notification,
                      ),
                      const SizedBox(height: 50),
                      Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: AppColors.blue500,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: SizedBox.expand(
                          child: loading
                              ? SpinKitFadingCircle(
                                  color: AppColors.white,
                                  size: 25.0,
                                )
                              : TextButton(
                                  onPressed: () =>
                                      Navigator.pushReplacementNamed(
                                          context, '/login'),
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyles.fontInnerPrimaryButton,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
