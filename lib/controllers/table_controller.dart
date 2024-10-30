import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stat_table/controllers/frequency_controller.dart';
import 'package:stat_table/models/table.dart';
import 'package:stat_table/screens/frequency_input_page.dart';

class TableController extends GetxController {
  final TextEditingController limiteInferiorController = TextEditingController();
  final TextEditingController limiteSuperiorController = TextEditingController();
  final TextEditingController intervaloClassesController = TextEditingController();

  Rx<bool> isLoading = false.obs;
  void setLoading(bool value) {
    isLoading.value = value;
    update();
  }

  List<Map<String, double>> classes = [];

  List<ITable> tabela = [];

  void calcularTabela() async {
    setLoading(true);
    final limiteInferior = double.tryParse(limiteInferiorController.text);
    final limiteSuperior = double.tryParse(limiteSuperiorController.text);
    final intervaloClasses = double.tryParse(intervaloClassesController.text);

    if (limiteInferior == null || limiteSuperior == null || intervaloClasses == null) {
      Get.snackbar("Erro", "Insira valores válidos.");
      return;
    }

    classes.clear();
    double inicio = limiteInferior;
    double fim = inicio + intervaloClasses;

    while (inicio < limiteSuperior) {
      classes.add({"limiteInferior": inicio, "limiteSuperior": fim});
      inicio = fim;
      fim += intervaloClasses;
    }
    await Future.delayed(const Duration(milliseconds: 700));
    Get.to(() => FrequenciasPage(classes: classes));
    setLoading(false);
  }
}
