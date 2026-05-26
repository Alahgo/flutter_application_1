import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/providers.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _inputUsu(context, ref),
        ),
      ),
    );
  }

  Widget _inputUsu(BuildContext context, WidgetRef ref) {
    final bool usuarioLogeado = ref.watch(usuarioLogeadoProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          enabled: !usuarioLogeado,
          // En lugar de usar un controller y un listener problemáticos, 
          // actualizamos el provider directamente cada vez que el usuario escribe
          onChanged: (texto) {
            ref.read(usuarioActualProvider.notifier).state = texto;
          },
          decoration: const InputDecoration(
            labelText: "Usuario",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _botonDesactivable(ref, 1, usuarioLogeado),
            _botonDesactivable(ref, 2, usuarioLogeado),
          ],
        ),
        FilledButton(
          
          onPressed: usuarioLogeado ? () {
            context.push('/game');
          } : null,

          child: const Text("Conectarse"),
        ),
      ],
    );
  }

  Widget _botonDesactivable(WidgetRef ref, int tipoBtn, bool usuarioLogeado) {
    bool activo = true;

    if (tipoBtn == 1 && usuarioLogeado) activo = false;
    if (tipoBtn == 2 && !usuarioLogeado) activo = false;

    return FilledButton(
      onPressed: activo
          ? () {
              if (tipoBtn == 1) {
                _addusuario(ref);
              } else if (tipoBtn == 2) {
                _removeUsuario(ref);
              }
            }
          : null,
      child: tipoBtn == 1 ? const Text("Registrar") : const Text("Desregistrar"),
    );
  }

  void _addusuario(WidgetRef ref) {

    final List<String> usuarios = ref.read(usuariosProvider);
    final String? usuarioActual = ref.read(usuarioActualProvider);
   
    if (usuarioActual != null && usuarioActual.isNotEmpty && !usuarios.contains(usuarioActual)) {
     
      final nuevaLista = [...usuarios, usuarioActual];

      ref.read(usuariosProvider.notifier).state = nuevaLista;
      ref.read(usuarioLogeadoProvider.notifier).state = true;
      print('--- Lista de Usuarios Actualizada (Registro) ---');
      for (var u in nuevaLista) {
        print(u);
      }
    }
  }

  void _removeUsuario(WidgetRef ref) {
   
    final List<String> usuarios = ref.read(usuariosProvider);
    final String? usuarioActual = ref.read(usuarioActualProvider);
   
    
    if (usuarioActual != null && usuarios.contains(usuarioActual)) {

      final nuevaLista = usuarios.where((u) => u != usuarioActual).toList();

      ref.read(usuariosProvider.notifier).state = nuevaLista;
      ref.read(usuarioActualProvider.notifier).state = '';
      ref.read(usuarioLogeadoProvider.notifier).state = false;

      print('--- Lista de Usuarios Actualizada (Desconexión) ---');
      if (nuevaLista.isEmpty) {
        print('(No hay usuarios registrados)');
      } else {
        for (var u in nuevaLista) {
          print(u);
        }
      }
      
    }
   
  }
}