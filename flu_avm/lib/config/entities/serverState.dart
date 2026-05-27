import '../../config/config.dart';

class ServerState {
  final bool isConnected;
  final Partida? partida;
  final bool puedeComenzar; 

  ServerState({
    this.isConnected = false, 
    this.partida,
    this.puedeComenzar = false, 
  });

  ServerState copyWith({
    bool? isConnected,
    Partida? partida,
    bool? puedeComenzar,
  }) {
    return ServerState(
      isConnected: isConnected ?? this.isConnected,
      partida: partida ?? this.partida,
      puedeComenzar: puedeComenzar ?? this.puedeComenzar, 
    );
  }
}