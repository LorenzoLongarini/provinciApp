import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/utility/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'DetailedLeafInfoView.dart';

class SavedWidget extends StatefulWidget {
  Controller _controller;

  SavedWidget(this._controller);

  @override
  _SavedWidgetState createState() => _SavedWidgetState(this._controller);
}

class _SavedWidgetState extends State<SavedWidget> {
  Controller _controller;
  RefreshController _refreshController;

  _SavedWidgetState(this._controller) {
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor2,
      appBar: AppBar(
        title: Text(
          'Offline',
          style: ReverseTitleTextStyle,
        ),
        backgroundColor: PrimaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.file_upload),
            onPressed: () async {
              Navigator.pushReplacementNamed(context, '/online');
            },
          ),
        ],
      ),
      body: SmartRefresher(
        enablePullDown: true,
        header: ClassicHeader(),
        controller: _refreshController,
        onRefresh: () => setState(() {
          this._controller.initOffline().then((value) {
            (context as Element).reassemble();
            _refreshController.refreshCompleted();
          });
        }),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: this._controller.offline.length,
          itemBuilder: (context, index) {
            Icon icon;
            this._controller.offline.contains(this._controller.offline[index])
                ? icon = Icon(Icons.remove_circle_outline)
                : icon = Icon(Icons.add_circle_outline);
            return Card(
              color: BackgroundColor,
              child: Container(
                height: 80,
                alignment: Alignment.center,
                child: ListTile(
                    trailing: IconButton(
                      icon: icon,
                      onPressed: () {
                        setState(() {
                          if (this
                              ._controller
                              .offline
                              .contains(this._controller.offline[index])) {
                            this
                                ._controller
                                .removeOffline(this._controller.offline[index]);
                          } else {
                            this
                                ._controller
                                .addOffline(this._controller.offline[index]);
                          }
                        });
                      },
                    ),
                    leading: Container(
                      height: 55,
                      child: this._controller.offline[index].immagineFile ==
                              null
                          ? Container(
                              height: 55,
                              width: 55,
                              child: Image.asset('assets/logo_mc.PNG'),
                            )
                          : Container(
                              height: 55,
                              width: 55,
                              child: Image.file(
                                  this._controller.offline[index].immagineFile),
                            ),
                    ),
                    title: Text(
                      '${this._controller.offline[index].nome}',
                      maxLines: 2,
                    ),
                    subtitle:
                        this._controller.offline.toList()[index].descrizione ==
                                null
                            ? Text('')
                            : Text(
                                '${this._controller.offline[index].descrizione}',
                                maxLines: 2,
                              ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailedLeafInfoView(
                                    this._controller.offline[index].nome,
                                    this._controller.offline[index],
                                    _controller,
                                    this
                                                ._controller
                                                .offline[index]
                                                .immagineFile ==
                                            null
                                        ? null
                                        : Image.file(
                                            this
                                                ._controller
                                                .offline[index]
                                                .immagineFile,
                                          ),
                                  ))).then((value) {
                        setState(() {
                          (context as Element).reassemble();
                        });
                      });
                    }),
              ),
            );
          },
        ),
      ),
    );
  }
}
