import 'dart:convert';
import 'package:flutter_examen1/models/communes_models.dart';
import 'package:http/http.dart' as http;


class CommunesService {
 String code;

 CommunesService({required this.code});
  
  static String communesUrl = 'https://geo.api.gouv.fr/departements';


  
  static Future<CommunesList?> getCommunes(code) async {
    try {
      
       final response = await http.get(Uri.parse('$communesUrl/$code/communes'));
     print('____$communesUrl/$code/communes');
      
      if (response.statusCode == 200) {
        final jsonresponse = json.decode(response.body);
        print(jsonresponse);
        print('+++++$response');
        print(response.statusCode);
        final CommunesList communes = CommunesList.fromJson(jsonresponse);
  
        if (communes.communes.isNotEmpty) {
          return communes;
        } else {
          throw Exception('No products available');
        }
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Unable to load products');
    }
  }
  
}
