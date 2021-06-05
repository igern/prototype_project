import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:prototype_project/router/router.gr.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: 600,
            child: Column(
              children: [
                NavigationListTile(
                  label: 'Macro Meal - Single drag line',
                  route: MacroMealSingleDragLinePageRoute(),
                ),
                NavigationListTile(
                  label: 'Macro Meal - Multi drag line',
                  route: MacroMealMultiDragLinePageRoute(),
                ),
                NavigationListTile(
                  label: 'Macro Meal - Menu order',
                  route: MacroMealMenuOrderPageRoute(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationListTile extends StatelessWidget {
  final String label;
  final PageRouteInfo route;
  const NavigationListTile({Key? key, required this.label, required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      onTap: () => AutoRouter.of(context).push(route),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
