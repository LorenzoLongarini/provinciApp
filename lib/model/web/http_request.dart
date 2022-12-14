import 'dart:async';
import 'dart:convert';
import 'package:provinciApp/model/pacchetto.dart';
import 'package:http/http.dart' as http;
import 'package:provinciApp/model/risorsa.dart';
import 'package:provinciApp/model/costanti/costanti_web.dart';

/// Un HttpRequest ha la responsibilit√† di fornire metodi per fare le varie
/// richieste rest per prelevare i dati dal server.
class HttpRequest {
  /// Metodo capace di fornire grazie ad una chiamata asincrona una lista di
  /// pacchetti dato un url.
  Future<List<Pacchetto>> cercaPacchetto(String url) async {
    Map<String, dynamic> map = await _getResult(url);
    List<Pacchetto> pacchetti = [];
    for (Map value in map['results']) {
      try {
        pacchetti.add(Pacchetto(
            value['title'],
            value['organization']['title'],
            value['resources']
                .firstWhere((element) => element['format'] == 'JSON')['url']));
      } catch (e) {}
    }
    return pacchetti;
  }

  /// Metodo capace di fornire grazie ad una chiamata asincrona una lista di
  /// risorse dato un url.
  Future<List<Risorsa>> cercaRisorsa(String url) async {
    List<Risorsa> list = [];
    dynamic body = await _getBody(url);
    try {
      for (int i = 0; i < body.length; i++) list.add(Risorsa(body[i], url, i));
    } catch (e) {
      try {
        list.add(Risorsa(body['MetaData'], url, 0));
      } catch (e) {}
    }
    return list;
  }

  /// Metodo capace di fornire grazie ad una chiamata asincrona un'immagine
  /// dato un url.
  Future<List<int>> cercaImmagine(String url) async {
    final response = await _responseByGet(url);
    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
  }

  /// Metodo capace di fornire grazie ad una chiamata asincrona i comuni.
  Future<List<Future<Pacchetto>>> cercaComuni() async => await _metaPacchetto(
      CostantiWeb.urlProvinciaComuniList,
      CostantiWeb.urlProvinciaComuniShow,
      CostantiWeb.urlProvinciaSearch + 'organization:');

  /// Metodo capace di fornire grazie ad una chiamata asincrona le categorie.
  Future<List<Future<Pacchetto>>> cercaCategorie() async =>
      await _metaPacchetto(
          CostantiWeb.urlProvinciaCategorieList,
          CostantiWeb.urlProvinciaCategorieShow,
          CostantiWeb.urlProvinciaSearch + 'groups:');

  /// Metodo privato capace di fornire tramite una chiamata asincrona una lista
  /// di pacchetti dati tre url che indicano dove e come cercare il determinato
  /// elemento.
  Future<List<Future<Pacchetto>>> _metaPacchetto(
      String urlLista, String urlShow, String urlBasePacchetto) async {
    List<dynamic> dataList = await _getResult(urlLista);
    return dataList.map((id) async {
      Map map = await _getResult(urlShow + id);
      return Pacchetto(map['display_name'], map['description'],
          urlBasePacchetto + map['name'],
          immagineUrl: map['image_display_url'],
          isEmpty: map['package_count'] == 0);
    }).toList();
  }

  /// Metodo privato utile per prelevare il risultato di una ricerca dato l'url.
  Future<dynamic> _getResult(String url) async {
    Map<String, dynamic> map = await _getBody(url);
    if (map['success']) return await map['result'];
  }

  /// Metodo privato utile per prelevare il body da una risposta http dato un
  /// url.
  Future<dynamic> _getBody(String url) async {
    final response = await _responseByGet(url);
    return await json.decode(response.body);
  }

  /// Metodo privato utile per fare una richiesta http dato un url e ritornare
  /// la risposta http.
  Future<http.Response> _responseByGet(String url) async {
    return await http.Client().get(Uri.parse(url));
  }

  /// Metodo che permette di ricavare il json degli extra da un file json
  /// online.
  Future<dynamic> getExtra() async {
    Map<String, dynamic> map = await _getBody(CostantiWeb.urlExtra);
    List<Pacchetto> result = [];
    for (Map extra in map['extra']) {
      result.add(Pacchetto(extra['nome'], extra['descrizione'], extra['url'],
          immagineUrl: extra['urlImmagine']));
    }
    return result;
  }
}
