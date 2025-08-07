import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../intro_screen/signIn_screen.dart';
import 'bottom_navigation_screen.dart';

class Authprofile extends StatefulWidget {
  const Authprofile({super.key});

  @override
  State<Authprofile> createState() => _AuthprofileState();
}

class _AuthprofileState extends State<Authprofile> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('userData');
    if (data != null) {
      setState(() {
        userData = json.decode(data);
      });
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userData');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen(),));
  }

  Future<bool> onBackPressed() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavigationScreen()),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("User Profile"),
          actions: [
            IconButton(
              onPressed: logout,
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: userData == null
            ? const Center(child: Text("No user data found"))
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.blueAccent,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Welcome, ${userData!['first_name']} ${userData!['last_name']}",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 30),
                  buildInfoTile("Email", userData!['email']),
                  buildInfoTile("Phone Number", userData!['number']),
                  buildInfoTile("Address", userData!['address']),
                  buildInfoTile("Gender", userData!['gender']),
                  buildInfoTile("FCM Token", userData!['fcm_token']),
                  buildInfoTile("Agent ID", userData!['agent_id']),
                  buildInfoTile("Referral Code", userData!['referral_code']),
                  buildInfoTile("Other Referral Code", userData!['other_referral_code']),
                  buildInfoTile("Status", userData!['status']),
                  buildInfoTile("New User", userData!['new_user']),
                  buildInfoTile("Type", userData!['type']),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoTile(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value?.toString() ?? "N/A",
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
