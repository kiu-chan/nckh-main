// ignore_for_file: annotate_overrides, library_prefixes, constant_identifier_names, avoid_unnecessary_containers, avoid_print, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, unused_import, prefer_interpolation_to_compose_strings, duplicate_import

import 'dart:async';
// import 'dart:html';
import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nckh/user_preferences.dart';
import 'package:flutter/services.dart';
import 'infoforPT.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nckh/infoforPT.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'notification_service.dart';

class LiveChartWidget extends StatefulWidget {
  const LiveChartWidget({Key? key}) : super(key: key);

  @override
  State<LiveChartWidget> createState() => _LiveChartWidgetState();
}

const URI_SERVER = 'http://14.225.211.5:5002';

class StreamSocket {
  final _socketResponse = StreamController<int>();

  void Function(int) get addResponse => _socketResponse.sink.add;

  Stream<int> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

NotificationService _notificationService = NotificationService();

StreamSocket streamSocket = StreamSocket();

int tempscore = 0;

void connectAndListen() {
  IO.Socket socket = IO.io(
      URI_SERVER,
      IO.OptionBuilder().setTransports(['websocket']).setExtraHeaders(
          {'foo': 'bar'}).build());
  socket.onConnect((_) {
    print('connect');
  });

  //When an event recieved from server, data is added to the stream
  socket.on('from_server', (data) => streamSocket.addResponse);
  socket.on('from_server', (data) async {
    print('changed to new data $data');
      HapticFeedback.mediumImpact();
      _notificationService.showNotifications();
  });
  socket.onDisconnect((_) => print('disconnect'));
}

class _LiveChartWidgetState extends State<LiveChartWidget> {
  late List<LiveData> chartData;
  // late ChartSeriesController _chartSeriesController;
  final showtime = DateFormat('yMMMd').format(DateTime.now());
  final user = UserPreferences.getUser();
  @override
  void initState() {
    super.initState();
    connectAndListen();
    // chartData = getChartData();
    // Timer.periodic(const Duration(seconds: 1), updateDataSource);
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 0),
      LiveData(1, 0),
      LiveData(2, 0),
      LiveData(3, 0),
      LiveData(4, 0),
      LiveData(5, 0),
      LiveData(6, 0),
      LiveData(7, 0),
      LiveData(8, 0),
      LiveData(9, 0),
    ];
  }

  int time = 10;
  // updateDataSource(Timer timer) {
  //   chartData.add(LiveData(time++, tempscore));
  //   chartData.removeAt(0);
  //   _chartSeriesController.updateDataSource(
  //       addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, ' + user.name + '!',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            showtime,
                            style: TextStyle(color: Colors.blue[100]),
                          )
                        ],
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.blue[600],
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.notifications, color: Colors.white))
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(20)),
                //       color: Colors.white,
                //     ),
                //     child: SfCartesianChart(
                //       primaryXAxis: NumericAxis(
                //         axisLine: AxisLine(color: Colors.black, width: 2.5),
                //         majorGridLines:
                //             MajorGridLines(color: Colors.white, width: 1),
                //         title: AxisTitle(text: 'Thời gian chạy (s)'),
                //         labelStyle:
                //             TextStyle(color: Colors.blueGrey, fontSize: 11),
                //       ),
                //       primaryYAxis: NumericAxis(
                //         axisLine: AxisLine(color: Colors.black, width: 2.5),
                //         opposedPosition: true,
                //       ),
                //       series: [
                //         SplineSeries<LiveData, int>(
                //           onRendererCreated:
                //               (ChartSeriesController controller) {
                //             _chartSeriesController = controller;
                //           },
                //           dataSource: chartData,
                //           xValueMapper: (LiveData data, _) => data.time,
                //           yValueMapper: (LiveData data, _) => data.score,
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(15),
                  child: Center(
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'App Details',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Icon(Icons.more_horiz),
                        ],
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView(
                          children: [
                            // InfoTile(
                            //   icon: Icons.ac_unit_outlined,
                            //   firstName: 'Nhiệt độ máy ℃',
                            //   secondName: 45,
                            //   color: Colors.orange,
                            // ),
                            InfoTile(
                                icon: Icons.access_alarm_outlined,
                                firstName: 'Số lần cảnh báo',
                                secondName: 12,
                                color: Colors.blue)
                          ],
                        ),
                      )
                    ]),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class LiveData {
  final int time;
  final int score;

  LiveData(this.time, this.score);
}
