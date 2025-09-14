import 'package:flutter/material.dart';
import 'package:jetdispatch/views/history/p1_table_all.dart';
import 'package:jetdispatch/views/history/p1_table_dropoff.dart';
import 'package:jetdispatch/views/history/p1_table_pickup.dart';

class TabPOne extends StatefulWidget {
  const TabPOne({Key? key}) : super(key: key);

  @override
  State<TabPOne> createState() => _TabPOneState();
}

class _TabPOneState extends State<TabPOne>
    with AutomaticKeepAliveClientMixin<TabPOne> {
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
                      child: Text(
                        'ALL',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'PICKUPS',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'DROPOFFS',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    P1TableAll(),
                    P1TablePickup(),
                    P1TableDropoff(),
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
