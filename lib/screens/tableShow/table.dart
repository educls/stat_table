import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stat_table/controllers/table_controller.dart';

class StatisticsTable extends StatelessWidget {
  StatisticsTable({super.key});

  final TableController instTable = Get.find<TableController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tabela de Estatística")
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Classe')),
            DataColumn(label: Text('Xi')),
            DataColumn(label: Text('Fi')),
            DataColumn(label: Text('FAC')),
            DataColumn(label: Text('Xi * Fi')),
          ],
          rows: instTable.tabela.map((row) {
            return DataRow(cells: [
              DataCell(Text(row.classe.toString())),
              DataCell(Text(row.xi.toString())),
              DataCell(Text(row.fi.toString())),
              DataCell(Text(row.fac.toString())),
              DataCell(Text(row.xifi.toString())),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
