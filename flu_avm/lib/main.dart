import 'package:flu_avm/config/config.dart';
import 'package:flu_avm/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp()
      )
    );
}
//Hola esto es una prueba de commit
class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final tenebrisModus = ref.watch(estTenebrisModusProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(
        electusColor:Colors.deepOrangeAccent.shade100,
        tenebrisModusEst: tenebrisModus
        ).getTheme(),
    );
  }
}