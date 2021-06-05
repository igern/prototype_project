import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:prototype_project/pages/macro_meal_menu_order_page.dart';
import 'package:prototype_project/pages/macro_meal_multi_drag_line_page.dart';
import 'package:prototype_project/pages/macro_meal_single_drag_line_page.dart';
import 'package:prototype_project/pages/navigation_page.dart';

Widget transition(BuildContext context, Animation<double> animation,
    Animation secondaryAnimation, Widget child) {
  return SlideTransition(
    position: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero).animate(
      CurvedAnimation(
        curve: Curves.linearToEaseOut,
        parent: animation,
      ),
    ),
    child: child,
  );
}

@CustomAutoRouter(
  transitionsBuilder: transition,
  durationInMilliseconds: 200,
  routes: [
    AutoRoute(page: NavigationPage, initial: true),
    AutoRoute(page: MacroMealSingleDragLinePage),
    AutoRoute(page: MacroMealMultiDragLinePage),
    AutoRoute(page: MacroMealMenuOrderPage),
  ],
)
class $AppRouter {}
