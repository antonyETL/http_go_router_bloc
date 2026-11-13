import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/artist_cubit.dart';
import '../state/artist_load_state.dart';
import 'artist_details_view.dart';

/// Variante Cubit: BlocBuilder ricostruisce la UI a ogni nuovo stato del Cubit.
///
/// Estendere `StatelessWidget` indica che questa schermata non conserva stato
/// mutabile proprio: i dati arrivano dal Cubit tramite `BlocBuilder`.
class ArtistCubitScreen extends StatelessWidget {
  /// `super.key` inoltra al costruttore base la chiave opzionale del widget.
  /// `const` rende possibile creare questo widget come costante.
  const ArtistCubitScreen({super.key});

  /// `@override` dichiara che questo metodo implementa quello della superclasse.
  /// Flutter passa `BuildContext`, che dà accesso alla posizione del widget
  /// nell'albero e ai servizi forniti sopra di esso.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Artista Cubit')),
      // I due tipi tra parentesi angolari dicono a BlocBuilder quale Cubit
      // ascoltare e quale tipo di stato ricevere.
      body: BlocBuilder<ArtistCubit, ArtistLoadState>(
        // `builder` riceve una funzione anonima: `context` e `state` sono i
        // parametri; le parentesi graffe delimitano il corpo della funzione.
        builder: (context, state) {
          return ArtistDetailsView(
            // I parametri nominati rendono esplicito a quale proprietà UI
            // corrisponde ciascun valore dello stato.
            isLoading: state.isLoading,
            artist: state.artist,
            errorMessage: state.errorMessage,
            // `context.read<T>()` recupera il Cubit fornito nell'albero.
            // `.loadArtist` senza `()` è un riferimento al metodo (tear-off):
            // viene passato come callback e invocato solo quando serve.
            onRetry: context.read<ArtistCubit>().loadArtist,
          );
        },
      ),
    );
  }
}
