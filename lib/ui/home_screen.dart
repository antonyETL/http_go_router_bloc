import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Home didattica: spiega le tre varianti e offre collegamenti diretti.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _pages = [
    (
      title: 'Artista None',
      description: 'FutureBuilder con gestione locale e basilare del caricamento.',
      path: '/artist-none',
      icon: Icons.person_outline,
    ),
    (
      title: 'Artista Cubit',
      description: 'Cubit espone gli stati di caricamento, successo ed errore.',
      path: '/artist-cubit',
      icon: Icons.bolt_outlined,
    ),
    (
      title: 'Artista Bloc',
      description: 'Bloc riceve un evento e produce lo stato per la schermata.',
      path: '/artist-bloc',
      icon: Icons.account_tree_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo Flutter: artisti')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Dio + go_router + Bloc',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text(
            'Scegli una schermata per confrontare tre modi di caricare '
            'gli stessi dati REST.',
          ),
          const SizedBox(height: 20),
          for (final page in _pages)
            Card(
              child: ListTile(
                leading: Icon(page.icon),
                title: Text(page.title),
                subtitle: Text(page.description),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go(page.path),
              ),
            ),
          const SizedBox(height: 12),
          const Text(
            'Servizio: GET http://localhost:8090/music/api/v1/artists/1',
          ),
        ],
      ),
    );
  }
}
