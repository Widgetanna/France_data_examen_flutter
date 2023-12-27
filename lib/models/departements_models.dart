class Departement  {
    String nom;
    String code;
    String codeRegion;

  Departement({
        required this.nom,
        required this.code,
        required this.codeRegion,
    });
    
    factory Departement.fromJson(Map<String, dynamic> json) => Departement(
        nom: json["nom"],
        code: json["code"],
        codeRegion: json["codeRegion"],
    );
    
     String get getNom => nom;
     String get getCode => code;
     String get getcodeRegion => codeRegion;
}
  class DepartementList {
  final List<Departement> departements;

  DepartementList({required this.departements});

  factory DepartementList .fromJson(List<dynamic> parseJson) {
    List<Departement> departements = <Departement>[];
   departements = parseJson.map((e) => Departement.fromJson(e)).toList();
    return DepartementList (departements: departements);
  }
    }