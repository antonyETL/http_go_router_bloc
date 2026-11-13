/// Modello immutabile che rappresenta un artista ricevuto dal servizio REST.
class Artist {
  const Artist({
    required this.id,
    required this.nome,
    required this.nazione,
    required this.annoInizio,
    required this.gruppo,
  });

  final int id;
  final String nome;
  final String nazione;
  final int annoInizio;

  /// "S" identifica un gruppo, "N" un artista solista nel servizio di esempio.
  final String gruppo;

  /// Converte una mappa JSON in un modello tipizzato.
  ///
  /// L'uso di `as` rende esplicito un errore di formato invece di creare
  /// silenziosamente un artista con valori di ripiego.
  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'] as int,
      nome: json['nome'] as String,
      nazione: json['nazione'] as String,
      annoInizio: json['annoInizio'] as int,
      gruppo: json['gruppo'] as String,
    );
  }
}
