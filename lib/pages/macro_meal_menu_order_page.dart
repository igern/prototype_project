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
                        child: MenuHasMoreOverlay(
                            height: menuHeight, iconData: Icons.chevron_right)),
                  if (_menuScrollHasMoreLeft)
                    Align(
                        alignment: Alignment.centerLeft,
                        child: MenuHasMoreOverlay(
                            height: menuHeight, iconData: Icons.chevron_left))
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

class MenuHasMoreOverlay extends StatelessWidget {
  final IconData iconData;
  final double height;
  const MenuHasMoreOverlay(
      {Key? key, required this.iconData, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: Container(
          height: height,
          width: 50,
          color: Colors.black,
          child: Icon(iconData, color: Colors.white)),
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
            for (int x = 1; x <= 10; x++)
              Expanded(
                  child: Column(
                children: [
                  for (int y = 1; y <= 4; y++)
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://picsum.photos/id/${x * y}/300/300'))))),
                ],
              )),
          ],
        ),
      ),
    );
  }
}
