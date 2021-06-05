import 'dart:math';

import 'package:flutter/material.dart';

class MacroMealMenuOrderPage extends StatefulWidget {
  const MacroMealMenuOrderPage({Key? key}) : super(key: key);

  @override
  _MacroMealMenuOrderPageState createState() => _MacroMealMenuOrderPageState();
}

class _MacroMealMenuOrderPageState extends State<MacroMealMenuOrderPage> {
  bool _menuOpen = false;

  bool get _showMenuOverlay {
    return _menuOpen && (_menuScrollHasMoreLeft || _menuScrollHasMoreRight);
  }

  late bool _menuScrollHasMoreLeft;
  late bool _menuScrollHasMoreRight;

  late ScrollController _menuScrollController;

  @override
  void initState() {
    super.initState();
    _menuScrollHasMoreLeft = false;
    _menuScrollHasMoreRight = true;
    _menuScrollController = ScrollController();

    _menuScrollController.addListener(() {
      if (_menuScrollController.position.atEdge) {
        setState(() {
          _menuScrollController.offset > 0
              ? _menuScrollHasMoreRight = false
              : _menuScrollHasMoreLeft = false;
        });
      } else {
        if (!_menuScrollHasMoreLeft | !_menuScrollHasMoreRight)
          setState(() {
            _menuScrollHasMoreLeft = true;
            _menuScrollHasMoreRight = true;
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final menuHeight = height * 0.6;
    final orderWidth = width * 0.4;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              color: Colors.red,
              height: height - menuHeight,
              width: width - orderWidth,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: AnimatedContainer(
              width: _menuOpen ? width - orderWidth : width,
              height: menuHeight,
              duration: const Duration(milliseconds: 500),
              curve: Curves.linearToEaseOut,
              child: Stack(children: [
                MacroMealMenuSection(
                  width: width,
                  height: height,
                  scrollController: _menuScrollController,
                ),
                if (_showMenuOverlay) ...[
                  if (_menuScrollHasMoreRight)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Opacity(
                        opacity: 0.5,
                        child: Container(
                            height: menuHeight,
                            width: 50,
                            color: Colors.black,
                            child:
                                Icon(Icons.chevron_right, color: Colors.white)),
                      ),
                    ),
                  if (_menuScrollHasMoreLeft)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Opacity(
                        opacity: 0.5,
                        child: Container(
                            height: menuHeight,
                            width: 50,
                            color: Colors.black,
                            child:
                                Icon(Icons.chevron_left, color: Colors.white)),
                      ),
                    )
                ]
              ]),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: AnimatedContainer(
                color: Colors.green,
                width: orderWidth,
                height: _menuOpen ? height : height - menuHeight,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linearToEaseOut),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            setState(() {
              _menuOpen = !_menuOpen;
            });
          },
          child:
              Icon(Icons.open_in_full, color: Theme.of(context).primaryColor)),
    );
  }
}

class MacroMealMenuSection extends StatelessWidget {
  final double width;
  final double height;
  final ScrollController? scrollController;
  const MacroMealMenuSection(
      {Key? key,
      required this.width,
      required this.height,
      this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: Container(
        width: width,
        height: height,
        child: Row(
          children: [
            Expanded(
              child: Column(children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/1/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/2/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/3/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/4/300/300'))))),
              ]),
            ),
            Expanded(
              child: Column(children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/5/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/6/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/7/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/8/300/300'))))),
              ]),
            ),
            Expanded(
              child: Column(children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/9/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/10/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/11/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/12/300/300'))))),
              ]),
            ),
            Expanded(
              child: Column(children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/13/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/14/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/15/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/16/300/300'))))),
              ]),
            ),
            Expanded(
              child: Column(children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/17/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/18/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/19/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/20/300/300'))))),
              ]),
            ),
            Expanded(
              child: Column(children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/21/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/22/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/23/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/24/300/300'))))),
              ]),
            ),
            Expanded(
              child: Column(children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/25/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/26/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/27/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/28/300/300'))))),
              ]),
            ),
            Expanded(
              child: Column(children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/29/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/30/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/31/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/32/300/300'))))),
              ]),
            ),
            Expanded(
              child: Column(children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/33/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/34/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/35/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/36/300/300'))))),
              ]),
            ),
            Expanded(
              child: Column(children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/37/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/38/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/39/300/300'))))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://picsum.photos/id/40/300/300'))))),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
