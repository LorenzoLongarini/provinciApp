import 'package:MC/controller/Controller.dart';
import 'package:MC/model/LeafInfo.dart';
import 'package:MC/view/CardsSizedBox.dart';
import 'package:MC/view/LastSearchedWidget.dart';
import 'package:MC/view/LeafsInfoView.dart';
import 'package:MC/view/LoadingView.dart';
import 'package:MC/view/ScrollListView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class EsploraView extends StatefulWidget {
  Controller controller;

  EsploraView(this.controller);

  @override
  _EsploraViewState createState() => _EsploraViewState(this.controller);
}

class _EsploraViewState extends State<EsploraView> {
  Controller controller;
  List searched;
  List leafs;
  Widget varWidget;
  String location;

  _EsploraViewState(this.controller) {
    this.searched = this.controller.cache.getSearch().entries.toList();
    this.leafs = this.controller.cache.getLeafs().entries.toList();
  }

  Future findPosition() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    Position position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    List<Placemark> placemark =
        await geolocator.placemarkFromPosition(position);
    this.location = placemark[0].locality;
    return this
        .controller
        .setSearch(this.location, 'dataset?q=' + this.location);
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Flexible(
          child: ListView(shrinkWrap: true, children: <Widget>[
            TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
              ),
              onSubmitted: (String input) {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FutureBuilder<dynamic>(
                                future: controller.setSearch(
                                    input, 'dataset?q=' + input),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData)
                                    varWidget =
                                        ScrollListView(this.controller, input);
                                  else
                                    varWidget = LoadingView();
                                  return varWidget;
                                },
                              )));
                });
              },
            ),
            FlatButton(
              child: Row(
                children: <Widget>[
                  Icon(Icons.add_location),
                  Text('Posizione Attuale')
                ],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FutureBuilder<dynamic>(
                              future: findPosition(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData)
                                  varWidget = ScrollListView(
                                      this.controller, this.location);
                                else
                                  varWidget = LoadingView();
                                return varWidget;
                              },
                            )));
              },
            ),
            SizedBox(
              child: Center(
                child: Text(
                  'Comuni',
                  style: TextStyle(fontSize: 20, fontFamily: 'StencilArmyWWI'),
                ),
              ),
            ),
            CardsSizedBox(this.controller, this.controller.getOrganizations()),
            SizedBox(
              child: Center(
                child: Text(
                  'Categorie',
                  style: TextStyle(fontSize: 20, fontFamily: 'StencilArmyWWI'),
                ),
              ),
            ),
            CardsSizedBox(this.controller, this.controller.getCategories()),
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    (context as Element).reassemble();
                  });
                }),
            Divider(),
            LastSearchedWidget(
                this.controller,
                this.searched,
                (index) => ScrollListView(
                    this.controller, this.searched[index].value.getName()),
                (index) => controller.setSearch(
                    this.searched[index].value.getName(),
                    this.searched[index].key)),
            Divider(),
            LastSearchedWidget(
                this.controller,
                this.leafs,
                (index) => LeafsInfoView(this.controller.getLeafs(),
                    this.leafs[index].value.getName(), this.controller),
                (index) => controller.setLeafInfo(
                    this.leafs[index].value.getName(),
                    this.leafs[index].key,
                    (el) => LeafInfo(el)))
          ]),
        ),
      ],
    );
  }
}
