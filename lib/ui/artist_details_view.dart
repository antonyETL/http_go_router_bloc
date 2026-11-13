import 'package:flutter/material.dart';

import '../model/artist.dart';
import 'artist_field.dart';

/// Presentazione condivisa dei dati dell'artista e dei tre stati della richiesta.
class ArtistDetailsView extends StatelessWidget {
  const ArtistDetailsView({
    required this.isLoading,
    this.artist,
    this.errorMessage,
    this.onRetry,
    super.key,
  });

  final bool isLoading;
  final Artist? artist;
  final String? errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 40),
              const SizedBox(height: 12),
              const Text('Impossibile caricare l’artista.'),
              const SizedBox(height: 8),
              SelectableText(errorMessage!),
              if (onRetry != null) ...[
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: onRetry,
                  child: const Text('Riprova'),
                ),
              ],
            ],
          ),
        ),
      );
    }

    if (artist == null) {
      return const Center(child: Text('Nessun dato disponibile.'));
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  artist!.nome,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Divider(height: 28),
                ArtistField(label: 'ID', value: artist!.id.toString()),
                ArtistField(label: 'Nazione', value: artist!.nazione),
                ArtistField(
                  label: 'Anno di inizio',
                  value: artist!.annoInizio.toString(),
                ),
                ArtistField(
                  label: 'Tipo',
                  value: artist!.gruppo == 'S' ? 'Gruppo' : 'Solista',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
