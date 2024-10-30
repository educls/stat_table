import 'dart:convert';

import 'package:get/get.dart';
import 'package:stat_table/controllers/table_controller.dart';
import 'package:stat_table/models/table.dart';
import 'package:stat_table/screens/tableShow/table.dart';

class TabelaEstatistica {
  double limiteInferior;
  double limiteSuperior;
  double intervaloClasses;
  List<ITable> tabela = [];

  final TableController instTable = Get.find<TableController>();

  // Inicializamos a classe com limites e intervalo, e chamamos _montarClasses()
  TabelaEstatistica(this.limiteInferior, this.limiteSuperior, this.intervaloClasses) {
    _montarClasses();
  }

  // Monta apenas as classes com 'classe' e 'xi' (sem frequências)
  void _montarClasses() {
    double inicio = limiteInferior;
    double fim = limiteInferior + intervaloClasses;

    while (inicio < limiteSuperior) {
      double xi = (inicio + fim) / 2; // Ponto médio da classe

      tabela.add(ITable(
        classe: "$inicio |--- $fim",
        xi: xi,
        fi: 0,
        fac: 0.0,
        xifi: 0.0,
      ));

      inicio = fim;
      fim += intervaloClasses;
    }
  }

  // Recebe as frequências e calcula a tabela completa com FAC e Xi * Fi
  void definirFrequencias(List<int> frequencias) {
    if (frequencias.length != tabela.length) {
      throw ArgumentError("Número de frequências não corresponde ao número de classes.");
    }

    double fac = 0.0; // FAC deve ser inicializado como double

    for (int i = 0; i < tabela.length; i++) {
      int fi = frequencias[i];
      
      // Validação para não permitir frequências negativas
      if (fi < 0) {
        throw ArgumentError("Frequência não pode ser negativa.");
      }

      double xi = tabela[i].xi!;
      double xifi = xi * fi;
      fac += fi;

      tabela[i] = ITable(
        classe: tabela[i].classe,
        xi: xi,
        fi: fi,
        fac: fac,
        xifi: xifi,
      );
    }
  }

  // Retorna a tabela completa como uma lista de mapas
  List<Map<String, dynamic>> obterTabela() {
    return tabela.map((linha) {
      return {
        "classe": linha.classe,
        "xi": linha.xi,
        "fi": linha.fi,
        "fac": linha.fac,
        "xifi": linha.xifi,
      };
    }).toList();
  }

  // Exibir a tabela completa para conferência (opcional)
  void exibirTabela() {
    // print("Classe\t\tXi\tFi\tFAC\tXi * Fi");
    // for (var linha in tabela) {
    //   print("${linha.classe}\t\t${linha.xi}\t${linha.fi}\t${linha.fac}\t${linha.xifi}");
    // }
    instTable.tabela = tabela;
    print(jsonEncode(tabela.map((linha) => linha.toMap()).toList()));
    Get.to(() => StatisticsTable());
  }
}
