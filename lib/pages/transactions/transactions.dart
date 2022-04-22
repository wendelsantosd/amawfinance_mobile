import 'package:amawfinance_mobile/components/app_bar_widget.dart';
import 'package:amawfinance_mobile/services/api.dart';
import 'package:amawfinance_mobile/shared/themes/app_colors.dart';
import 'package:amawfinance_mobile/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final api = Api();
  dynamic transactions = [];
  dynamic total = {
    'income': 0,
    'expense': 0,
    'total': 0,
  };

  String month = '0';
  String year = DateFormat('y').format(DateTime.now());

  setTransactions(state) {
    setState(() {
      transactions = state;
    });
  }

  setTotal(state) {
    setState(() {
      total = state;
    });
  }

  setMonth(state) {
    setState(() {
      month = state;
    });
  }

  setYear(state) {
    setState(() {
      year = state;
    });
  }

  List<DropdownMenuItem<String>> get months {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Janeiro"), value: "0"),
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

  void getCurrentMonth() {
    final monthDateFormat = DateFormat('M').format(DateTime.now());
    final monthInt = int.parse(monthDateFormat);
    final monthApiNode = monthInt - 1;
    final monthConverted = monthApiNode.toString();

    setMonth(monthConverted);
  }

  @override
  void initState() {
    getCurrentMonth();

    api.getTransactions(month, year).then((result) {
      setTransactions(result);
    });

    api.getTotal(month, year).then((result) {
      setTotal(result);
    });
    super.initState();
  }

  Future handleSubmitGetTransactions() async {
    final resultTransactions = await api.getTransactions(month, year);
    setTransactions(resultTransactions);

    final resultTotal = await api.getTotal(month, year);
    setTotal(resultTotal);
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
                  value: month,
                  items: months,
                  onChanged: (value) {
                    setMonth(value);
                  },
                  menuMaxHeight: 300,
                  style: TextStyles.selectFont,
                ),
                const SizedBox(width: 15),
                DropdownButton(
                  value: year,
                  items: years,
                  onChanged: (value) {
                    setYear(value);
                  },
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
                    textDirection: ui.TextDirection.rtl,
                    child: TextButton.icon(
                      onPressed: handleSubmitGetTransactions,
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
                      NumberFormat.simpleCurrency(locale: 'pt-BR')
                          .format(total['income']),
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
                      NumberFormat.simpleCurrency(locale: 'pt-BR')
                          .format(total['expense']),
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
                      NumberFormat.simpleCurrency(locale: 'pt-BR')
                          .format(total['total']),
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
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: transactions!.length,
              itemBuilder: (context, index) {
                final tr = transactions[index];
                return Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          child: Text(
                            tr['type'] == 'expense'
                                ? '- ' +
                                    NumberFormat.simpleCurrency(locale: 'pt-BR')
                                        .format(tr['amount'])
                                : NumberFormat.simpleCurrency(locale: 'pt-BR')
                                    .format(tr['amount']),
                            style: tr['type'] == 'expense'
                                ? TextStyles.valueExpense
                                : TextStyles.valueIncoming,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('d/MM/y')
                                  .format(DateTime.parse(tr['created_at'])),
                              style: TextStyles.fontTransactions,
                            ),
                            Text(
                              tr['description'],
                              style: TextStyles.fontTransactions,
                            ),
                            Text(
                              tr['category'],
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
                );
              },
            )
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
