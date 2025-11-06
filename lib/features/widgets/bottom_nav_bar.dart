import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tapcounter/app_route.gr.dart';
import 'package:tapcounter/features/counter/cubit/nav_bar_cubit.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});
  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
  );
  List<Widget> _buildScreen() {
    return [
      Center(child: Text('Home')),
      Center(child: Text('History')),
      Center(child: Text('Settings')),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItem() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_sharp),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.history),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(context) {
    return BlocBuilder<NavBarCubit, int>(
      builder: (context, selectedIndex) {
        if (_controller.index != selectedIndex) {
          _controller.index = selectedIndex;
        }
        return PersistentTabView(
          context,

          screens: _buildScreen(),
          items: _navBarsItem(),
          onItemSelected: (index) {
            context.read<NavBarCubit>().setIndex(index);
            switch (index) {
              case 0:
                context.router.replace(TapViewRoute());
                break;
              case 1:
                context.router.replace(HistoryRoute());
                break;
              case 2:
                context.router.replace(SettingsRoute());
                break;
            }
          },
          navBarStyle: NavBarStyle.style6,
        );
      },
    );
  }
}
