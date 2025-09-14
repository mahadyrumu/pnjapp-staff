import 'package:flutter/material.dart';
import 'package:jetdispatch/views/pickups/lot_one_pickup.dart';
import 'package:jetdispatch/views/pickups/lot_two_pickup.dart';

class Pickups extends StatefulWidget {
  const Pickups({Key? key}) : super(key: key);

  @override
  State<Pickups> createState() => _PickupsState();
}

class _PickupsState extends State<Pickups> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
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
                        'P1',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'P2',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    LotOnePickup(),
                    LotTwoPickup(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
