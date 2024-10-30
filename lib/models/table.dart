class ITable {
  final String classe;
  final double? xi;
  final int? fi;
  final double? fac;
  final double? xifi;

  ITable({
    required this.classe,
    this.xi,
    this.fi,
    this.fac,
    this.xifi,
  });

  Map<String, dynamic> toMap() {
    return {
      "Classe": classe,
      "Xi": xi,
      "Fi": fi,
      "FAC": fac,
      "Xi * Fi": xifi,
    };
  }
}
