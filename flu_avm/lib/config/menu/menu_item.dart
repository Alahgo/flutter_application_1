import "package:flutter/material.dart";

class MenuItem {
  final String titulus;
  final String subtitulus;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.titulus,
    required this.subtitulus,
    required this.link,
    required this.icon
  });
}

const appMenuItems = <MenuItem>[
  MenuItem(titulus: 'Contador',
    subtitulus: 'Introducción a Riverpod',
    link: '/numerato-river',
    icon: Icons.add),

    MenuItem(titulus: 'Bandas Musicales',
    subtitulus: 'Gráficos Pie Char y votaciones',
    link: '/bands',
    icon: Icons.music_note_outlined),

     MenuItem(titulus: 'Mapa',
    subtitulus: 'Localización de usuarios',
    link: '/charta',
    icon: Icons.map_outlined),

    MenuItem(titulus: 'Poke Appi',
    subtitulus: 'Peticiones http a una API',
    link: '/request',
    icon: Icons.catching_pokemon),

    MenuItem(titulus: 'Tres en Raya login',
    subtitulus: 'Solicitud para jugar al tres en raya',
    link: '/login',
    icon: Icons.gamepad_outlined),


];