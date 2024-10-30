import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stat_table/utils/table.dart';

class FrequencyController extends GetxController {
  late List<TextEditingController> freqControllers;
  final List<Map<String, double>> classes;

  Rx<bool> isLoading = false.obs;
  void setLoading(bool value) {
    isLoading.value = value;
    update();
  }

  FrequencyController({required this.classes});

  void calcularTabela() async {
    setLoading(true);

    List<int> frequencias = [];

    for (var controller in freqControllers) {
      int? fi = int.tryParse(controller.text);
      if (fi == null) {
        Get.snackbar("Erro", "Insira frequências válidas para todas as classes.");
        return;
      }
      frequencias.add(fi);
    }
    // print(frequencias);

    // Cria a instância de TabelaEstatistica com os limites e o intervalo
    TabelaEstatistica tabelaEstatistica = TabelaEstatistica(
      classes.first['limiteInferior']!,
      classes.last['limiteSuperior']!,
      classes.length > 0 ? (classes[1]['limiteInferior']! - classes[0]['limiteInferior']!) : 0,
    );

    // Passa as frequências para a tabela
    tabelaEstatistica.definirFrequencias(frequencias);
    await Future.delayed(const Duration(milliseconds: 700));
    // Exibir a tabela completa
    tabelaEstatistica.exibirTabela();
    setLoading(false);
  }
}

