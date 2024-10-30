import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stat_table/controllers/frequency_controller.dart';
import 'package:stat_table/controllers/table_controller.dart';

class FrequenciasPage extends StatelessWidget {
  final List<Map<String, double>> classes;
  final List<TextEditingController> frequenciaControllers = [];

  FrequenciasPage({required this.classes, super.key}) {
    for (var i = 0; i < classes.length; i++) {
      frequenciaControllers.add(TextEditingController());
    }
  }

  final TableController instTable = Get.find<TableController>();
  late final FrequencyController instFreq = Get.put(FrequencyController(classes: classes));
  

  @override
  Widget build(BuildContext context) {
    instFreq.freqControllers = frequenciaControllers;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inserir Frequências (Fi)"),
      ),
      body: Obx((){
        return instFreq.isLoading.value
            ? const Center(child: CircularProgressIndicator(color: Colors.black,))
            : buildBody();
      }),
    );
  }

  Widget buildBody(){
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Insira as frequências para cada classe:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: classes.length,
                itemBuilder: (context, index) {
                  final classe = classes[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Text(
                          "[${classe['limiteInferior']} - ${classe['limiteSuperior']}]",
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: frequenciaControllers[index],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Frequência (Fi)",
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: instFreq.calcularTabela,
              child: const Text("Calcular Tabela"),
            ),
          ],
        ),
      );
  }
}
