import 'package:flutter/material.dart';
import 'package:jetdispatch/views/checkout/lot_one_checkout.dart';
import 'package:jetdispatch/views/checkout/lot_two_checkout.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
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
                    LotOneCheckOut(),
                    LotTwoCheckOut(),
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
