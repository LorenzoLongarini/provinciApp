import 'package:MC/controller/Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'DetailedLeafInfoView.dart';

class SalvatiView extends StatefulWidget {
  String _title;
  Controller _controller;

  SalvatiView(this._title, this._controller);

  @override
  _SalvatiViewState createState() =>
      _SalvatiViewState(this._title, this._controller);
}

class _SalvatiViewState extends State<SalvatiView> {
  String _title;
  Controller _controller;
  RefreshController _refreshController;

  _SalvatiViewState(this._title, this._controller) {
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      header: ClassicHeader(),
      controller: _refreshController,
      onRefresh: () => setState(() {
        this._controller.initOffline().then((value) {
          (context as Element).reassemble();
          _refreshController.refreshCompleted();
        });
      }),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: this._controller.getOffline().length,
        itemBuilder: (context, index) {
          Icon icon;
          this
                  ._controller
                  .getOffline()
                  .contains(this._controller.getOffline()[index])
              ? icon = Icon(Icons.remove_circle_outline)
              : icon = Icon(Icons.add_circle_outline);
          return Card(
              child: FlatButton(
                  child: ListTile(
                    trailing: IconButton(
                      icon: icon,
                      onPressed: () {
                        setState(() {
                          if (this
                              ._controller
                              .getOffline()
                              .contains(this._controller.getOffline()[index])) {
                            this._controller.removeOffline(
                                this._controller.getOffline()[index]);
                            icon = Icon(Icons.add_circle_outline);
                          } else {
                            this._controller.addOffline(
                                this._controller.getOffline()[index]);
                            icon = Icon(Icons.remove_circle_outline);
                          }
                        });
                      },
                    ),
                    leading:
                        this._controller.getOffline()[index].imageFile == null
                            ? null
                            : Image.file(
                                this._controller.getOffline()[index].imageFile),
                    title: Text('${this._controller.getOffline()[index].name}'),
                    subtitle: this
                                ._controller
                                .getOffline()
                                .toList()[index]
                                .description ==
                            null
                        ? Text('')
                        : Text(
                            '${this._controller.getOffline()[index].description}'),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailedLeafInfoView(
                                    _title,
                                    this._controller.getOffline()[index],
                                    _controller,
                                    this
                                                ._controller
                                                .getOffline()[index]
                                                .imageFile ==
                                            null
                                        ? null
                                        : Image.file(this
                                            ._controller
                                            .getOffline()[index]
                                            .imageFile),
                                  )));
                    });
                  }));
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}