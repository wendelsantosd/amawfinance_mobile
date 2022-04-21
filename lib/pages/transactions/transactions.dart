import 'package:amawfinance_mobile/components/app_bar_widget.dart';
import 'package:amawfinance_mobile/shared/themes/app_colors.dart';
import 'package:amawfinance_mobile/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  List<DropdownMenuItem<String>> get months {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Janeiro"), value: '0'),
      const DropdownMenuItem(child: Text("Fevereiro"), value: "1"),
      const DropdownMenuItem(child: Text("Março"), value: "2"),
      const DropdownMenuItem(child: Text("Abril"), value: "3"),
      const DropdownMenuItem(child: Text("Maio"), value: "4"),
      const DropdownMenuItem(child: Text("Junho"), value: "5"),
      const DropdownMenuItem(child: Text("Julho"), value: "6"),
      const DropdownMenuItem(child: Text("Agosto"), value: "7"),
      const DropdownMenuItem(child: Text("Setembro"), value: "8"),
      const DropdownMenuItem(child: Text("Outubro"), value: "9"),
      const DropdownMenuItem(child: Text("Novembro"), value: "10"),
      const DropdownMenuItem(child: Text("Dezembro"), value: "11"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get years {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("2021"), value: '2021'),
      const DropdownMenuItem(child: Text("2022"), value: "2022"),
      const DropdownMenuItem(child: Text("2023"), value: "2023"),
      const DropdownMenuItem(child: Text("2024"), value: "2023"),
      const DropdownMenuItem(child: Text("2025"), value: "2025"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(title: 'Transações'),
      body: Container(
        // alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  value: '0',
                  items: months,
                  onChanged: (Object? value) {},
                  menuMaxHeight: 300,
                  style: TextStyles.selectFont,
                ),
                const SizedBox(width: 15),
                DropdownButton(
                  value: '2022',
                  items: years,
                  onChanged: (Object? value) {},
                  menuMaxHeight: 300,
                  style: TextStyles.selectFont,
                ),
                const SizedBox(width: 20),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.blue500,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: AppColors.white,
                      ),
                      label: Text(
                        'Buscar',
                        style: TextStyles.smallButtonFont,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Receitas",
                          style: TextStyles.smallFontCard,
                        ),
                        Icon(
                          Icons.arrow_circle_up,
                          size: 35,
                          color: AppColors.green600,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'R\$ 2000,60',
                      textAlign: TextAlign.left,
                      style: TextStyles.valueFontCard,
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Despesas",
                          style: TextStyles.smallFontCard,
                        ),
                        Icon(
                          Icons.arrow_circle_down,
                          size: 35,
                          color: AppColors.red300,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'R\$ 1000,00',
                      textAlign: TextAlign.left,
                      style: TextStyles.valueFontCard,
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyles.smallFontCard,
                        ),
                        Icon(
                          Icons.attach_money,
                          size: 35,
                          color: AppColors.yellow300,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'R\$ 1000,00',
                      textAlign: TextAlign.left,
                      style: TextStyles.valueFontCard,
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 5),
                TextButton(
                  onPressed: () {},
                  child: Text('NOVA TRANSAÇÃO',
                      style: TextStyle(color: AppColors.blue500),
                      textAlign: TextAlign.right),
                ),
              ],
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      child: Text(
                        'R\$ 1000,00',
                        style: TextStyles.valueExpense,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '21/04/2022',
                          style: TextStyles.fontTransactions,
                        ),
                        Text(
                          'Roupa nova',
                          style: TextStyles.fontTransactions,
                        ),
                        Text(
                          'Vestuário',
                          style: TextStyles.fontTransactions,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.edit,
                              size: 25,
                              color: AppColors.grey300,
                            ),
                            SizedBox(width: 15),
                            Icon(
                              Icons.delete,
                              size: 25,
                              color: AppColors.grey300,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      child: Text(
                        'R\$ 1000,60',
                        style: TextStyles.valueIncoming,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '21/04/2022',
                          style: TextStyles.fontTransactions,
                        ),
                        Text(
                          'Salário',
                          style: TextStyles.fontTransactions,
                        ),
                        Text(
                          '-',
                          style: TextStyles.fontTransactions,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.edit,
                              size: 25,
                              color: AppColors.grey300,
                            ),
                            const SizedBox(width: 15),
                            Icon(
                              Icons.delete,
                              size: 25,
                              color: AppColors.grey300,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: AppColors.blue500,
        onPressed: () => {},
      ),
    );
  }
}
