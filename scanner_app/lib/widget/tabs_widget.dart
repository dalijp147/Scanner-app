import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:scanner_app/screens/dachboard.dart';
import 'package:scanner_app/screens/file_screen.dart';
import 'package:scanner_app/screens/scan_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  ValueNotifier<dynamic>? result = ValueNotifier(null);
  final List<Widget> _pages = [
    SCanScreen(),
    FileScreen(),
    DachBoard(),
  ];
  int _selectedPageIndex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  Map<Widget, GlobalKey<NavigatorState>> _navigatorKeys = {
    SCanScreen(): GlobalKey<NavigatorState>(),
    FileScreen(): GlobalKey<NavigatorState>(),
    DachBoard(): GlobalKey<NavigatorState>(),
  };
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 70,
        items: const <Widget>[
          Icon(
            Icons.wifi_find_rounded,
            size: 30,
          ),
          Icon(
            Icons.list_alt_rounded,
            size: 30,
          ),
          Icon(
            Icons.dashboard_rounded,
            size: 30,
          ),
        ],
        onTap: _selectPage,
      ),
    );
  }
}
