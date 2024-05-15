import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:smart_fitness_application/view/screens/History/workout_history_page.dart';
import 'package:smart_fitness_application/view/screens/Home/home_page.dart';
import 'package:smart_fitness_application/view/screens/Workout/workout_page.dart';

class BottomNavBar extends StatelessWidget {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Theme.of(context).primaryColor,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(3),
        colorBehindNavBar: Colors.white,
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }
}

List<Widget> _buildScreens() {
  return [HomePage(), WorkoutPage(), WorkoutHistoryPage()];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.home),
      title: ("Home"),
      activeColorPrimary: CupertinoColors.lightBackgroundGray,
      inactiveColorPrimary: CupertinoColors.white,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.fitness_center),
      title: ("Workout"),
      activeColorPrimary: CupertinoColors.lightBackgroundGray,
      inactiveColorPrimary: CupertinoColors.white,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.calendar),
      title: ("History"),
      activeColorPrimary: CupertinoColors.lightBackgroundGray,
      inactiveColorPrimary: CupertinoColors.white,
    ),
  ];
}
