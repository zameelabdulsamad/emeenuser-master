import 'package:emeenuser/Screens/categoryScreen.dart';
import 'package:emeenuser/Screens/homeScreen.dart';
import 'package:emeenuser/Screens/orderScreen.dart';
import 'package:emeenuser/Screens/profileScreen.dart';
import 'package:emeenuser/constants.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  void _onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _children = [
    HomeScreen(),
    CategoryScreen(),
    OrderScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 12,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: emeenblue,
        onTap: _onTappedBar,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), title: Text("Category")),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), title: Text("Orders")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Profile")),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
    );
  }
}
