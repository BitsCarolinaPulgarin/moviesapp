import 'dart:async';
import 'dart:convert';
import 'package:peliculas_app/src/models/actores_model.dart';
import 'package:peliculas_app/src/models/pelicula.dart';
import 'package:http/http.dart' as http;

class PeliculasServices {
  String _api_key = 'ca4df102fbfe54f57760118d4330c812';
  String _url = 'api.themoviedb.org';
  String _language = 'es-Es';

  int _popularesPage = 0;

  List<Pelicula> _populares = new List();
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  get popularesSink => _popularesStreamController.sink.add;

  get popularesStream => _popularesStreamController.stream;

  void disposeStream() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final respuesta = await http.get(url);
    final decoded = json.decode(respuesta.body);
    final peliculas = new Peliculas.fromJsonList(decoded['results']);

    return peliculas.items;
  }

  void cosita () async {

    var s = "sdfsdf";
 }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _api_key, 'language': _language});

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    _popularesPage++;

    print('peliculas...');

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _api_key,
      'language': _language,
      'pague': _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '3/movie/${peliId}/credits', {
      'api_key': _api_key,
      'language': _language
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = new Cast.froJsonList(decodedData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key' : _api_key,
      'language': _language,
      'query'   : query
    });

    return await _procesarRespuesta(url);
  }
}
