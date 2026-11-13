import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/artist_repository.dart';
import 'artist_load_state.dart';

/// Cubit minimale: espone un metodo per caricare l'artista e gli stati UI.
///
/// La classe estende `Cubit<ArtistLoadState>`: il tipo tra parentesi angolari
/// è un *generic* e specifica il tipo di stato che questo Cubit può emettere.
class ArtistCubit extends Cubit<ArtistLoadState> {
  /// `this._repository` è la sintassi abbreviata Dart per dichiarare un
  /// parametro posizionale e assegnarlo al campo d'istanza omonimo.
  ///
  /// I due punti introducono la *initializer list*: prima viene invocato il
  /// costruttore della superclasse con lo stato iniziale di caricamento.
  ArtistCubit(this._repository) : super(const ArtistLoadState.loading());

  /// `final` permette di impostare il repository solo durante la costruzione;
  /// il riferimento non può essere riassegnato in seguito.
  final ArtistRepository _repository;

  /// `Future<void>` segnala che l'operazione è asincrona e non restituisce
  /// un valore al chiamante. `async` consente di usare `await` nel corpo.
  Future<void> loadArtist() async {
    // `emit` pubblica un nuovo stato ai listener, ad esempio BlocBuilder.
    emit(const ArtistLoadState.loading());

    // `try` racchiude le istruzioni che possono fallire; se una lancia
    // un'eccezione, l'esecuzione prosegue nel blocco `catch`.
    try {
      // `await` sospende questa funzione fino alla risposta del repository.
      // `final` dichiara una variabile locale che non verrà riassegnata.
      final artist = await _repository.fetchArtist();
      emit(ArtistLoadState.success(artist));
    } catch (error) {
      // `toString()` converte l'errore in testo da esporre nello stato UI.
      emit(ArtistLoadState.failure(error.toString()));
    }
  }
}
