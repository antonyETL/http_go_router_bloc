# Demo Flutter: Dio, go_router, Cubit e Bloc

Una mini app didattica che legge un artista da un servizio REST e mostra lo
stesso risultato usando tre diversi approcci alla gestione del caricamento.

## Funzionalità

- **Dio** esegue una richiesta HTTP `GET` al servizio:
  `http://localhost:8090/music/api/v1/artists/1`.
- **go_router** gestisce le quattro destinazioni e mantiene una barra di
  navigazione inferiore disponibile in tutte le schermate.
- **FutureBuilder** gestisce direttamente `loading`, `error` e `data` nella
  schermata **Artista None**.
- **Cubit** espone gli stati della richiesta nella schermata **Artista Cubit**.
- **Bloc** riceve un evento `ArtistLoadRequested` e produce gli stati nella
  schermata **Artista Bloc**.

La home presenta le tre varianti e include collegamenti alle relative schermate.
La visualizzazione dell'artista è riutilizzata: cambiano il modo di caricare
i dati e di notificare la UI, non i widget che mostrano i campi.

## Risposta attesa

Il servizio deve restituire un oggetto JSON di questo tipo:

```json
{
  "id": 1,
  "nome": "Pink Floyd",
  "nazione": "Regno Unito",
  "annoInizio": 1965,
  "gruppo": "S"
}
```

Il JSON è il **corpo della risposta**. La richiesta è una `GET` senza body: i
body sulle richieste GET non sono supportati in modo uniforme e non servono per
questa API di lettura. Dio converte la risposta in `Artist`; errori HTTP, rete o
formato vengono mostrati in pagina e possono essere ritentati.

## Prerequisiti e avvio

Servono Flutter e Dart compatibili con i vincoli nel `pubspec.yaml`, oltre al
servizio REST in ascolto sulla porta `8090`.

Dalla cartella del progetto:

```powershell
flutter pub get
flutter run
```

Per eseguire i test e l'analisi statica:

```powershell
flutter test
flutter analyze
```

L'URL è dichiarato in `lib/data/artist_repository.dart`. In esecuzione su un
emulatore Android, `localhost` indica l'emulatore e non il computer host: in
quel caso configurare l'indirizzo raggiungibile del computer (per esempio
`10.0.2.2` nell'emulatore Android standard). Su Flutter Web il servizio deve
anche consentire le richieste cross-origin (CORS). Per piattaforme che
bloccano HTTP non cifrato occorre consentire il traffico cleartext in sviluppo
oppure configurare un endpoint HTTPS.

## Struttura del codice

```text
lib/
  main.dart                       Avvio dell'app
  app.dart                        Inizializza Dio, repository e go_router
  data/artist_repository.dart     Chiamata HTTP e conversione della risposta
  model/artist.dart               Modello Artist e parsing JSON
  routing/app_router.dart         Rotte e shell di navigazione
  state/artist_load_state.dart    Stato comune loading/success/failure
  state/artist_load_requested.dart Evento Bloc che avvia il caricamento
  state/artist_cubit.dart         Variante basata su Cubit
  state/artist_bloc.dart          Variante basata su eventi e Bloc
  ui/
    app_navigation_shell.dart     Barra di navigazione go_router
    home_screen.dart              Home e collegamenti
    artist_none_screen.dart       FutureBuilder basilare
    artist_cubit_screen.dart      UI collegata al Cubit
    artist_bloc_screen.dart       UI collegata al Bloc
    artist_details_view.dart      Stati e dettagli dell'artista
    artist_field.dart             Riga di presentazione di un campo
test/
  model/artist_test.dart          Test del parsing del JSON
```

## Come confrontare le tre implementazioni

1. `ArtistNoneScreen` conserva un `Future<Artist>` nello stato del widget e lo
   passa a `FutureBuilder`. Il pulsante di retry crea un nuovo Future.
2. `ArtistCubit` chiama il repository e emette uno stato di caricamento,
   successo o errore. `BlocBuilder` aggiorna la schermata quando cambia lo stato.
3. `ArtistBloc` riceve `ArtistLoadRequested`; il gestore dell'evento esegue la
   stessa chiamata e invia uno stato. La UI reagisce con `BlocBuilder`.

Repository e client Dio sono condivisi dall'app, così tutte le schermate usano
lo stesso endpoint senza duplicare la logica HTTP.