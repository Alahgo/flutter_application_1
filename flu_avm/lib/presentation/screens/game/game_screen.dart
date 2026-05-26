import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
 
  List<String> _tablero = List.filled(9, '');
  

  bool _turnoDeX = true;
  
  
  String _mensajeEstado = 'Turno de: X';
  bool _juegoTerminado = false;

  
  void _jugarCasilla(int index) {
    
    if (_tablero[index].isNotEmpty || _juegoTerminado) return;

    setState(() {
      
      _tablero[index] = _turnoDeX ? 'X' : 'O';
      
     
      if (_comprobarGanador()) {
        _mensajeEstado = 'Ganador: ${_tablero[index]}';
        _juegoTerminado = true;
      } 
    
      else if (!_tablero.contains('')) {
        _mensajeEstado = 'Empate';
        _juegoTerminado = true;
      } 
    
      else {
        _turnoDeX = !_turnoDeX;
        _mensajeEstado = 'Turno de: ${_turnoDeX ? 'X' : 'O'}';
      }
    });
  }

 
  bool _comprobarGanador() {
    const combinacionesGanadoras = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], 
      [0, 3, 6], [1, 4, 7], [2, 5, 8], 
      [0, 4, 8], [2, 4, 6]             
    ];

    for (var combo in combinacionesGanadoras) {
      if (_tablero[combo[0]].isNotEmpty &&
          _tablero[combo[0]] == _tablero[combo[1]] &&
          _tablero[combo[0]] == _tablero[combo[2]]) {
        return true;
      }
    }
    return false;
  }

 
  void _reiniciarJuego() {
    setState(() {
      _tablero = List.filled(9, '');
      _turnoDeX = true;
      _mensajeEstado = 'Turno de: X';
      _juegoTerminado = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tres en Raya'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Texto informativo del estado de la partida
          Text(
            _mensajeEstado,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: _mensajeEstado.contains('Ganador') ? Colors.green : theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 30),
          
       //TABLERO DE JUEGO
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
                  final String ficha = _tablero[index];
                  
                  return GestureDetector(
                    onTap: () => _jugarCasilla(index),
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
            onPressed: _reiniciarJuego,
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