import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/view/stile/colore.dart';
import 'package:provinciApp/view/main_view/bottombar_main_view.dart';
import 'package:provinciApp/view/categoria_view/lista_categorie_view.dart';
import 'package:provinciApp/view/esplora_view/esplora_view.dart';
import 'package:provinciApp/view/comune_view/lista_comuni_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/view/main_view/appbar_main_view.dart';

/// Widget della vista principale dove risiedono le tre sottoviste principali
/// (comuni, esplora e categorie).
class MainView extends StatefulWidget {
  Controller _controller;

  /// Indice che indica la sottoschermata attiva nella mainView.
  int _index;

  MainView(this._controller, this._index);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  /// Lista di titoli e Widget della sottoVista.
  List _widgets;

  @override
  void initState() {
    _widgets = [
      ['Comuni', ListaComuniView(widget._controller)],
      ['Esplora', EsploraView(widget._controller)],
      ['Categorie', ListaCategorieView(widget._controller)],
    ];
  }

  /// Metodo privato utile per impostare titolo e widget della sottoVista
  /// selezionata tramite intero.
  void _selezionaSottoView(int index) async {
    setState(() {
      widget._index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colore.sfondo,
      appBar: AppBarMainView(
          widget._controller, _widgets[widget._index][0], context),
      body: _widgets[widget._index][1],
      bottomNavigationBar:
          BottomBarMainView(_selezionaSottoView, widget._index),
    );
  }
}
