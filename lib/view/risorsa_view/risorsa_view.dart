import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/risorsa.dart';
import 'package:provinciApp/view/costanti/costanti_assets.dart';
import 'package:provinciApp/utility/stile/colore.dart';
import 'package:provinciApp/utility/stile/icona.dart';
import '../DetailedLeafInfoView.dart';
import '../custom/custom_icon.dart';

/// RisorsaView da la vista personalizzata di una risorsa.
class RisorsaView extends StatefulWidget {
  Controller _controller;

  /// Risorsa da mostrare.
  Risorsa _risorsa;

  RisorsaView(this._controller, this._risorsa);

  @override
  _RisorsaViewState createState() => _RisorsaViewState();
}

class _RisorsaViewState extends State<RisorsaView> {
  @override
  Widget build(BuildContext context) {
    CustomIcon icon;
    widget._controller.offline.contains(widget._risorsa)
        ? icon = CustomIcon(Icona.rimuoviOffline, Colore.primario)
        : icon = CustomIcon(Icona.salvaOffline, Colore.primario);
    return Card(
      color: Colore.chiaro,
      child: Container(
        height: 100,
        alignment: Alignment.center,
        child: ListTile(
            trailing: IconButton(
              icon: icon,
              onPressed: () {
                setState(() {
                  if (widget._controller.offline.contains(widget._risorsa)) {
                    widget._controller.removeOffline(widget._risorsa);
                  } else {
                    widget._controller.addOffline(widget._risorsa);
                  }
                });
              },
            ),
            leading: Container(
              height: 55,
              width: 55,
              child: widget._risorsa.immagineFile == null
                  ? Image.asset(CostantiAssets.logo)
                  : Image.file(widget._risorsa.immagineFile),
            ),
            title: Text(
              widget._risorsa.nome,
              maxLines: 2,
            ),
            subtitle: widget._risorsa.descrizione == null
                ? Text('')
                : Text(
                    widget._risorsa.descrizione,
                    maxLines: 2,
                  ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailedLeafInfoView(
                    widget._risorsa.nome,
                    widget._risorsa,
                    widget._controller,
                    widget._risorsa.immagineFile == null
                        ? null
                        : Image.file(
                            widget._risorsa.immagineFile,
                          ),
                  ),
                ),
              ).then((value) {
                setState(() {
                  (context as Element).reassemble();
                });
              });
            }),
      ),
    );
  }
}
