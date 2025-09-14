import 'package:flutter/material.dart';
import 'package:jetdispatch/models/dispatch_data_model.dart';
import 'package:jetdispatch/services/dispatch_service.dart';
import 'package:jetdispatch/services/supabase_service.dart';
import 'package:jetdispatch/uri/api_urls.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DispatchInfoScreen extends StatefulWidget {
  Future<List<dynamic>> futureDispatchInfo;
  // Future<List<dynamic>> futureDispatchInfo =
  //     fetchDispatchInfo(ApiUrls.apiUrls[0]);
  DispatchInfoScreen({required this.futureDispatchInfo, Key? key})
      : super(key: key);

  @override
  State<DispatchInfoScreen> createState() => _DispatchInfoScreenState();
}

class _DispatchInfoScreenState extends State<DispatchInfoScreen> {
  late RealtimeChannel _channel;
  DateTime _selectedDate = DateTime.now();

  void _previousDate() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
    });
  }

  void _nextDate() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 1));
    });
  }

  updateData() {
    Future<List<dynamic>> futureDispatchInfo =
        fetchDispatchInfo(ApiUrls.apiUrls[0]);
    setState(() {
      widget.futureDispatchInfo = futureDispatchInfo;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _channel = SupabaseService().liveUpdate(
          ['LOT_1_DISPATCH_UPDATE', 'LOT_2_DISPATCH_UPDATE'], updateData);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> tableData = [
      {
        'time': '4:30 PM',
        'pickupCar': '1',
        'pickupGroup': '2',
        'dropoffCar': '1',
        'dropoffGroup': '2'
      },
      {
        'time': '4:30 PM',
        'pickupCar': '1',
        'pickupGroup': '2',
        'dropoffCar': '1',
        'dropoffGroup': '2'
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 14),
                    onPressed: _previousDate,
                  ),
                  Text(
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, size: 14),
                    onPressed: _nextDate,
                  ),
                ],
              ),
            ),
            Container(
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(2.0), // Time column
                  1: FlexColumnWidth(2.0), // Pickup column
                  2: FlexColumnWidth(2.0), // Dropoff column
                },
                border: const TableBorder(
                  bottom: BorderSide(color: Colors.black87),
                ),
                children: [
                  TableRow(
                    children: [
                      const TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Center(
                              child: Text('Time',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Center(
                            child: Column(
                              children: [
                                const Text('Pickup',
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                Table(
                                  columnWidths: const {
                                    0: FlexColumnWidth(1.0),
                                    1: FlexColumnWidth(1.0),
                                  },
                                  children: const [
                                    TableRow(
                                      children: [
                                        Center(
                                            child: Icon(Icons.directions_car,
                                                size: 16)),
                                        Center(
                                            child: Icon(
                                          Icons.group,
                                          size: 16,
                                        )),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            children: [
                              const Text(
                                'Droupoff',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(1.0),
                                  1: FlexColumnWidth(1.0),
                                },
                                children: const [
                                  TableRow(
                                    children: [
                                      Center(
                                          child: Icon(Icons.directions_car,
                                              size: 16)),
                                      Center(
                                        child: Icon(
                                          Icons.group,
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FutureBuilder<List<dynamic>>(
              future: widget.futureDispatchInfo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the future is still loading
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // If the future completed with an error
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  // If the snapshot has no data
                  return const Center(child: Text('No data available'));
                } else {
                  // When the future has completed with data
                  List<dynamic> data = snapshot.data!;
                  List<DispatchDataModel> dispatchInfo =
                      data.map((e) => DispatchDataModel.fromJson(e)).toList();
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: Table(
                      children: [
                        for (var items in dispatchInfo)
                          TableRow(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.black26),
                              ),
                            ),
                            children: [
                              TableCell(
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: Colors.black38))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0),
                                    child: Center(
                                      child: Text(
                                        items.timeText.toString(),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6.0),
                                  child: Center(
                                      child: Column(
                                    children: [
                                      Table(
                                        children: [
                                          TableRow(children: [
                                            Center(
                                              child: Text(
                                                items.pickupVehicleCount
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                items.pickupPaxCount.toString(),
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            )
                                          ])
                                        ],
                                      )
                                    ],
                                  )),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6.0),
                                  child: Center(
                                      child: Column(
                                    children: [
                                      Table(
                                        children: [
                                          TableRow(children: [
                                            Center(
                                              child: Text(
                                                items.dropoffVehicleCount
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                items.dropoffPaxCount
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            )
                                          ])
                                        ],
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    SupabaseService().removeSupabaseChannel(_channel);
    super.dispose();
  }
}
