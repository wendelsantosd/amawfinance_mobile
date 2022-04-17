import 'dart:io';

import 'package:amawfinance_mobile/components/menu.dart';
import 'package:amawfinance_mobile/services/api.dart';
import 'package:amawfinance_mobile/shared/themes/app_colors.dart';
import 'package:amawfinance_mobile/shared/themes/app_images.dart';
import 'package:amawfinance_mobile/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? image;
  final api = Api();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  String pictureURL = '';
  String name = '';
  String phone = '';
  String email = '';
  String confirmEmail = '';
  String password = '';
  String confirmPassword = '';
  String errorMessage1 = '';
  String errorMessage2 = '';
  String errorMessage3 = '';
  bool loading1 = false;
  bool loading2 = false;
  bool loading3 = false;
  bool showPassword = false;

  @override
  void initState() {
    api.userData().then((result) {
      setPictureURL(result['picture_url'] ?? '');
      setName(result['name']);
      setPhone(result['phone'] ?? '');
      setEmail(result['email']);
    });
    super.initState();
  }

  setPictureURL(state) {
    setState(() {
      pictureURL = state;
    });
  }

  setName(state) {
    setState(() {
      name = state;
    });
  }

  setPhone(state) {
    setState(() {
      phone = state;
    });
  }

  setEmail(state) {
    setState(() {
      email = state;
    });
  }

  setLoading1(state) {
    setState(() {
      loading1 = state;
    });
  }

  setLoading2(state) {
    setState(() {
      loading2 = state;
    });
  }

  setLoading3(state) {
    setState(() {
      loading3 = state;
    });
  }

  Future handleSubmitUpdateDataUser() async {
    setLoading1(true);
    print('f USER');
    if (_formKey1.currentState!.validate()) {
      final result = await api.userUpdate(name, phone);

      if (result == 200) {
        errorMessage1 = '';
        setLoading1(false);
      } else {
        errorMessage1 = 'Ocorreu um erro';
      }

      setLoading1(false);
    } else {
      setLoading1(false);
    }
  }

  void submit2() {}
  void submit3() {}

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
      Navigator.pop(context, "/profile");
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Meus Dados',
          style: TextStyles.titleBar,
        ),
        backgroundColor: AppColors.red600,
        leading: Container(
          width: 58,
          child: Menu(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 100),
        children: [
          PopupMenuButton(
            iconSize: 160,
            icon: Container(
                child: (() {
              // your code here
              if (image != null) {
                return ClipOval(
                  child: Image.file(
                    image!,
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                );
              } else if (pictureURL == '') {
                return ClipOval(
                  child: Image.asset(
                    AppImages.noAvatar,
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                );
              } else if (pictureURL.length > 1) {
                return ClipOval(
                  child: Image.network(
                    pictureURL,
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                );
              }
            }())),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  child: TextButton.icon(
                    onPressed: pickImage,
                    label: Text(
                      'Selecionar foto',
                      style: TextStyles.smallFontGrey,
                    ),
                    icon: Icon(
                      Icons.photo,
                      color: AppColors.grey300,
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  child: TextButton.icon(
                    onPressed: () => print('Apagar foto'),
                    label: Text(
                      'Apagar foto',
                      style: TextStyles.smallFontGrey,
                    ),
                    icon: Icon(
                      Icons.delete,
                      color: AppColors.grey300,
                    ),
                  ),
                ),
              ];
            },
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
            child: Form(
              key: _formKey1,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      labelStyle: TextStyles.primaryStyleFont,
                    ),
                    style: TextStyles.primaryStyleFont,
                    // initialValue: name,
                    controller: TextEditingController(text: name),
                    onChanged: (value) {
                      name = value;
                    },
                    validator: (value) {
                      if (value == '') {
                        return 'Não pode ser vazio';
                      } else if (value!.length < 2) {
                        return 'Nome curto demais';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Telefone',
                      labelStyle: TextStyles.primaryStyleFont,
                    ),
                    style: TextStyles.primaryStyleFont,
                    controller: TextEditingController(text: phone),
                    onChanged: (value) {
                      phone = value;
                    },
                    validator: (value) {
                      if (value!.length < 11 && value.length > 0) {
                        return 'Telefone inválido';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 20,
                    child: errorMessage1 != ''
                        ? Text(
                            errorMessage1,
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
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: SizedBox.expand(
                      child: loading1
                          ? SpinKitFadingCircle(
                              color: AppColors.white,
                              size: 25.0,
                            )
                          : TextButton(
                              onPressed: handleSubmitUpdateDataUser,
                              child: Text(
                                'SALVAR',
                                style: TextStyles.fontInnerPrimaryButton,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
            child: Form(
              key: _formKey2,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      labelStyle: TextStyles.primaryStyleFont,
                    ),
                    style: TextStyles.primaryStyleFont,
                    controller: TextEditingController(text: email),
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value == '') {
                        return 'Não pode ser vazio';
                      } else if (value!.length < 5) {
                        return 'E-mail curto demais';
                      } else if (!value.contains('@') || !value.contains('.')) {
                        return 'E-mail inválido';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Confirmar E-mail',
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
                      } else if (!value.contains('@') || !value.contains('.')) {
                        return 'E-mail inválido';
                      } else if (value != email) {
                        return "E-mail não conferem";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 20,
                    child: errorMessage2 != ''
                        ? Text(
                            errorMessage2,
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
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: SizedBox.expand(
                      child: loading2
                          ? SpinKitFadingCircle(
                              color: AppColors.white,
                              size: 25.0,
                            )
                          : TextButton(
                              onPressed: submit2,
                              child: Text(
                                'MUDAR E-MAIL',
                                style: TextStyles.fontInnerPrimaryButton,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding:
                const EdgeInsets.only(top: 20, right: 30, left: 30, bottom: 30),
            child: Form(
              key: _formKey3,
              child: Column(
                children: [
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
                      if (value == '') {
                        return 'Não pode ser vazio';
                      } else if (value!.length < 6) {
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
                      if (value == '') {
                        return 'Não pode ser vazio';
                      } else if (value!.length < 6) {
                        return 'No mínimo 6 caracteres';
                      } else if (value != password) {
                        return 'Senhas não conferem';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 20,
                    child: errorMessage3 != ''
                        ? Text(
                            errorMessage3,
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
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: SizedBox.expand(
                      child: loading3
                          ? SpinKitFadingCircle(
                              color: AppColors.white,
                              size: 25.0,
                            )
                          : TextButton(
                              onPressed: submit3,
                              child: Text(
                                'MUDAR SENHA',
                                style: TextStyles.fontInnerPrimaryButton,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
