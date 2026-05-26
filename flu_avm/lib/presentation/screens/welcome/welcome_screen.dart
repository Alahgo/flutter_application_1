// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flu_avm/presentation/providers/providers.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool estTenebrisModus = ref.watch(estTenebrisModusProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border.all(color: theme.colorScheme.outline),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.data_object_rounded, size: 24),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Flu Avm',
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      ref.read(estTenebrisModusProvider.notifier).update((state) => !state);
                    },
                    icon: Icon(
                      estTenebrisModus ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                      size: 24,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.colorScheme.outline),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text('WS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/movil.png', width: 60, height: 60, fit: BoxFit.contain),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.asset('assets/images/puntos.png', height: 20, fit: BoxFit.contain),
                        ),
                      ),
                      Image.asset('assets/images/servidor.png', width: 60, height: 60, fit: BoxFit.contain),
                    ],
                  ),
                ],
              ),

              const Spacer(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(33, 76, 175, 79),
                      border: Border.all(color: const Color.fromARGB(255, 76, 175, 79)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '• CONECTADO',
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'WebSockets en vivo',
                    style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Aprende a construir apps con datos en tiempo real en Flutter. Dos ejemplos prácticos te esperan dentro.',
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),

              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: _MenuCard(
                      title: 'Mapas',
                      subtitle: 'Ubicación en tiempo real',
                      imagePath: 'assets/images/mapa.jpg',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _MenuCard(
                      title: 'Votaciones',
                      subtitle: 'Gráfico que se actualiza',
                      imagePath: 'assets/images/votaciones.jpg',
                    ),
                  ),
                ],
              ),

              const Spacer(),

            IntrinsicHeight( 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch, 
                children: [
                  Expanded(child: _InfoStatWidget(title: '5', subtitle: 'PANTALLAS')),
                  const SizedBox(width: 8),
                  Expanded(child: _InfoStatWidget(title: '2', subtitle: 'WEBSOCKETS')),
                  const SizedBox(width: 8),
                  Expanded(child: _InfoStatWidget(title: 'AL', subtitle: 'Alejandro Lahiguera')),
                ],
              ),
            ),

            const Spacer(),

              FilledButton(
                onPressed: () {
                  context.push('/home');
                },
                
                style: FilledButton.styleFrom(
                  backgroundColor: const Color.fromARGB(206, 207, 97, 23),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('→ Comenzar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const _MenuCard({required this.title, required this.subtitle, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: const Color.fromARGB(80, 255, 158, 128),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(imagePath, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_outlined);
                  }),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(
              subtitle, 
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoStatWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const _InfoStatWidget({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title, 
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary)
          ),
          const SizedBox(height: 2),
          Text(
            subtitle, 
            style: theme.textTheme.bodySmall?.copyWith(fontSize: 9, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}