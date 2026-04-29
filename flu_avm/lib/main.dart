import 'package:flu_avm/config/config.dart';
import 'package:flu_avm/presentation/screens/screens.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}
//Hola esto es una prueba de commit
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(
        electusColor:Colors.deepOrangeAccent
        ).getTheme(),
      
    );
  }
}