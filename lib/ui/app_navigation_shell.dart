import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Mantiene visibile la barra di navigazione su tutte le schermate principali.
///
/// Estende `StatelessWidget` perché lo stato della navigazione è gestito da
/// `StatefulNavigationShell`, ricevuto come parametro.
class AppNavigationShell extends StatelessWidget {
  /// La sintassi `{required this.navigationShell, super.key}` dichiara un
  /// parametro nominato obbligatorio, lo assegna al campo omonimo e inoltra
  /// la chiave opzionale al costruttore della superclasse.
  const AppNavigationShell({required this.navigationShell, super.key});

  /// `final` impedisce di riassegnare il riferimento dopo la costruzione.
  final StatefulNavigationShell navigationShell;

  /// `static` rende il campo appartenente alla classe anziché a ogni istanza;
  /// `const` crea una lista immutabile di widget-destinazione.
  static const _destinations = [
    // Ogni elemento è costruito con argomenti nominati: `icon` e `label`.
    NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
    NavigationDestination(icon: Icon(Icons.person_outline), label: 'None'),
    NavigationDestination(icon: Icon(Icons.bolt_outlined), label: 'Cubit'),
    NavigationDestination(icon: Icon(Icons.account_tree_outlined), label: 'Bloc'),
  ];

  /// `build` riceve il contesto Flutter e restituisce il sottoalbero di widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        // Questi parametri nominati configurano selezione e destinazioni.
        selectedIndex: navigationShell.currentIndex,
        destinations: _destinations,
        // Callback chiamata con l'indice selezionato dall'utente.
        onDestinationSelected: (index) {
          // Il metodo passa al ramo corrispondente; `initialLocation` è un
          // parametro nominato booleano. L'uguaglianza `==` verifica se
          // l'utente ha riselezionato la destinazione già attiva.
          navigationShell.goBranch(
            index,
            // Tapping the current destination returns to its root page.
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
