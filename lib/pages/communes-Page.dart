import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/commune_lister.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/components/sliding_menu.dart';

class CommunesPage extends StatelessWidget {
  final Config config;
  final String code;
  final String region;

  CommunesPage({
    Key? key,
    required this.config,
    required this.code,
    required this.region,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Departement: $region",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: SlideMenu(
        config: config,
        currentPage: config.get('page-name.regions'),
      ),
      body: CommuneLister(
        code: code,
        region: region
        
      ),
    );
  }
}
