import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_api/viewModel/enterainment_api_provider.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  void initState() {
    super.initState();
     Provider.of<EntertainmentApiprovider>(context,listen: false).fetchEntertainment();
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EntertainmentApiprovider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('EntertainMentApi'),),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.errorMessage != null
          ? Center(child: Text(provider.errorMessage))
          : ListView.builder(
        itemCount: provider.entertainmentList.length,
        itemBuilder: (context, index) {
          final news = provider.entertainmentList[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: news['image'] != null
                  ? Image.network(news['image'], width: 60, fit: BoxFit.cover)
                  : const Icon(Icons.image_not_supported),
              title: Text(news['title'] ?? 'No Title'),
              subtitle: Text(news['published_date'] ?? ''),
            ),
          );
        },
      ),
    );
  }
}
