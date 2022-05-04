import 'package:amawfinance_mobile/components/app_bar_widget.dart';
import 'package:amawfinance_mobile/services/api.dart';
import 'package:amawfinance_mobile/shared/themes/app_colors.dart';
import 'package:amawfinance_mobile/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final api = Api();
  dynamic notifications = [];
  String month = '0';
  String year = DateFormat('y').format(DateTime.now());

  setNotifications(state) {
    setState(() {
      notifications = state;
    });
  }

  setMonth(state) {
    setState(() {
      month = state;
    });
  }

  @override
  void initState() {
    getCurrentMonth();

    api.getNotifications(month, year).then((result) {
      setNotifications(result);
    });

    super.initState();
  }

  void getCurrentMonth() {
    final monthDateFormat = DateFormat('M').format(DateTime.now());
    final monthInt = int.parse(monthDateFormat);
    final monthApiNode = monthInt - 1;
    final monthConverted = monthApiNode.toString();

    setMonth(monthConverted);
  }

  getColor(dynamic percentage) {
    if (percentage < 30) {
      return AppColors.green600.withOpacity(0.7);
    } else if (percentage >= 30 && percentage < 50) {
      return AppColors.yellow300.withOpacity(0.7);
    } else if (percentage >= 50 && percentage < 80) {
      return AppColors.orange600.withOpacity(0.7);
    } else if (percentage >= 80) {
      return AppColors.red300.withOpacity(0.7);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(title: 'Notificações'),
      body: Container(
        padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
        child: ListView(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: notifications!.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  elevation: 5,
                  // color: AppColors.red600.withOpacity(0.7),
                  color: getColor(notification['percentage']),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          DateFormat('dd/MM/y HH:mm').format(
                                  DateTime.parse(notification['created_at'])) +
                              'hs',
                          style: TextStyles.fontDateNotifications,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          notification['message'].toString() + '.',
                          style: TextStyles.fontNotifications,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
