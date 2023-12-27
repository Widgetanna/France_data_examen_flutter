import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/pages/communes-Page.dart';
import 'package:flutter_examen1/services/departement_service.dart';
import 'package:flutter_examen1/models/departements_models.dart';

class DepartementLister extends StatefulWidget {
  const DepartementLister({
    super.key,
    required this.regionCode,
    required this.region,
    required this.config,
  });

  final String regionCode;
  final String region;
  final Config config;

  @override
  State<DepartementLister> createState() => _DepartementListerState();
}

class _DepartementListerState extends State<DepartementLister> {
  late Future<DepartementList?> departements;

  late String region;
  late String regionCode;

  void loadDepartements() {
    setState(() {
      departements = DepartementService.getDepartements(widget.regionCode);
    });
  }

  @override
  void initState() {
    super.initState();
    region = widget.region;
    regionCode = widget.regionCode;
    loadDepartements();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: departements,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Departement> departements = snapshot.data!.departements;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                 color: const Color.fromARGB(255, 179, 207, 230),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "La région $region ($regionCode) compte ${departements.length} départements.\nCliquez sur l'un des département pour en savoir plus...",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.departements.length,
                    itemBuilder: (context, index) {
                      Departement departement = departements[index];
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              // You can customize Card properties here
                              child: ListTile(
                                title: Text(departement.nom),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Code du département: ${departement.code}"),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CommunesPage(
                                              config: widget.config,
                                              region: departement.nom,
                                              code: departement.code)));
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // Loading spinner
          return const CircularProgressIndicator();
        });
  }
}
