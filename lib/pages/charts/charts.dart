import 'dart:math';
import 'dart:ui' as ui;
import 'package:amawfinance_mobile/components/app_bar_widget.dart';
import 'package:amawfinance_mobile/services/api.dart';
import 'package:amawfinance_mobile/shared/themes/app_colors.dart';
import 'package:amawfinance_mobile/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class Charts extends StatefulWidget {
  const Charts({Key? key}) : super(key: key);

  @override
  _ChartsState createState() => _ChartsState();
}

class Sum {
  String month;
  double amount;

  Sum(this.month, this.amount);
}

class _ChartsState extends State<Charts> {
  final api = Api();
  String year = DateFormat('y').format(DateTime.now());
  dynamic dataSum;
  dynamic dataSumCategory;

  List<Sum> _data = [];
  List<charts.Series<Sum, String>> _chartData = [];
  dynamic value = 'Nenhum mês selecionado';
  dynamic month = '';
  dynamic type = 'Receita';

  setValue(state) {
    setState(() {
      value = state;
    });
  }

  setChartData(state) {
    setState(() {
      _chartData = state;
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

  setDataSum(state) {
    setState(() {
      dataSum = state;
    });
  }

  setDataSumCategory(state) {
    setState(() {
      dataSumCategory = state;
    });
  }

  setType(state) {
    setState(() {
      type = state;
    });
  }

  List<DropdownMenuItem<String>> get types {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Receita"), value: 'Receita'),
      const DropdownMenuItem(child: Text("Despesa"), value: 'Despesa'),
      const DropdownMenuItem(child: Text("Total"), value: "Total"),
      const DropdownMenuItem(
          child: Text("Despesa Alimentação"), value: "Despesa Alimentação"),
      const DropdownMenuItem(
          child: Text("Despesa Saúde"), value: "Despesa Saúde"),
      const DropdownMenuItem(
          child: Text("Despesa Transporte"), value: "Despesa Transporte"),
      const DropdownMenuItem(
          child: Text("Despesa Lazer"), value: "Despesa Lazer"),
      const DropdownMenuItem(
          child: Text("Despesa Vestuário"), value: "Despesa Vestuário"),
      const DropdownMenuItem(
          child: Text("Despesa Outro"), value: "Despesa Outro"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get years {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("2021"), value: '2021'),
      const DropdownMenuItem(child: Text("2022"), value: "2022"),
      const DropdownMenuItem(child: Text("2023"), value: "2023"),
      const DropdownMenuItem(child: Text("2024"), value: "2024"),
      const DropdownMenuItem(child: Text("2025"), value: "2025"),
    ];
    return menuItems;
  }

  void _makeDataIncome() {
    _data = <Sum>[];
    _chartData = <charts.Series<Sum, String>>[];

    final rnd = Random();
    _data
        .add(Sum('Jan', double.parse(dataSum['sumJanT']['income'].toString())));
    _data
        .add(Sum('Fev', double.parse(dataSum['sumFevT']['income'].toString())));
    _data
        .add(Sum('Mar', double.parse(dataSum['sumMarT']['income'].toString())));
    _data
        .add(Sum('Abr', double.parse(dataSum['sumAprT']['income'].toString())));
    _data
        .add(Sum('Mai', double.parse(dataSum['sumMayT']['income'].toString())));
    _data
        .add(Sum('Jun', double.parse(dataSum['sumJunT']['income'].toString())));
    _data
        .add(Sum('Jul', double.parse(dataSum['sumJulT']['income'].toString())));
    _data
        .add(Sum('Ago', double.parse(dataSum['sumAugT']['income'].toString())));
    _data
        .add(Sum('Set', double.parse(dataSum['sumSepT']['income'].toString())));
    _data
        .add(Sum('Out', double.parse(dataSum['sumOctT']['income'].toString())));
    _data
        .add(Sum('Nov', double.parse(dataSum['sumNovT']['income'].toString())));
    _data
        .add(Sum('Dez', double.parse(dataSum['sumDecT']['income'].toString())));

    setState(() {
      _chartData.add(
        charts.Series(
          id: 'Sum',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          data: _data,
          domainFn: (Sum amount, _) => amount.month,
          measureFn: (Sum amount, _) => amount.amount,
          fillPatternFn: (_, __) => charts.FillPatternType.solid,
          displayName: 'Sum',
        ),
      );
    });
  }

  void _makeDataExpense() {
    _data = <Sum>[];
    _chartData = <charts.Series<Sum, String>>[];

    _data.add(
        Sum('Jan', double.parse(dataSum['sumJanT']['expense'].toString())));
    _data.add(
        Sum('Fev', double.parse(dataSum['sumFevT']['expense'].toString())));
    _data.add(
        Sum('Mar', double.parse(dataSum['sumMarT']['expense'].toString())));
    _data.add(
        Sum('Abr', double.parse(dataSum['sumAprT']['expense'].toString())));
    _data.add(
        Sum('Mai', double.parse(dataSum['sumMayT']['expense'].toString())));
    _data.add(
        Sum('Jun', double.parse(dataSum['sumJunT']['expense'].toString())));
    _data.add(
        Sum('Jul', double.parse(dataSum['sumJulT']['expense'].toString())));
    _data.add(
        Sum('Ago', double.parse(dataSum['sumAugT']['expense'].toString())));
    _data.add(
        Sum('Set', double.parse(dataSum['sumSepT']['expense'].toString())));
    _data.add(
        Sum('Out', double.parse(dataSum['sumOctT']['expense'].toString())));
    _data.add(
        Sum('Nov', double.parse(dataSum['sumNovT']['expense'].toString())));
    _data.add(
        Sum('Dez', double.parse(dataSum['sumDecT']['expense'].toString())));

    setState(() {
      _chartData.add(
        charts.Series(
          id: 'Sum',
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          data: _data,
          domainFn: (Sum amount, _) => amount.month,
          measureFn: (Sum amount, _) => amount.amount,
          fillPatternFn: (_, __) => charts.FillPatternType.solid,
          displayName: 'Sum',
        ),
      );
    });
  }

  void _makeDataTotal() {
    _data = <Sum>[];
    _chartData = <charts.Series<Sum, String>>[];

    _data.add(Sum('Jan', double.parse(dataSum['sumJanT']['total'].toString())));
    _data.add(Sum('Fev', double.parse(dataSum['sumFevT']['total'].toString())));
    _data.add(Sum('Mar', double.parse(dataSum['sumMarT']['total'].toString())));
    _data.add(Sum('Abr', double.parse(dataSum['sumAprT']['total'].toString())));
    _data.add(Sum('Mai', double.parse(dataSum['sumMayT']['total'].toString())));
    _data.add(Sum('Jun', double.parse(dataSum['sumJunT']['total'].toString())));
    _data.add(Sum('Jul', double.parse(dataSum['sumJulT']['total'].toString())));
    _data.add(Sum('Ago', double.parse(dataSum['sumAugT']['total'].toString())));
    _data.add(Sum('Set', double.parse(dataSum['sumSepT']['total'].toString())));
    _data.add(Sum('Out', double.parse(dataSum['sumOctT']['total'].toString())));
    _data.add(Sum('Nov', double.parse(dataSum['sumNovT']['total'].toString())));
    _data.add(Sum('Dez', double.parse(dataSum['sumDecT']['total'].toString())));

    setState(() {
      _chartData.add(
        charts.Series(
          id: 'Sum',
          colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
          data: _data,
          domainFn: (Sum amount, _) => amount.month,
          measureFn: (Sum amount, _) => amount.amount,
          fillPatternFn: (_, __) => charts.FillPatternType.solid,
          displayName: 'Sum',
        ),
      );
    });
  }

  void _pickChart() {
    api.getSum(year).then((result) {
      setDataSum(result);
    });

    setValue('Nenhum mês selecionado');
    if (type == 'Receita') {
      _makeDataIncome();
    } else if (type == 'Despesa') {
      _makeDataExpense();
    } else if (type == 'Total') {
      _makeDataTotal();
    }
  }

  @override
  void initState() {
    api.getSum(year).then((result) {
      setDataSum(result);
      _makeDataIncome();
    });

    api.getSumCategory(year).then((result) {
      setDataSumCategory(result);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(title: 'Gráficos'),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              DropdownButton(
                value: type,
                items: types,
                onChanged: (value) {
                  setType(value);
                },
                menuMaxHeight: 300,
                style: TextStyles.selectFont,
              ),
              const SizedBox(width: 10),
            ],
          ),
          Container(
            height: 35,
            decoration: BoxDecoration(
              color: AppColors.blue500,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Directionality(
              textDirection: ui.TextDirection.rtl,
              child: TextButton.icon(
                onPressed: _pickChart,
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
          const SizedBox(height: 20),
          Text(
            value == 'Nenhum mês selecionado'
                ? value
                : '$month: ' +
                    NumberFormat.simpleCurrency(locale: 'pt-BR').format(value),
          ),
          Expanded(
            child: charts.BarChart(
              _chartData,
              selectionModels: [
                charts.SelectionModelConfig(
                  changedListener: (charts.SelectionModel model) {
                    setValue(
                      model.selectedSeries[0]
                          .measureFn(model.selectedDatum[0].index),
                    );

                    setMonth(
                      model.selectedSeries[0]
                          .domainFn(model.selectedDatum[0].index),
                    );
                  },
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
