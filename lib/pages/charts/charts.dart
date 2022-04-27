import 'dart:math';

import 'package:amawfinance_mobile/components/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Charts extends StatefulWidget {
  const Charts({Key? key}) : super(key: key);

  @override
  _ChartsState createState() => _ChartsState();
}

class Sales {
  String year;
  int sales;

  Sales(this.year, this.sales);
}

class _ChartsState extends State<Charts> {
  List<Sales> _data = [];
  List<charts.Series<Sales, String>> _chartdata = [];

  void _makeData() {
    _data = <Sales>[];
    _chartdata = <charts.Series<Sales, String>>[];

    final rnd = Random();

    // for (int i = 2010; i < 2019; i++) {
    //   _data.add(Sales(i.toString(), rnd.nextInt(1000)));
    // }

    _data.add(Sales('Jan', rnd.nextInt(1000)));
    _data.add(Sales('Fev', rnd.nextInt(1000)));
    _data.add(Sales('Mar', rnd.nextInt(1000)));
    _data.add(Sales('Abr', rnd.nextInt(1000)));
    _data.add(Sales('Mai', rnd.nextInt(1000)));
    _data.add(Sales('Jun', rnd.nextInt(1000)));
    _data.add(Sales('Jul', rnd.nextInt(1000)));
    _data.add(Sales('Ago', rnd.nextInt(1000)));
    _data.add(Sales('Set', rnd.nextInt(1000)));
    _data.add(Sales('Out', rnd.nextInt(1000)));
    _data.add(Sales('Nov', rnd.nextInt(1000)));
    _data.add(Sales('Dez', rnd.nextInt(1000)));

    _chartdata.add(
      charts.Series(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        data: _data,
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        displayName: 'Sales',
      ),
    );
  }

  @override
  void initState() {
    _makeData();
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
          const Text('Sales Data'),
          Expanded(
            child: charts.BarChart(_chartdata),
          )
        ]),
      ),
    );
  }
}
