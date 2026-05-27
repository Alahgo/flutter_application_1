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


  factory Partida.fromJson(Map<String, dynamic> json) {
    return Partida(
      id: json['id'] ?? '',
      player1: json['player1'] ?? '',
      player2: json['player2'] ?? '',
     
      tablero: List<String>.from(json['tablero'] ?? List.filled(9, '')), 
      turnodeX: json['turnodeX'] ?? true,
      hayGanador: json['hayGanador'] ?? false,
    );
  }
}