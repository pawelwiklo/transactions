import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:transactions/app_state.dart';
import 'package:transactions/extensions.dart';
import 'package:transactions/models/chart_model.dart';
import 'package:transactions/models/transaction.dart';

class DiagramPage extends StatelessWidget {
  const DiagramPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: DonutChart(),
      ),
    );
  }
}

class DonutChart extends StatelessWidget {
  const DonutChart({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Transaction>?>(
      converter: (store) => store.state.data,
      builder: (context, data) {
        if (data != null && data.isNotEmpty) {
          final groupedTransactions = groupTransactionsByOperationType(data);

          final chartData = groupedTransactions.entries
              .map((entry) => ChartModel(
                    operationType: entry.key,
                    count: entry.value.length,
                  ))
              .toList();

          return SfCircularChart(
            title: ChartTitle(text: 'Transactions'),
            legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
            ),
            series: <CircularSeries>[
              DoughnutSeries<ChartModel, String>(
                radius: '80%',
                explode: true,
                explodeOffset: '10%',
                dataSource: chartData,
                xValueMapper: (ChartModel chartModel, _) =>
                    chartModel.operationType.name.capitalize(),
                yValueMapper: (ChartModel chartModel, _) => chartModel.count,
                dataLabelMapper: (ChartModel chartModel, _) =>
                    '${chartModel.operationType.name.capitalize()}: ${chartModel.count}',
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
            ],
          );
        } else {
          return const Text('No data available');
        }
      },
    );
  }

  Map<OperationType, List<Transaction>> groupTransactionsByOperationType(
    List<Transaction> transactions,
  ) {
    final groupedTransactions = <OperationType, List<Transaction>>{};
    transactions.forEach((transaction) {
      groupedTransactions.putIfAbsent(
        transaction.operation_type,
        () => <Transaction>[],
      );
      groupedTransactions[transaction.operation_type]!.add(transaction);
    });
    return groupedTransactions;
  }
}
