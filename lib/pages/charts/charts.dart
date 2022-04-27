import 'dart:math';
import 'package:amawfinance_mobile/components/app_bar_widget.dart';
import 'package:amawfinance_mobile/services/api.dart';
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

  List<Sum> _data = [];
  List<charts.Series<Sum, String>> _chartData = [];
  dynamic value = 'Nenhum mês selecionado';
  dynamic month = '';

  setValue(state) {
    setState(() {
      value = state;
    });
  }

  setMonth(state) {
    setState(() {
      month = state;
    });
  }

  setDataSum(state) {
    setState(() {
      dataSum = state;
    });
  }

  void _makeData() {
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
  }

  @override
  void initState() {
    api.getSum(year).then((result) {
      setDataSum(result);
      print(result);
      _makeData();
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
          const SizedBox(height: 100),
          Text('$month R\$ $value'),
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
