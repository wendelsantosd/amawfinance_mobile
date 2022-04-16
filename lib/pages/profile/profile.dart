import 'dart:io';

import 'package:amawfinance_mobile/components/menu.dart';
import 'package:amawfinance_mobile/shared/themes/app_colors.dart';
import 'package:amawfinance_mobile/shared/themes/app_images.dart';
import 'package:amawfinance_mobile/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? image;

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
                child: image != null
                    ? ClipOval(
                        child: Image.file(
                          image!,
                          width: 160,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipOval(
                        child: Image.asset(
                        AppImages.noAvatar,
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      )),
              ),
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
              }),
        ],
      ),
    );
  }
}
