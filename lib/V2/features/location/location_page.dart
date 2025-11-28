import 'package:flutter/material.dart';
import 'package:nectar/V2/Core/theme/app_theme.dart';
import 'package:nectar/V2/features/location/location_page_vm.dart';
import 'package:provider/provider.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) async {
      final vm = Provider.of<LocationPageVm>(context, listen: false);
      await vm.getCountryCitiesList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationPageVm>(
      builder: (context, vm, child) {
        return Scaffold(
          backgroundColor: AppTheme.lightBackground,
          body: Stack(
            children: <Widget>[
              Image.asset(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                "assets/images/phonepageBc.png",
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 60,
                      left: 15,
                      bottom: 45,
                    ),
                    child: IconButton(
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset("assets/images/locationImg.png"),
                        ),
                        SizedBox(height: 40),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "Select Your Location",
                                style: TextStyle(
                                  color: AppTheme.textColor,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Gilroy',
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                textAlign: TextAlign.center,
                                "Switch on your location to stay in tune with what’s happening in your area",
                                style: TextStyle(
                                  color: AppTheme.secondaryText,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Gilroy',
                                ),
                              ),
                              SizedBox(height: 110),
                              vm.isloading ? Center(child: Container(child: Column(
                                children: [
                                  CircularProgressIndicator(color: AppTheme.mainColor),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "Getting Location Info",
                                    style: TextStyle(
                                      color: AppTheme.secondaryText,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Gilroy',
                                    ),
                                  ),
                                ],
                              ),),) : Column(
                                children: [
                                  DropdownButtonFormField<String>(
                                    menuMaxHeight: 300,
                                    items: vm.citiesList,
                                    onChanged: (value) => vm.onChanged(value),
                                    decoration: InputDecoration(
                                      labelText: 'Your zone',
                                      labelStyle: TextStyle(
                                        color: AppTheme.secondaryText,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Gilroy',
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFE2E2E2),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFE2E2E2),
                                        ),
                                      ),
                                    ),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    dropdownColor: Colors.white,
                                    elevation: 1,
                                    borderRadius: BorderRadius.circular(19),
                                  ),
                                  SizedBox(height: 30),
                                  TextFormField(
                                    controller: vm.areaController,
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFE2E2E2),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFE2E2E2),
                                        ),
                                      ),
                                      labelText: 'Your Area',
                                      labelStyle: TextStyle(
                                        color: AppTheme.secondaryText,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Gilroy',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
                              GestureDetector(
                                onTap: () {
                                  vm.submitUserLocation(
                                    vm.country ?? 'CountryName',
                                    vm.selectedCity ?? 'CityName',
                                    vm.areaController.text,
                                  );
                                  Navigator.of(context).pushNamed('/home_page');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppTheme.mainColor,
                                    borderRadius: BorderRadius.circular(19),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 24),
                                  child: Center(
                                    child:
                                        (vm.isloading)
                                            ? CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                            : Text(
                                              "Submit",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Gilroy',
                                              ),
                                            ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
