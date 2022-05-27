import 'dart:convert';
import 'dart:developer';

import 'package:cubit_movies/data/local/preferences.dart';
import 'package:cubit_movies/domain/models/location_model.dart';
import 'package:cubit_movies/presentation/di/locator.dart';
import 'package:cubit_movies/shared/utils/utils.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<void> determineLocation() async {
    try {
      final Preferences _pref = locator<Preferences>();
      LocationModel? locationDTO;
      final bool enabled;
      if (kIsWeb) {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission != LocationPermission.always || permission != LocationPermission.whileInUse) {
          permission = await Geolocator.requestPermission();
        }
        enabled = permission != LocationPermission.denied && permission != LocationPermission.deniedForever;
      } else {
        enabled = await Permission.location.request().isGranted;
      }
      if (enabled) {
        Position? position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        final double latitude = position.latitude;
        final double longitude = position.longitude;
        if (!kIsWeb) {
          final List<Placemark> placeMarks = await placemarkFromCoordinates(
            latitude,
            longitude,
            localeIdentifier: getLangCode(),
          );
          if (placeMarks.isNotEmpty) {
            locationDTO = LocationModel(
              country: placeMarks[0].country ?? '',
              city: placeMarks[0].locality ?? '',
              latitude: latitude,
              longitude: longitude,
            );
          } else {
            locationDTO = LocationModel(
              country: '',
              city: '',
              latitude: latitude,
              longitude: longitude,
            );
          }
        } else {
          locationDTO = LocationModel(
            country: '',
            city: '',
            latitude: latitude,
            longitude: longitude,
          );
        }
      }
      if (locationDTO != null) {
        await _pref.setCurrentLocation(jsonEncode(locationDTO.toJson()));
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
