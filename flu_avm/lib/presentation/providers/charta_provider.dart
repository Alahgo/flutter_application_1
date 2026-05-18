import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';


// Init var
final Position initialisMarkerPosition = Position(-122.467895, 37.800126);


//Providers
final formColorProvider = StateProvider<Color>((ref) => Colors.red);
final formNomenProvider = StateProvider<String>((ref) => '');
final markerPositumProvider = StateProvider<bool>((ref) => false);
final coordsMarkerProvider = StateProvider<Position>((ref) => initialisMarkerPosition);