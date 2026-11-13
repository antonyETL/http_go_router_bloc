import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/app_navigation_shell.dart';

/// Crea il router con quattro destinazioni e una barra di navigazione condivisa.
///
/// Le graffe nella lista dei parametri dichiarano parametri nominati: `required`
/// obbliga chi invoca la funzione a specificarli. `WidgetBuilder` è un tipo
/// funzione equivalente a `Widget Function(BuildContext)`.
GoRouter createAppRouter({
  required WidgetBuilder home,
  required WidgetBuilder artistNone,
  required WidgetBuilder artistCubit,
  required WidgetBuilder artistBloc,
}) {
  // `return` restituisce il router creato. Gli argomenti `nome: valore` sono
  // nominati; `routes: [...]` passa una lista di configurazioni di route.
  return GoRouter(
    initialLocation: '/',
    routes: [
      // StatefulShellRoute mantiene in memoria lo stack di ogni ramo, utile
      // per una barra di navigazione con destinazioni indipendenti.
      StatefulShellRoute.indexedStack(
        // `builder` riceve una funzione anonima. I suoi parametri sono forniti
        // da go_router e il risultato diventa la shell comune alle schermate.
        builder: (context, state, navigationShell) {
          return AppNavigationShell(navigationShell: navigationShell);
        },
        branches: [
          // `_branch` è una funzione privata a questa libreria (prefisso `_`).
          // Ogni invocazione riceve due argomenti posizionali: percorso e
          // callback che costruisce la relativa schermata. `home` qui è il
          // parametro nominato ricevuto da `createAppRouter`.
          _branch('/', home),
          _branch('/artist-none', artistNone),
          _branch('/artist-cubit', artistCubit),
          _branch('/artist-bloc', artistBloc),
        ],
      ),
    ],
  );
}

/// Costruisce un ramo con una singola route.
///
/// `String` e `WidgetBuilder` sono parametri posizionali; la graffa dopo la
/// firma apre il corpo della funzione. Il ramo restituito contiene una lista
/// di route, anche se in questo esempio ne viene aggiunta una sola.
StatefulShellBranch _branch(String path, WidgetBuilder builder) {
  return StatefulShellBranch(
    routes: [
      // `path` definisce l'URL; `builder:` riceve una closure che inoltra
      // il BuildContext alla callback della schermata.
      GoRoute(path: path, builder: (context, state) => builder(context)),
    ],
  );
}
