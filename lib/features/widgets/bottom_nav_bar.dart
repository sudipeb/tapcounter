import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tapcounter/features/counter/cubit/nav_bar_cubit.dart';
import 'package:tapcounter/features/counter/presentation/history_page.dart';
import 'package:tapcounter/features/counter/presentation/tap_view.dart';
import 'package:tapcounter/features/settings/user_settings.dart';

@RoutePage()
///creating [BottomNavBarPage] using the [PersistentTabController]
class BottomNavBarPage extends StatelessWidget {
  BottomNavBarPage({super.key});
  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
  );

  List<Widget> _buildScreen() => const [
    TapViewPage(),
    HistoryPage(),
    SettingsPage(), // SettingsRoute
  ];

  List<PersistentBottomNavBarItem> _navBarsItem() => [
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

  @override
  Widget build(context) {
    return BlocBuilder<NavBarCubit, int>(
      builder: (context, selectedIndex) {
        if (_controller.index != selectedIndex) {
          _controller.index = selectedIndex;
        }
        return PersistentTabView(
          context,
          controller: _controller,
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
