import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'data/artist_repository.dart';
import 'routing/app_router.dart';
import 'state/artist_bloc.dart';
import 'state/artist_load_requested.dart';
import 'state/artist_cubit.dart';
import 'ui/artist_bloc_screen.dart';
import 'ui/artist_cubit_screen.dart';
import 'ui/artist_none_screen.dart';
import 'ui/home_screen.dart';

/// Configura client HTTP e router, poi li rende disponibili alle schermate.
///
/// Estende `StatefulWidget` perché il router e il client Dio devono essere
/// creati una volta e rilasciati quando l'app viene rimossa dall'albero.
class ArtistDemoApp extends StatefulWidget {
  /// `super.key` inoltra la chiave opzionale al costruttore della superclasse.
  const ArtistDemoApp({super.key});

  /// `@override` indica che questa classe fornisce l'implementazione richiesta
  /// da `StatefulWidget`. Il tipo generico `State<ArtistDemoApp>` collega lo
  /// stato al widget che lo possiede.
  @override
  State<ArtistDemoApp> createState() => _ArtistDemoAppState();
}

/// Lo stato è una classe separata: il prefisso `_` la rende privata a questo file.
class _ArtistDemoAppState extends State<ArtistDemoApp> {
  /// `late` rimanda l'inizializzazione al primo utilizzo; `final` garantisce che
  /// dopo quell'assegnazione il campo non venga rimpiazzato.
  late final Dio _dio = Dio();
  late final ArtistRepository _repository = ArtistRepository(_dio);

  /// Il router viene creato una sola volta. Le funzioni passate come argomenti
  /// sono callback: `(_)` dichiara un parametro richiesto da `WidgetBuilder`
  /// che qui non serve, mentre `=>` restituisce direttamente il widget.
  late final GoRouter _router = createAppRouter(
    home: (_) => const HomeScreen(),
    artistNone: (_) => ArtistNoneScreen(repository: _repository),
    artistCubit: (_) => BlocProvider(
      // `create:` è una callback invocata dal provider. `..` è l'operatore
      // cascade: crea il Cubit e poi chiama `loadArtist()` sullo stesso oggetto.
      create: (_) => ArtistCubit(_repository)..loadArtist(),
      child: const ArtistCubitScreen(),
    ),
    artistBloc: (_) => BlocProvider(
      // Anche qui il cascade crea il Bloc e gli aggiunge subito l'evento;
      // la callback restituisce il Bloc risultante a `BlocProvider`.
      create: (_) => ArtistBloc(_repository)..add(ArtistLoadRequested()),
      child: const ArtistBlocScreen(),
    ),
  );

  /// `dispose` è un metodo del ciclo di vita chiamato quando lo State viene
  /// rimosso definitivamente: rilascia le risorse prima di chiamare `super`.
  @override
  void dispose() {
    _router.dispose();
    _dio.close();
    super.dispose();
  }

  /// `build` descrive la UI e può essere richiamato da Flutter quando serve
  /// ricostruire il widget; `BuildContext` identifica la sua posizione nell'albero.
  @override
  Widget build(BuildContext context) {
    // `MaterialApp.router` configura un'app Material che delega la navigazione
    // al router; i valori sono passati tramite parametri nominati `nome: valore`.
    return MaterialApp.router(
      title: 'Artisti - Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
