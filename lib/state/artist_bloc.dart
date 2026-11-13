import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/artist_repository.dart';
import 'artist_load_requested.dart';
import 'artist_load_state.dart';

/// Bloc: riceve eventi, esegue il repository e produce stati per la UI.
///
/// I due parametri generici specificano rispettivamente il tipo di evento
/// accettato (`ArtistLoadRequested`) e il tipo di stato emesso
/// (`ArtistLoadState`).
class ArtistBloc extends Bloc<ArtistLoadRequested, ArtistLoadState> {
  /// `this._repository` dichiara il parametro del costruttore e lo assegna
  /// direttamente al campo d'istanza.
  ///
  /// Dopo `:` la *initializer list* chiama il costruttore base con lo stato
  /// iniziale. Il corpo `{}` registra poi il gestore dell'evento.
  ArtistBloc(this._repository) : super(const ArtistLoadState.loading()) {
    // `on<T>` registra una funzione che sarà invocata per gli eventi di tipo
    // `T`. `_onLoadRequested` è passato senza parentesi: è un riferimento al
    // metodo, non una chiamata immediata.
    on<ArtistLoadRequested>(_onLoadRequested);
  }

  /// Il riferimento `final` al repository viene impostato solo nel costruttore.
  final ArtistRepository _repository;

  /// Firma del gestore: riceve l'evento e un `Emitter` parametrizzato col tipo
  /// di stato. `Future<void>` e `async` indicano che può attendere operazioni
  /// asincrone ma non restituisce un valore utile al chiamante.
  Future<void> _onLoadRequested(
    ArtistLoadRequested event,
    Emitter<ArtistLoadState> emit,
  ) async {
    // Pubblica loading prima di iniziare la richiesta.
    emit(const ArtistLoadState.loading());

    // `await` attende il Future del repository. Se fallisce, `catch` converte
    // l'eccezione in uno stato di errore invece di lasciarla non gestita.
    try {
      final artist = await _repository.fetchArtist();
      emit(ArtistLoadState.success(artist));
    } catch (error) {
      emit(ArtistLoadState.failure(error.toString()));
    }
  }
}
