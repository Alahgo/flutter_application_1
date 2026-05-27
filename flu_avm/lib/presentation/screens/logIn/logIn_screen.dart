import 'package:flu_avm/presentation/providers/logIn_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/config.dart';
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

  final String? usuarioActual = ref.read(usuarioActualProvider);
  final serverState = ref.read(loginProvider);
  final Partida? partidaActual = serverState.partida;

 
  if (usuarioActual != null && 
      usuarioActual.isNotEmpty && 
      partidaActual?.player1 != usuarioActual &&
      partidaActual?.player2 != usuarioActual) {

    ref.read(loginProvider.notifier).unirseALaPartida(usuarioActual);
    
    print('Enviando usuario al servidor: $usuarioActual');
    

    }   
  }
  

  void _removeUsuario(WidgetRef ref) {
   
    final String? usuarioActual = ref.read(usuarioActualProvider);
    final serverState = ref.read(loginProvider);
    final Partida? partidaActual = serverState.partida;
   
    
    if (usuarioActual != null &&
        partidaActual?.player1 == usuarioActual|| 
        partidaActual?.player2 == usuarioActual) {

      ref.read(loginProvider.notifier).salirDeLaPartida(usuarioActual!);
      
    }
   
  }
}