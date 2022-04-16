import 'package:amawfinance_mobile/shared/themes/app_colors.dart';
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
      icon: const CircleAvatar(
        backgroundImage: NetworkImage(
            "https://4.bp.blogspot.com/-Jx21kNqFSTU/UXemtqPhZCI/AAAAAAAAh74/BMGSzpU6F48/s1600/funny-cat-pictures-047-001.jpg"),
        // backgroundColor: Colors.white,
      ),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: '1',
            child: TextButton.icon(
              onPressed: () => Navigator.popAndPushNamed(context, '/login'),
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
            value: '2',
            child: TextButton.icon(
              onPressed: () => Navigator.popAndPushNamed(context, '/login'),
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
            value: '2',
            child: TextButton.icon(
              onPressed: () => Navigator.popAndPushNamed(context, '/login'),
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
              onPressed: () => Navigator.popAndPushNamed(context, '/login'),
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
