import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/artist_bloc.dart';
import '../state/artist_load_requested.dart';
import '../state/artist_load_state.dart';
import 'artist_details_view.dart';

/// Variante Bloc: il retry mostra il flusso evento -> elaborazione -> stato.
///
/// La schermata estende `StatelessWidget` perché non conserva dati propri:
/// legge lo stato corrente dal Bloc e lascia che `BlocBuilder` aggiorni la UI.
class ArtistBlocScreen extends StatelessWidget {
  /// `super.key` inoltra la chiave opzionale al costruttore di `StatelessWidget`.
  const ArtistBlocScreen({super.key});

  /// `@override` indica che questo metodo implementa `build` della superclasse.
  /// Il `BuildContext` identifica la posizione del widget nell'albero Flutter.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Artista Bloc')),
      // I tipi tra parentesi angolari specificano il Bloc ascoltato e il tipo
      // di stato fornito al callback `builder`.
      body: BlocBuilder<ArtistBloc, ArtistLoadState>(
        // Funzione anonima con due parametri: il contesto e lo stato corrente.
        builder: (context, state) {
          return ArtistDetailsView(
            // La sintassi `nomeParametro: valore` passa argomenti nominati.
            isLoading: state.isLoading,
            artist: state.artist,
            errorMessage: state.errorMessage,
            // `() => espressione` crea una callback senza parametri. L'espressione
            // viene eseguita al tap: recupera il Bloc dal context e invia un
            // nuovo evento. Le parentesi `()` costruiscono l'evento.
            onRetry: () =>
                context.read<ArtistBloc>().add(ArtistLoadRequested()),
          );
        },
      ),
    );
  }
}
