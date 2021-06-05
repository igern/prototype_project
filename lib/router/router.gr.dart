// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../pages/macro_meal_menu_order_page.dart' as _i7;
import '../pages/macro_meal_multi_drag_line_page.dart' as _i6;
import '../pages/macro_meal_single_drag_line_page.dart' as _i5;
import '../pages/navigation_page.dart' as _i3;
import 'router.dart' as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    NavigationPageRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i3.NavigationPage();
        },
        transitionsBuilder: _i4.transition,
        durationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false),
    MacroMealSingleDragLinePageRoute.name: (routeData) =>
        _i1.CustomPage<dynamic>(
            routeData: routeData,
            builder: (_) {
              return const _i5.MacroMealSingleDragLinePage();
            },
            transitionsBuilder: _i4.transition,
            durationInMilliseconds: 200,
            opaque: true,
            barrierDismissible: false),
    MacroMealMultiDragLinePageRoute.name: (routeData) =>
        _i1.CustomPage<dynamic>(
            routeData: routeData,
            builder: (_) {
              return const _i6.MacroMealMultiDragLinePage();
            },
            transitionsBuilder: _i4.transition,
            durationInMilliseconds: 200,
            opaque: true,
            barrierDismissible: false),
    MacroMealMenuOrderPageRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i7.MacroMealMenuOrderPage();
        },
        transitionsBuilder: _i4.transition,
        durationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false)
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(NavigationPageRoute.name, path: '/'),
        _i1.RouteConfig(MacroMealSingleDragLinePageRoute.name,
            path: '/macro-meal-single-drag-line-page'),
        _i1.RouteConfig(MacroMealMultiDragLinePageRoute.name,
            path: '/macro-meal-multi-drag-line-page'),
        _i1.RouteConfig(MacroMealMenuOrderPageRoute.name,
            path: '/macro-meal-menu-order-page')
      ];
}

class NavigationPageRoute extends _i1.PageRouteInfo {
  const NavigationPageRoute() : super(name, path: '/');

  static const String name = 'NavigationPageRoute';
}

class MacroMealSingleDragLinePageRoute extends _i1.PageRouteInfo {
  const MacroMealSingleDragLinePageRoute()
      : super(name, path: '/macro-meal-single-drag-line-page');

  static const String name = 'MacroMealSingleDragLinePageRoute';
}

class MacroMealMultiDragLinePageRoute extends _i1.PageRouteInfo {
  const MacroMealMultiDragLinePageRoute()
      : super(name, path: '/macro-meal-multi-drag-line-page');

  static const String name = 'MacroMealMultiDragLinePageRoute';
}

class MacroMealMenuOrderPageRoute extends _i1.PageRouteInfo {
  const MacroMealMenuOrderPageRoute()
      : super(name, path: '/macro-meal-menu-order-page');

  static const String name = 'MacroMealMenuOrderPageRoute';
}
