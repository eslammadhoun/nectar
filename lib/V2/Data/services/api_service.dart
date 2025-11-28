import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:nectar/V2/Data/services/location_service.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const apiKey = 'bcb27a258b4d4107b08ee180de1e06fe';
  static const baseUrl = 'https://api.geoapify.com/v1/geocode';

  // get user country from enterd lat & long
  static Future<String?> getUserCountry() async {
  try {
    final Position? pos = await LocationService.getLatLong();
    if (pos == null) return null;

    final url = '$baseUrl/reverse?lat=${pos.latitude}&lon=${pos.longitude}&apiKey=$apiKey';
    final getResponse = await http.get(Uri.parse(url));

    if (getResponse.statusCode == 200) {
      return jsonDecode(getResponse.body)['features'][0]['properties']['country_code'];
    }
    return null;
  } catch (e) {
    print("Error in getUserCountry: $e");
    return null;
  }
}

  // get All Country Cities from it's Country Name
  static Future<List<Map<String,dynamic>>?> getCountryCities(String? countryName) async {
    final String url =
        'https://api.countrystatecity.in/v1/countries/$countryName/states';

    final getResponse = await http.get(Uri.parse(url), headers: {
      'X-CSCAPI-KEY' : 'Q3pmdlJ0V0pRZjI3QVJROGIyVEJ3U3pDZm9QSFl0d25hV2k4RUgwMw=='
    });
    if (getResponse.statusCode == 200) {
      final List<dynamic> cities = jsonDecode(getResponse.body);
      List<Map<String,dynamic>> listOfCities = List<Map<String,dynamic>>.from(cities);
      return listOfCities;
    } else {
      return null;
    }
  }
}
