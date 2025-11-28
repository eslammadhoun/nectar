import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position?> getLatLong() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    Position positionInLatLong = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print(positionInLatLong);
    return positionInLatLong;
  }

  static Future<void> submitUserLoaction(
    String country,
    String city,
    String area,
  ) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'user_Location': '$country, $city, $area'});
  }

  static Future<String> getCurrentUserLocation() async {
    final currentUserDocument =
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    final userDocumentData = currentUserDocument.data() as Map<String, dynamic>;
    if (userDocumentData.containsKey('user_Location')) {
      return userDocumentData['user_Location'];
    } else {
      return 'User Location Not Found Try Agin Later';
    }
  }
}
