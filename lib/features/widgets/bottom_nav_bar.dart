import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tapcounter/features/counter/cubit/nav_bar_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

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
        return PersistentTabView(
          context,
          controller: PersistentTabController(initialIndex: selectedIndex),
          screens: _buildScreen(),
          items: _navBarsItem(),
          onItemSelected: (index) {
            context.read<NavBarCubit>().setIndex(index);
          },
          navBarStyle: NavBarStyle.style6,
        );
      },
    );
  }
}
