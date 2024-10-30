import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stat_table/controllers/table_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TableController instTable = Get.put(TableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de Tabela Estatística"),
      ),
      body: Obx(() {
        // Observa as mudanças na variável isLoading
        return instTable.isLoading.value
            ? const Center(child: CircularProgressIndicator(color: Colors.black,))
            : buildBody();
      }),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: instTable.limiteInferiorController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Limite Inferior",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: instTable.limiteSuperiorController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Limite Superior",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: instTable.intervaloClassesController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Intervalo das Classes",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: instTable.calcularTabela,
            child: const Text("Calcular Classes"),
          ),
        ],
      ),
    );
  }
}
