import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'store_screen.dart';
import 'setting_screen.dart';
import 'profile_screen.dart';
import 'auth_profile.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int selectedIndex = 0;

  final List<Widget> pageList = const [
    HomeScreen(),
    StoreScreen(),
    SettingScreen(),
    ProfileScreen(),
    Authprofile(),
  ];

  final List<String> pageTitles = [
    "Home",
    "Store",
    "Settings",
    "Profile",
    "Auth Profile",
  ];

  void _onMenuSelect(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: Text(pageTitles[selectedIndex]),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Notification action
            },
            icon: const Icon(Icons.notifications),
          ),
          PopupMenuButton<int>(
            onSelected: _onMenuSelect,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
              ),
              const PopupMenuItem(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.store),
                  title: Text('Store'),
                ),
              ),
              const PopupMenuItem(
                value: 2,
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                ),
              ),
              const PopupMenuItem(
                value: 3,
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Profile"),
                ),
              ),
              const PopupMenuItem(
                value: 4,
                child: ListTile(
                  leading: Icon(Icons.verified_user),
                  title: Text("Auth Profile"),
                ),
              ),
            ],
          )
        ],
      ),
      body: pageList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blueAccent,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Store"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.verified_user), label: "Auth"),
        ],
      ),
    );
  }
}
