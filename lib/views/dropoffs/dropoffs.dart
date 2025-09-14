import 'package:flutter/material.dart';
import 'package:jetdispatch/views/dropoffs/lot_one_dropoff.dart';
import 'package:jetdispatch/views/dropoffs/lot_two_dropoff.dart';

class Dropoffs extends StatefulWidget {
  const Dropoffs({Key? key}) : super(key: key);

  @override
  State<Dropoffs> createState() => _DropoffsState();
}

class _DropoffsState extends State<Dropoffs> {
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
                    LotOneDropoff(),
                    LotTwoDropoff(),
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
