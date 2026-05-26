import 'package:flutter_riverpod/legacy.dart';

final usuariosProvider = StateProvider<List<String>>((ref) => []);
final usuarioActualProvider = StateProvider<String?>((ref) => '');
final usuarioLogeadoProvider = StateProvider<bool>((ref) => false); 