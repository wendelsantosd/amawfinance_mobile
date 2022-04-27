import 'dart:math';
import 'package:amawfinance_mobile/components/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Charts extends StatefulWidget {
  const Charts({Key? key}) : super(key: key);

  @override
  _ChartsState createState() => _ChartsState();
}

class Sum {
  String month;
  int amount;

  Sum(this.month, this.amount);
}

class _ChartsState extends State<Charts> {
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

  void _makeData() {
    _data = <Sum>[];
    _chartData = <charts.Series<Sum, String>>[];

    final rnd = Random();

    // for (int i = 2010; i < 2019; i++) {
    //   _data.add(Sum(i.toString(), rnd.nextInt(1000)));
    // }

    _data.add(Sum('Jan', rnd.nextInt(1000)));
    _data.add(Sum('Fev', rnd.nextInt(1000)));
    _data.add(Sum('Mar', rnd.nextInt(1000)));
    _data.add(Sum('Abr', rnd.nextInt(1000)));
    _data.add(Sum('Mai', rnd.nextInt(1000)));
    _data.add(Sum('Jun', rnd.nextInt(1000)));
    _data.add(Sum('Jul', rnd.nextInt(1000)));
    _data.add(Sum('Ago', rnd.nextInt(1000)));
    _data.add(Sum('Set', rnd.nextInt(1000)));
    _data.add(Sum('Out', rnd.nextInt(1000)));
    _data.add(Sum('Nov', rnd.nextInt(1000)));
    _data.add(Sum('Dez', rnd.nextInt(1000)));

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
