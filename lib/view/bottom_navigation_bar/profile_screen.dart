import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_api/viewModel/news_api_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<NewsApiProvider>(context, listen: false);
      provider.fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider =Provider.of<NewsApiProvider>(context,listen: false);

    return Scaffold(
      body: Builder(builder: (context){
          if(provider.isLoading){
            return Center(child: CircularProgressIndicator());
          }
          if(provider.errorMessage != null){
            return Center(child: Text("Error ${provider.errorMessage}"),);
          }
          if(provider.newsList.isEmpty){
            return Center(child: Text("No Data Found"),);
          }
          return ListView.builder(
            itemCount: provider.newsList.length,
            itemBuilder: (context, index) {
              final user = provider.newsList[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                color: Colors.green.shade100,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      user.userId?.toString() ?? '',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  title: Text(
                    user.title ?? 'No Title',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(user.body ?? 'No Body'),
                ),
              );
            },
          );

      })
    );
  }
}
