import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';


final formColorProvider = StateProvider<Color>((ref) => Colors.red);
final formNomenProvider = StateProvider<String>((ref) => '');
final markerPositumProvider = StateProvider<bool>((ref) => false);