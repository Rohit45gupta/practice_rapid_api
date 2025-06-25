import 'package:flutter/material.dart';
import 'package:practice_api/view/bottom_navigation_bar/home_screen.dart';
import 'package:practice_api/view/bottom_navigation_bar/profile_screen.dart';
import 'package:practice_api/view/bottom_navigation_bar/setting_screen.dart';
import 'package:practice_api/view/bottom_navigation_bar/store_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int selectedIndex = 0;

  final List<Widget> pageList = [
    HomeScreen(),
    StoreScreen(),
    SettingScreen(),
    ProfileScreen(),
  ];

  final List<String> pageTitles = [
    "Home",
    "Store",
    "Settings",
    "Profile",
  ];

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
          IconButton(onPressed: () {

          }, icon: const Icon(Icons.notification_add)),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => selectedIndex = 0);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.store),
                  title: const Text('Store'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => selectedIndex = 1);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("Settings"),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => selectedIndex = 2);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Profile"),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => selectedIndex = 3);
                  },
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
        ],
      ),
    );
  }
}
