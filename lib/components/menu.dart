import 'dart:io';
import 'package:amawfinance_mobile/services/api.dart';
import 'package:amawfinance_mobile/shared/themes/app_colors.dart';
import 'package:amawfinance_mobile/shared/themes/app_images.dart';
import 'package:amawfinance_mobile/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.menu,
        size: 35,
      ),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: '1',
            child: TextButton.icon(
              onPressed: () => Navigator.popAndPushNamed(context, '/profile'),
              label: Text(
                'Meus Dados',
                style: TextStyles.smallFontGrey,
              ),
              icon: Icon(
                Icons.person,
                color: AppColors.grey300,
              ),
            ),
          ),
          PopupMenuItem<String>(
            child: TextButton.icon(
              onPressed: () =>
                  Navigator.popAndPushNamed(context, '/transactions'),
              label: Text(
                'Transações',
                style: TextStyles.smallFontGrey,
              ),
              icon: Icon(
                Icons.attach_money,
                color: AppColors.grey300,
              ),
            ),
          ),
          PopupMenuItem<String>(
            child: TextButton.icon(
              onPressed: () =>
                  Navigator.popAndPushNamed(context, '/notifications'),
              label: Text(
                'Notificações',
                style: TextStyles.smallFontGrey,
              ),
              icon: Icon(
                Icons.notifications,
                color: AppColors.grey300,
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: '2',
            child: TextButton.icon(
              onPressed: () => Navigator.popAndPushNamed(context, '/charts'),
              label: Text(
                'Gráficos',
                style: TextStyles.smallFontGrey,
              ),
              icon: Icon(
                Icons.bar_chart_sharp,
                color: AppColors.grey300,
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: '2',
            child: TextButton.icon(
              onPressed: () => Navigator.popAndPushNamed(context, '/login'),
              label: Text(
                'Sair',
                style: TextStyles.smallFontGrey,
              ),
              icon: Icon(
                Icons.logout,
                color: AppColors.grey300,
              ),
            ),
          ),
        ];
      },
    );
  }
}
