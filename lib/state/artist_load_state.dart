import '../model/artist.dart';

/// Stato condiviso dalle schermate Cubit e Bloc.
///
/// Un'unica classe descrive i possibili risultati della richiesta:
/// caricamento, artista ricevuto oppure errore. I campi nullable permettono
/// di valorizzare solo i dati pertinenti allo stato corrente.
class ArtistLoadState {
  /// Costruttore interno: il carattere `_` rende il nome privato alla libreria
  /// Dart, così le schermate creano gli stati usando i costruttori nominati
  /// `loading`, `success` e `failure` qui sotto.
  ///
  /// `required` indica che `isLoading` deve essere sempre fornito; gli altri
  /// parametri nominati possono essere omessi.
  const ArtistLoadState._({
    required this.isLoading,
    this.artist,
    this.errorMessage,
  });

  /// Costruttore nominato per lo stato di caricamento.
  ///
  /// Dopo i due punti (`:`) c'è una *initializer list*: inoltra il valore al
  /// costruttore interno. `const` consente la creazione a compile time quando
  /// tutti gli argomenti sono costanti.
  const ArtistLoadState.loading() : this._(isLoading: true);

  /// Costruttore nominato per il risultato positivo.
  ///
  /// `Artist artist` è un parametro posizionale obbligatorio; `artist: artist`
  /// passa il suo valore al parametro nominato del costruttore interno.
  const ArtistLoadState.success(Artist artist)
    : this._(isLoading: false, artist: artist);

  /// Costruttore nominato per il risultato negativo.
  ///
  /// Il parametro posizionale contiene il testo dell'errore, che viene salvato
  /// nel campo opzionale `errorMessage`.
  const ArtistLoadState.failure(String message)
    : this._(isLoading: false, errorMessage: message);

  /// `final` rende il riferimento non riassegnabile dopo la costruzione.
  final bool isLoading;

  /// `?` indica che il campo può contenere un valore oppure `null`.
  final Artist? artist;
  final String? errorMessage;
}
