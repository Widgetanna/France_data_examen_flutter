import 'package:flutter/material.dart';
import 'package:flutter_examen1/models/communes_models.dart';
import 'package:flutter_examen1/services/communes_service.dart';

class CommuneLister extends StatefulWidget {
  final String code;
  final String region;
  const CommuneLister({super.key, required this.code, required this.region});

  @override
  State<CommuneLister> createState() => _CommuneListerState();
}

class _CommuneListerState extends State<CommuneLister> {
  late Future<CommunesList?> communes;

  void loadCommunes() async {
    try {
      setState(() {
        communes = CommunesService.getCommunes(widget.code);
      });
    } catch (e) {
      print('Error loading communes: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadCommunes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: communes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Communes> communes = snapshot.data!.communes;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Color.fromARGB(255, 179, 207, 230),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Le département ${widget.region}  (${widget.code}) \ncompte ${communes.length} communes.\nCliquez sur l'un des communes pour en savoir plus...",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.communes.length,
                    itemBuilder: (context, index) {
                      Communes commune = communes[index];
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              // You can customize Card properties here
                              child: ListTile(
                                title: Text(commune.nom),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Code de la commune: ${commune.code}"),
                                  ],
                                ),
                                onTap: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Détails de la commune'),
                                    content: Text(
                                        'Nom: ${commune.nom}\n Code: ${commune.code}\n Code Dep.:  ${commune.code}\n Siren: ${commune.siren}\n Code Epci: ${commune.siren}\n Population:  ${commune.siren}\n Code Postaux: ${commune.codesPostaux}'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('Fermer'),
                                      ),
                                    ],
                                  ),
                                ),
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
