// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:amawfinance_mobile/components/menu.dart';
import 'package:amawfinance_mobile/services/api.dart';
import 'package:amawfinance_mobile/shared/themes/app_colors.dart';
import 'package:amawfinance_mobile/shared/themes/app_images.dart';
import 'package:amawfinance_mobile/shared/themes/app_text_styles.dart';

class AppBarWidget extends StatefulWidget with PreferredSizeWidget {
  final String title;

  AppBarWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  final api = Api();
  String pictureURL = '';

  @override
  void initState() {
    api.userData().then((result) {
      setPictureURL(result['picture_url'] ?? '');
    });
    super.initState();
  }

  setPictureURL(state) {
    setState(() {
      pictureURL = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Text(
        widget.title,
        style: TextStyles.titleBar,
      ),
      backgroundColor: AppColors.red600,
      leading: Container(
        width: 58,
        child: Menu(),
      ),
      actions: [
        Container(
          width: 58,
          padding: EdgeInsets.all(5),
          child: pictureURL == ''
              ? ClipOval(
                  child: Image.asset(
                  AppImages.noAvatar,
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                ))
              : ClipOval(
                  child: Image.network(
                    pictureURL,
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ],
    );
  }
}
