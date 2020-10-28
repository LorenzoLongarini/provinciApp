import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/risorsa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:latlong/latlong.dart';
import 'package:map_launcher/map_launcher.dart' as mapLauncher;
import 'package:map_launcher/map_launcher.dart';
import 'package:provinciApp/utility/stile/colore.dart';
import 'package:provinciApp/utility/stile/stiletesto.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedLeafInfoView extends StatefulWidget {
  Risorsa _leafInfo;
  String _title;
  Controller _controller;
  Image _image;

  DetailedLeafInfoView(
      this._title, this._leafInfo, this._controller, this._image);

  @override
  _DetailedLeafInfoViewState createState() => _DetailedLeafInfoViewState(
      this._title, this._leafInfo, this._controller, this._image);
}

class _DetailedLeafInfoViewState extends State<DetailedLeafInfoView> {
  Risorsa _leafInfo;
  String _title;
  Map<String, Widget> _widgets;
  Controller _controller;
  Icon _icon;
  Image _image;

  _DetailedLeafInfoViewState(
      this._title, this._leafInfo, this._controller, this._image) {
    this._controller.offline.contains(this._leafInfo)
        ? this._icon = Icon(Icons.remove_circle_outline)
        : this._icon = Icon(Icons.add_circle_outline);
    initWidgets();
  }

  void initWidgets() => this._widgets = {
        'Image': this._image == null
            ? Container()
            : Container(
                width: 150.0,
                height: 150.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: this._image.image,
                    ))),
        'Name': Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: Colore.chiaro,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              )),
          child: Text(
            this._leafInfo.nome,
            style: StileTesto.corpo,
            textAlign: TextAlign.center,
          ),
        ),
        'Description': this._leafInfo.descrizione == null
            ? null
            : Text(
                this._leafInfo.descrizione,
                textAlign: TextAlign.center,
              ),
        'Phone': this._leafInfo.telefoni == null
            ? null
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: this._leafInfo.telefoni.length,
                itemBuilder: (context, index) => FlatButton(
                      onPressed: () async {
                        await FlutterPhoneDirectCaller.callNumber(
                            '${this._leafInfo.telefoni[index]}');
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.call,
                            color: Colore.scuro,
                          ),
                          Text('${this._leafInfo.telefoni[index]}')
                        ],
                      ),
                    )),
        'Email': this._leafInfo.email == null
            ? null
            : CircleAvatar(
                radius: 20,
                backgroundColor: Colore.chiaro,
                child: IconButton(
                  icon: Icon(
                    Icons.email,
                    color: Colore.scuro,
                  ),
                  onPressed: () async {
                    await launch('mailto:${this._leafInfo.email}');
                  },
                ),
              ),
        'Share': this._leafInfo.url != null
            ? CircleAvatar(
                radius: 20,
                backgroundColor: Colore.chiaro,
                child: IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Colore.scuro,
                  ),
                  onPressed: () {
                    setState(() {
                      final RenderBox box = context.findRenderObject();
                      Share.share(this._leafInfo.url,
                          subject: this._title,
                          sharePositionOrigin:
                              box.localToGlobal(Offset.zero) & box.size);
                    });
                  },
                ))
            : null,
        'PositionIcon': this._leafInfo.posizione == null
            ? null
            : CircleAvatar(
                radius: 20,
                backgroundColor: Colore.chiaro,
                child: IconButton(
                  onPressed: () => openMapsSheet(context),
                  icon: Icon(
                    Icons.location_on,
                    color: Colore.scuro,
                  ),
                ),
              ),
        'Position': this._leafInfo.posizione == null
            ? Container()
            : Container(
                height: 200,
                alignment: Alignment.centerLeft,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(this._leafInfo.posizione[0],
                        this._leafInfo.posizione[1]),
                    zoom: 13.0,
                  ),
                  layers: [
                    new TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']),
                    new MarkerLayerOptions(
                      markers: [
                        new Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(this._leafInfo.posizione[0],
                              this._leafInfo.posizione[1]),
                          builder: (ctx) => Container(
                            child: Icon(
                              Icons.location_on,
                              color: Colore.scuro,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        'Info': this._leafInfo.info.isEmpty
            ? null
            : ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: this._leafInfo.info.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    this._leafInfo.info.keys.toList()[index],
                  ),
                  subtitle: Linkify(
                    text: '${this._leafInfo.info.values.toList()[index]}',
                    onOpen: (LinkableElement link) async {
                      if (await canLaunch(
                          this._leafInfo.info.values.toList()[index]))
                        await launch(
                            this._leafInfo.info.values.toList()[index]);
                    },
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
        'Url': this._leafInfo.url == null
            ? null
            : CircleAvatar(
                radius: 20,
                backgroundColor: Colore.chiaro,
                child: IconButton(
                  icon: Icon(
                    Icons.link,
                    color: Colore.scuro,
                  ),
                  onPressed: () {
                    launch(this._leafInfo.url);
                  },
                ),
              ),
      };

  @override
  Widget build(BuildContext context) {
    List<Widget> listW = [
      this._widgets['Email'],
      this._widgets['PositionIcon'],
      this._widgets['Url'],
      this._widgets['Share'],
    ];
    listW.removeWhere((element) => element == null);
    return Container(
      color: Colore.primario,
      padding:
          EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top, 20, 0),
      child: Scaffold(
        backgroundColor: Colore.primario,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              backgroundColor: Colore.primario,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colore.chiaro,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                IconButton(
                  icon: this._icon,
                  onPressed: () {
                    setState(() {
                      if (this._controller.offline.contains(this._leafInfo)) {
                        this._controller.removeOffline(_leafInfo);
                        this._icon = Icon(Icons.add_circle_outline);
                      } else {
                        this._controller.addOffline(_leafInfo);
                        this._icon = Icon(Icons.remove_circle_outline);
                      }
                    });
                  },
                )
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                this._widgets['Image'],
                SizedBox(
                  height: 20,
                ),
                this._widgets['Name'],
                SizedBox(
                  height: 20,
                ),
                containerRound(this._widgets['Description'], null),
                containerRound(this._widgets['Info'], 'Info'),
                containerRound(this._widgets['Phone'], 'Telefono'),
                this._widgets['Position'],
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: listW),
                SizedBox(
                  height: 30,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget containerRound(Widget child, String title) => child != null
      ? Column(children: [
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colore.chiaro,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: ListTile(
              title: title == null
                  ? null
                  : Text(
                      title,
                      style: StileTesto.corpo,
                    ),
              subtitle: child,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ])
      : Container();

  openMapsSheet(context) async {
    try {
      final coords = mapLauncher.Coords(
          this._leafInfo.posizione[0], this._leafInfo.posizione[1]);
      final title = this._leafInfo.nome;
      final availableMaps = await MapLauncher.installedMaps;
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: Image(
                          image: map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
