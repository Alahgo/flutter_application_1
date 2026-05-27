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
    
    // 1. Escuchamos el estado completo del socket desde el loginProvider
    final serverState = ref.watch(loginProvider);

    // 2. Control de estados de la conexión antes de pintar el juego
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

    // 3. Generamos el mensaje de estado dinámicamente según lo que mande el server
    String mensajeEstado = '';
    if (partida.hayGanador) {
      mensajeEstado = '¡Tenemos un ganador!';
    } else if (!partida.tablero.contains('')) {
      dynamic mensajeEstado = 'Empate';
    } else {
      mensajeEstado = 'Turno de: ${partida.turnodeX ? "X" : "O"}';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${partida.player1} VS ${partida.player2.isEmpty ? "Esperando rival..." : partida.player2}'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Texto informativo del estado de la partida en el servidor
          Text(
            mensajeEstado,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: partida.hayGanador ? Colors.green : theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 30),
          
          // TABLERO DE JUEGO ONLINE
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
                    // Al pulsar mandamos la casilla al server usando el notifier
                    onTap: () {
                      if (ficha.isEmpty && !partida.hayGanador) {
                        ref.read(loginProvider.notifier).ponerFicha(index);
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
          
          // BOTÓN REINICIAR (Avisa al servidor para limpiar el singleton global)
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