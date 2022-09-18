import 'dart:convert';

class Pill {
  late int id;
  late String registerNumber;
  late String name;
  late String expedientNumber;
  late String brand;
  late String cnpj;
  late String transactionNumber;
  late String processNumber;
  late String bulaIdPacient;
  late String bulaIdProfessional;

  Pill(
      this.id,
      this.registerNumber,
      this.name,
      this.expedientNumber,
      this.brand,
      this.cnpj,
      this.transactionNumber,
      this.processNumber,
      this.bulaIdPacient,
      this.bulaIdProfessional);

  Pill.fromJson(dynamic json) {
    id = json['idProduto'];
    name = json['nomeProduto'];
    expedientNumber = json['expediente'];
    brand = json['razaoSocial'];
    cnpj = json['cnpj'];
    transactionNumber = json['numeroTransacao'];
    processNumber = json['numProcesso'];
    bulaIdPacient = json['idBulaPacienteProtegido'];
    bulaIdProfessional = json['idBulaProfissionalProtegido'];
  }

  static Map<String, dynamic> toJson(Pill p) => {
        'idProduto': p.id,
        'nomeProduto': p.name,
        'expediente': p.expedientNumber,
        'razaoSocial': p.brand,
        'cnpj': p.cnpj,
        'numeroTransacao': p.transactionNumber,
        'numProcesso': p.processNumber,
        'idBulaPacienteProtegido': p.bulaIdPacient,
        'idBulaProfissionalProtegido': p.bulaIdProfessional,
      };

  static String encode(List<Pill> pills) => json.encode(
        pills.map<Map<String, dynamic>>((pill) => Pill.toJson(pill)).toList(),
      );

  static List<Pill> decode(String pills) =>
      (json.decode(pills) as List<dynamic>)
          .map<Pill>((pill) => Pill.fromJson(pill))
          .toList();

  @override
  String toString() {
    return 'Pill{_name: $name, _brand: $brand}';
  }
}
