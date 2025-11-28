import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nectar/V2/Data/services/api_service.dart';
import 'package:nectar/V2/Data/services/location_service.dart';

class LocationPageVm extends ChangeNotifier {
  List<DropdownMenuItem<String>> citiesList = [];
  String? country;
  String? selectedCity;
  bool isloading = false;
  bool isloadingLocation = false;
  final TextEditingController areaController = TextEditingController();

  Future getCountryCitiesList() async {
    isloadingLocation = true;
    notifyListeners();
    final String? userCountry = await ApiService.getUserCountry();
    if (userCountry == null) {
      return;
    }
    country = userCountry.toLowerCase();
    print(country);
    notifyListeners();

    final requestResult =
        await ApiService.getCountryCities(userCountry);
    final List<String> listOfCitiesString =
    await requestResult!.map((eachCity) => eachCity['name'].toString()).toList();
    if (kDebugMode) {
      print('Country Cities Fetched');
    }
    citiesList =
        listOfCitiesString.map((eachCityString) {
          return DropdownMenuItem(
            value: eachCityString,
            child: Text(
              eachCityString,
              style: TextStyle(
                color: Color(0xFF333333),
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          );
        }).toList();
    isloadingLocation = false;
    notifyListeners();
  }

  void onChanged(value) {
    selectedCity = value;
    notifyListeners();
  }

  Future<void> submitUserLocation(
    String country,
    String city,
    String area,
  ) async {
    isloading = true;
    notifyListeners();
    await LocationService.submitUserLoaction(country, city, area);
    isloading = false;
    notifyListeners();
  }
}
