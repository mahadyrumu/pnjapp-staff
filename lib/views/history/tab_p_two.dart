import 'package:flutter/material.dart';
import 'package:jetdispatch/views/history/p2_table_all.dart';
import 'package:jetdispatch/views/history/p2_table_dropoff.dart';
import 'package:jetdispatch/views/history/p2_table_pickup.dart';

class TabPTwo extends StatefulWidget {
  const TabPTwo({Key? key}) : super(key: key);

  @override
  State<TabPTwo> createState() => _TabPTwoState();
}

class _TabPTwoState extends State<TabPTwo>
    with AutomaticKeepAliveClientMixin<TabPTwo> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Material(
                color: Colors.black87,
                child: TabBar(
                  labelColor: Colors.white,
                  indicator: BoxDecoration(
                    color: Colors.redAccent,
                  ),
                  tabs: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('ALL'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('PICKUPS'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('DROPOFFS'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    P2TableAll(),
                    P2TablePickup(),
                    P2TableDropoff(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
