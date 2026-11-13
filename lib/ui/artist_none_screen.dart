import 'package:flutter/material.dart';

import '../data/artist_repository.dart';
import '../model/artist.dart';
import 'artist_details_view.dart';

/// Variante basilare: FutureBuilder osserva direttamente il Future del repository.
class ArtistNoneScreen extends StatefulWidget {
  const ArtistNoneScreen({required this.repository, super.key});

  final ArtistRepository repository;

  @override
  State<ArtistNoneScreen> createState() => _ArtistNoneScreenState();
}

class _ArtistNoneScreenState extends State<ArtistNoneScreen> {
  late Future<Artist> _artistFuture;

  @override
  void initState() {
    super.initState();
    _artistFuture = widget.repository.fetchArtist();
  }

  void _reload() {
    setState(() {
      _artistFuture = widget.repository.fetchArtist();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Artista None')),
      body: FutureBuilder<Artist>(
        future: _artistFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const ArtistDetailsView(isLoading: true);
          }
          if (snapshot.hasError) {
            return ArtistDetailsView(
              isLoading: false,
              errorMessage: snapshot.error.toString(),
              onRetry: _reload,
            );
          }
          return ArtistDetailsView(
            isLoading: false,
            artist: snapshot.data,
          );
        },
      ),
    );
  }
}
