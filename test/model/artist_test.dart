import 'package:flutter_test/flutter_test.dart';
import 'package:http_go_router_bloc/model/artist.dart';

void main() {
  test('converte i campi JSON del servizio in un artista', () {
    final artist = Artist.fromJson({
      'id': 1,
      'nome': 'Pink Floyd',
      'nazione': 'Regno Unito',
      'annoInizio': 1965,
      'gruppo': 'S',
    });

    expect(artist.id, 1);
    expect(artist.nome, 'Pink Floyd');
    expect(artist.nazione, 'Regno Unito');
    expect(artist.annoInizio, 1965);
    expect(artist.gruppo, 'S');
  });
}
