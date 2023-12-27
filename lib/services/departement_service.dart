import 'dart:convert';
import 'package:flutter_examen1/models/departements_models.dart';
import 'package:http/http.dart' as http;

class DepartementService {
    final String code; 
  
  static String departementUrl = 'https://geo.api.gouv.fr/regions';
  
  DepartementService (this.code);


 static Future<DepartementList?> getDepartements(code) async {
try {
  
      final response = await http
          .get(Uri.parse('$departementUrl/$code/departements'));

      if (response.statusCode == 200) {
        final jsonresponse = json.decode(response.body);
        print(jsonresponse);

        final DepartementList departements = DepartementList.fromJson(jsonresponse);

        if (response.body.isNotEmpty) {
          return departements;
        } else {
          throw Exception('No products available');
        }
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Unable to load products');
    }
  }

}

