import 'package:flu_avm/presentation/providers/logIn_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../config/config.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    final serverState = ref.watch(loginProvider);

    if (!serverState.isConnected) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Conectando al servidor Bun...', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      );
    }

    final Partida? partida = serverState.partida;

    if (partida == null) {
      return const Scaffold(
        body: Center(
          child: Text('Esperando sincronización de la partida...'),
        ),
      );
    }

 
    if (partida.player1.isEmpty || partida.player2.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Hola, ${partida.player1.isNotEmpty ? partida.player1 : "Jugador"}'),
          centerTitle: true,
          automaticallyImplyLeading: false, 
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 24),
              const Text(
                'Esperando a que se conecte un rival...'
              ),
              const SizedBox(height: 8),
              Text(
                'Código de partida: ${partida.id}',
                style: TextStyle(color: theme.colorScheme.outline),
              ),
            ],
          ),
        ),
      );
    }

    String mensajeEstado = '';
    if (partida.hayGanador) {
      mensajeEstado = '¡Tenemos un ganador!';
    } else if (!partida.tablero.contains('')) {
      mensajeEstado = 'Empate';
    } else {
      mensajeEstado = 'Turno de: ${partida.turnodeX ? "X" : "O"}';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${partida.player1} VS ${partida.player2}'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            mensajeEstado,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: partida.hayGanador ? Colors.green : theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 30),
          
          // TABLERO DE JUEGO ONLINE CON BUN SERVER BACKEND
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: AspectRatio(
              aspectRatio: 1, 
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(), 
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,        
                  crossAxisSpacing: 8.0,    
                  mainAxisSpacing: 8.0,     
                ),
                itemBuilder: (context, index) {
                  final String ficha = partida.tablero[index];
                  
                  return GestureDetector(
                    onTap: () {

                      //CONTROL DE TURNOS
                      //Simplemente no dejo poner fichas en el turno que no toca en relación al 
                      //player actual siendo player1 las X
                      //y player2 las O
                      if (ficha.isEmpty &&
                       !partida.hayGanador ) {
                        
                        if(ref.read(usuarioActualProvider) ==  partida.player1 &&
                          partida.turnodeX){

                             ref.read(loginProvider.notifier).ponerFicha(index);

                        }else if(ref.read(usuarioActualProvider) ==  partida.player2 &&

                          !partida.turnodeX){
                           ref.read(loginProvider.notifier).ponerFicha(index);

                        }
                       
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: ficha.isEmpty 
                              ? theme.colorScheme.outlineVariant 
                              : (ficha == 'X' ? Colors.blue : Colors.red),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          ficha,
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: ficha == 'X' ? Colors.blue : Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 40),
          
          FilledButton.icon(
            onPressed: () {
              ref.read(loginProvider.notifier).reiniciarPartida();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Reiniciar Juego'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}