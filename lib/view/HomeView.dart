import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/utility/ConstUrl.dart';
import 'package:provinciApp/utility/Style.dart';
import 'package:provinciApp/view/BottomButtonBar.dart';
import 'package:provinciApp/view/CategorieView.dart';
import 'package:provinciApp/view/EsploraView.dart';
import 'package:provinciApp/view/OfflineView.dart';
import 'package:provinciApp/view/OrganizationsView.dart';
import 'package:provinciApp/view/LoadingView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'EmptyView.dart';
import 'ScrollListView.dart';

class HomeView extends StatefulWidget {
  Controller _controller;
  int _index;

  HomeView(this._controller, this._index);

  @override
  _HomeViewState createState() => _HomeViewState(_controller, this._index);
}

class _HomeViewState extends State<HomeView> {
  Controller _controller;
  String _title;
  Widget _varWidget;
  int _index;

  _HomeViewState(this._controller, this._index) {
    init(this._index);
  }

  Widget initWidgetFuture(Future<dynamic> Function() func, Widget input) =>
      FutureBuilder<dynamic>(
        future: func(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Widget tmpWidget;
          if (snapshot.hasData)
            tmpWidget = input;
          else if (snapshot.hasError)
            tmpWidget = OfflineView(null);
          else
            tmpWidget = LoadingView();
          return tmpWidget;
        },
      );

  void init(index) async {
    this._index = index;
    switch (index) {
      case 0:
        this._title = 'Comuni';
        this._varWidget = OrganizationsView(this._controller);
        break;
      case 1:
        this._title = 'Esplora';
        this._varWidget = EsploraView(this._controller);
        break;
      case 2:
        this._title = 'Categorie';
        this._varWidget = CategoriesView(this._controller);
        break;
    }
  }

  void onItemTapped(index) async {
    setState(() {
      init(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor2,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: BackgroundColor,
        title: Text(
          _title,
          style: TitleTextStyle,
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.extension_rounded,
                color: PrimaryColor,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: BackgroundColor,
                    content: Container(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                          'Aggiungere nuovi extra.'), //ExtraView(this._controller),
                    ),
                    actions: [
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Indietro',
                            style: TitleDetaileStyle,
                          ))
                    ],
                  ),
                );
              }),
          IconButton(
            color: PrimaryColor,
            icon: Icon(
              IconData(IconPosition, fontFamily: 'MaterialIcons'),
              color: PrimaryColor,
            ),
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FutureBuilder<dynamic>(
                      future: this._controller.cercaFromPosizione(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        Widget varWidget;
                        if (snapshot.hasData) if (snapshot.data.isNotEmpty)
                          varWidget =
                              ScrollListView(this._controller, snapshot.data);
                        else
                          varWidget = EmptyView(snapshot.data);
                        else if (snapshot.hasError)
                          varWidget = OfflineView('Find Position');
                        else
                          varWidget = Scaffold(
                            appBar: AppBar(
                              title: Text(
                                'Posizione',
                                style: ReverseTitleTextStyle,
                              ),
                              backgroundColor: PrimaryColor,
                              leading: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: BackgroundColor,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            body: LoadingView(),
                          );
                        return varWidget;
                      },
                    ),
                  ),
                ).then((value) {
                  setState(() {
                    (context as Element).reassemble();
                  });
                });
              });
            },
          ),
          IconButton(
            color: PrimaryColor,
            icon: Icon(Icons.file_download),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/offline');
            },
          ),
        ],
      ),
      body: _varWidget,
      bottomNavigationBar: Material(
        elevation: 8.0,
        child: Container(
          color: BackgroundColor,
          padding: EdgeInsets.only(top: 10),
          child: BottomButtonDown(onItemTapped, this._index),
        ),
      ),
    );
  }
}
