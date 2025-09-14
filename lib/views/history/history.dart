import 'package:flutter/material.dart';
import 'package:jetdispatch/views/history/tab_p_one.dart';
import 'package:jetdispatch/views/history/tab_p_two.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Material(
                color: Colors.black87,
                child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  indicator: BoxDecoration(
                    border: Border(
                        left: BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                        top: BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                        right: BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        )),
                    color: Colors.redAccent,
                  ),
                  tabs: [
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'P1',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'P2',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  TabPOne(),
                  TabPTwo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
