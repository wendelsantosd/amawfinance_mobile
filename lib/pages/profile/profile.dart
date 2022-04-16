import 'package:amawfinance_mobile/components/menu.dart';
import 'package:amawfinance_mobile/shared/themes/app_colors.dart';
import 'package:amawfinance_mobile/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.menu,
        //     size: 40,
        //     color: const Color(0xFFFFFFFF),
        //   ),
        //   onPressed: () {
        //     print('Abrir menu');
        //   },
        // ),
        leading: Container(
          width: 58,
          child: Menu(),
        ),
      ),
    );
  }
}
