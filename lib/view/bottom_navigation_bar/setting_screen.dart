import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectToSocket();

  }

  void connectToSocket(){
    const token = 'InR5cCI6IkpXVCJ9.eyJvcGVyYXRvcl9pZCI6NTgsImlhdCI6MTc1MDkxMTAzNH0.7J5keOkrJOKioBKyl6g8nT4cwbb8TZ2s0oh67u02obo';

    final playLoad = {
      "token":token,
      "location":{
        "type":"Point",
        "coordinates": [85.901413, 26.152973],
      }
    };
   Socket socket = io('https://api.rodbez.com',
     OptionBuilder()
       .setTransports(['websocket'])
      .enableAutoConnect()
      .build()
   );

   socket.onConnect((data){
     print('Websocket connected');
     socket.emit('location',playLoad);

   });
   socket.on("Update Location", (data){
     print('done');
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 400,
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Today's Attendance",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 20),
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: BarChart(
                        BarChartData(
                          maxY: 600,
                          gridData: FlGridData(show: true),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, _) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return const Text('Present');
                                    case 1:
                                      return const Text('Absent');
                                    case 2:
                                      return const Text('Leave');
                                    case 3:
                                      return const Text('Half Day');
                                    default:
                                      return const SizedBox.shrink();
                                  }
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: [
                            BarChartGroupData(x: 0, barRods: [
                              BarChartRodData(toY: 500, width: 25, color: Colors.blue),
                            ]),
                            BarChartGroupData(x: 1, barRods: [
                              BarChartRodData(toY: 400, width: 25, color: Colors.blue),
                            ]),
                            BarChartGroupData(x: 2, barRods: [
                              BarChartRodData(toY: 300, width: 25, color: Colors.blue),
                            ]),
                            BarChartGroupData(x: 3, barRods: [
                              BarChartRodData(toY: 100, width: 25, color: Colors.blue),
                            ]),
                          ],
                          barTouchData: BarTouchData(enabled: true),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(onPressed: (){
            connectToSocket();
          }, child: Text('Save'))
        ],
      ),
    );  }
}
