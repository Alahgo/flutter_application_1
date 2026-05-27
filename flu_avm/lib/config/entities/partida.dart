class Partida {
  final String id;
  final String player1;
  final String player2;
  final List<String> tablero;
  final bool turnodeX;
  final bool hayGanador;

  Partida({
    required this.id,
    required this.player1,
    required this.player2,
    required this.tablero,
    required this.turnodeX,
    required this.hayGanador,
  });

  // Este método recibe el mapa de datos del servidor Bun y lo convierte en la clase Partida
  factory Partida.fromJson(Map<String, dynamic> json) {
    return Partida(
      id: json['id'] ?? '',
      player1: json['player1'] ?? '',
      player2: json['player2'] ?? '',
      // Convierte el array dinámico del servidor en una Lista de Strings para evitar errores de tipo
      tablero: List<String>.from(json['tablero'] ?? List.filled(9, '')), 
      turnodeX: json['turnodeX'] ?? true,
      hayGanador: json['hayGanador'] ?? false,
    );
  }
}