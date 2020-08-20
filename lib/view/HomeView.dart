import 'package:MC/controller/Controller.dart';
import 'package:MC/model/Web/HtmlParser.dart';
import 'package:MC/view/BottomButtonBar.dart';
import 'package:MC/view/EsploraView.dart';
import 'package:MC/view/EventiView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'PromoView.dart';

class HomeView extends StatefulWidget {
  Controller controller;

  HomeView(this.controller);

  @override
  _HomeViewState createState() => _HomeViewState(controller);
}

class _HomeViewState extends State<HomeView> {
  Controller controller;
  Widget varWidget;

  _HomeViewState(this.controller) {
    varWidget = EsploraView(this.controller);
  }

  void onItemTapped(index) async {
    setState(() {
      switch (index) {
        case 0:
          varWidget = EsploraView(controller);
          break;
        case 1:
          varWidget = EventiView(this.controller.events);
          break;
        case 2:
          varWidget = PromoView(this.controller.promos);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(varWidget.runtimeType == EsploraView
            ? 'Esplora'
            : (varWidget.runtimeType == EventiView
                ? 'Eventi'
                : (varWidget.runtimeType == PromoView ? 'Promo' : ''))),
      ),
      body: varWidget,
      bottomNavigationBar: BottomButtonDown(controller, onItemTapped),
    );
  }
}
