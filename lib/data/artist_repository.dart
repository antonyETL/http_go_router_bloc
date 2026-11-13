import 'package:dio/dio.dart';

import '../model/artist.dart';

/// Incapsula la comunicazione HTTP, così l'interfaccia non dipende da Dio.
class ArtistRepository {
  ArtistRepository(this._dio);

  static const String _artistUrl =
      'http://localhost:8090/music/api/v1/artists/1';

  final Dio _dio;

  /// Esegue una GET e converte la risposta JSON nell'oggetto [Artist].
  ///
  /// La risposta attesa contiene `id`, `nome`, `nazione`, `annoInizio` e
  /// `gruppo`. Gli errori HTTP o di parsing vengono propagati alla schermata.
  Future<Artist> fetchArtist() async {
    final response = await _dio.get<Map<String, dynamic>>(_artistUrl);
    final data = response.data;

    if (data == null) {
      throw const FormatException('La risposta del servizio è vuota.');
    }

    return Artist.fromJson(data);
  }
}
