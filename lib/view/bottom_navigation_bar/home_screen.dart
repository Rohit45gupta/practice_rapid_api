import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewModel/api_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    var provider = Provider.of<ApiProvider>(context, listen: false);
    provider.fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiProvider>(context);

    return Scaffold(

      appBar: AppBar(automaticallyImplyLeading: true,
          title: Text("Rapid News List")),
      body: Builder(
        builder: (context) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage.isNotEmpty) {
            return Center(child: Text("Error: ${provider.errorMessage}"));
          }

          final allItems = provider.users.expand((e) => e.items ?? []).toList();

          if (allItems.isEmpty) {
            return const Center(child: Text("No Data"));
          }

          return ListView.builder(
            itemCount: allItems.length,
            itemBuilder: (context, index) {
              final item = allItems[index];
              return Card(
                elevation: 4,
                shadowColor: Colors.blueAccent,shape: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20),),borderSide: BorderSide(color: Colors.blueGrey,width: 2,)),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: ListTile(
                  leading: item.images?.thumbnail != null
                      ? CircleAvatar(
                    backgroundImage:
                    NetworkImage(item.images!.thumbnail!),
                  )
                      : const CircleAvatar(child: Icon(Icons.image)),
                  title: Text(item.title ?? "No Title"),
                  subtitle: Text(item.publisher ?? "Unknown Publisher"),
                  onTap: () {
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
