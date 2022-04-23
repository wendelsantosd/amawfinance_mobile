import 'package:amawfinance_mobile/components/app_bar_widget.dart';
import 'package:amawfinance_mobile/services/api.dart';
import 'package:amawfinance_mobile/shared/themes/app_colors.dart';
import 'package:amawfinance_mobile/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  dynamic transaction = {};
  dynamic total = {
    'income': 0,
    'expense': 0,
    'total': 0,
  };

  String month = '0';
  String year = DateFormat('y').format(DateTime.now());

  String description = '';
  final valueController = TextEditingController();
  final descriptionController = TextEditingController();
  double value = 0.0;
  String type = 'expense';
  String category = '-';
  bool isEdit = false;
  bool loading = false;
  String errorMessage = '';

  setDescription(state) {
    setState(() {
      description = state;
    });
  }

  setValue(state) {
    setState(() {
      value = state;
    });
  }

  setType(state) {
    setState(() {
      type = state;
    });
  }

  setCategory(state) {
    setState(() {
      category = state;
    });
  }

  setIsEdit(state) {
    setState(() {
      isEdit = state;
    });
  }

  setLoading(state) {
    setState(() {
      loading = state;
    });
  }

  setTransactions(state) {
    setState(() {
      transactions = state;
    });
  }

  setTransaction(state) {
    setState(() {
      transaction = state;
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

  setErrorMessage(state) {
    setState(() {
      errorMessage = state;
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

  List<DropdownMenuItem<String>> get typeTransaction {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Despesa"), value: 'expense'),
      const DropdownMenuItem(child: Text("Receita"), value: "income"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get categories {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Selecionar Categoria"), value: '-'),
      const DropdownMenuItem(child: Text("Moradia"), value: 'Moradia'),
      const DropdownMenuItem(
          child: Text("Educação/Cultura"), value: "Educação/Cultura"),
      const DropdownMenuItem(child: Text("Alimentação"), value: "Alimentação"),
      const DropdownMenuItem(child: Text("Saúde"), value: "Saúde"),
      const DropdownMenuItem(child: Text("Transporte"), value: "Transporte"),
      const DropdownMenuItem(child: Text("Lazer"), value: "Lazer"),
      const DropdownMenuItem(child: Text("Vestuário"), value: "Vestuário"),
      const DropdownMenuItem(child: Text("Outro"), value: "Outro"),
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

  Future handleSubmitGetTransaction(String id) async {
    final resultTransaction = await api.getTransaction(id);

    setTransaction(resultTransaction);
    descriptionController.text = transaction['description'];
    valueController.text = transaction['amount'].toString();

    setType(transaction['type']);
    setCategory(transaction['category']);
  }

  Future handleSubmitCreateTransaction() async {
    setLoading(true);

    final result =
        await api.createTransaction(description, value, type, category);

    if (result == 201) {
      errorMessage = '';
      await handleSubmitGetTransactions();
      setLoading(false);
    } else {
      errorMessage = 'Ocorreu um erro';
      setLoading(false);
    }

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        dynamic typeM = type;
        dynamic categoryM = category;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter stateSetter) {
            return Card(
              elevation: 5,
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Descrição',
                          labelStyle: TextStyles.selectFont,
                        ),
                        style: TextStyles.selectFont,
                        controller: descriptionController,
                        onChanged: (value) {
                          setDescription(value);
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: InputDecoration(
                          labelText: 'Valor R\$',
                          labelStyle: TextStyles.selectFont,
                        ),
                        style: TextStyles.selectFont,
                        controller: valueController,
                        onChanged: (value) {
                          setValue(
                              double.tryParse(valueController.text) ?? 0.0);
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButton(
                        isExpanded: true,
                        value: typeM,
                        items: typeTransaction,
                        onChanged: (value) {
                          stateSetter(() {
                            typeM = value;
                          });
                          setType(value);
                        },
                        menuMaxHeight: 300,
                        style: TextStyles.selectFont,
                      ),
                      type == 'expense'
                          ? DropdownButton(
                              isExpanded: true,
                              value: category,
                              items: categories,
                              onChanged: (value) {
                                stateSetter(() {
                                  categoryM = value;
                                });
                                setCategory(value);
                              },
                              menuMaxHeight: 300,
                              style: TextStyles.selectFont,
                            )
                          : const Text(''),
                      const SizedBox(height: 40),
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
                        height: 40,
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
                                  onPressed: () {
                                    handleSubmitCreateTransaction();
                                    setDescription('');
                                    setValue(0.0);
                                    setType('expense');
                                    setCategory('-');
                                    descriptionController.text = '';
                                    valueController.text = '';
                                  },
                                  child: Text(
                                    'Salvar',
                                    style: TextStyles.fontInnerPrimaryButton,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
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
                  onPressed: () => _openTransactionFormModal(context),
                  child: Text('NOVA TRANSAÇÃO',
                      style: TextStyle(color: AppColors.blue500),
                      textAlign: TextAlign.right),
                ),
              ],
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
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
                                IconButton(
                                  onPressed: () {
                                    handleSubmitGetTransaction(tr['id']);
                                    _openTransactionFormModal(context);
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    size: 25,
                                    color: AppColors.grey300,
                                  ),
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
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: AppColors.blue500,
        onPressed: () => _openTransactionFormModal(context),
      ),
    );
  }
}
