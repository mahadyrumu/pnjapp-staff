import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RequestForPickup extends StatefulWidget {
  const RequestForPickup({Key? key}) : super(key: key);

  @override
  State<RequestForPickup> createState() => _RequestForPickupState();
}

class _RequestForPickupState extends State<RequestForPickup> {
  final TextEditingController _claimIdController = TextEditingController();
  final TextEditingController _advanceTimeController = TextEditingController();
  String userData = "";

  readUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userData = prefs.getString('user_data')!;
    return userData;
  }

  Future<void> _submitPickupEntry(island) async {
    Map<String, dynamic> userDataMap =
        jsonDecode(userData) as Map<String, dynamic>;
    var params = {
      'claimId': _claimIdController.text.toString(),
      'advanceTime': _advanceTimeController.text.toString(),
      'island': island.toString(),
      'userName': userDataMap['user']['userName'].toString(),
      'roleConstantKey': 'office',
    };

    var res = await http.post(
        Uri.parse(
            "http://prodlot2.parknjetseatac.com:9000/dispatcher/dispatchs/pickup/create"),
        body: params);
    var body = jsonDecode(res.body);

    if (body['status'] == "OK") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
          content: Icon(
            Icons.check,
            size: 25,
          ),
          actions: <Widget>[],
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readUserData();
  }

  Widget claimIdInputField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            height: 50,
            child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: const TextStyle(
                  color: Colors.black87,
                ),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                    hintText: 'Claim Id',
                    hintStyle: TextStyle(color: Colors.black38))),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "Claim Id",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: TextField(
                      controller: _claimIdController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "Advance Time",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: TextField(
                      controller: _advanceTimeController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        // labelText: 'Password',
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 150,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        _submitPickupEntry(1);
                      },
                      child: const Text(
                        'Port 1',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Port 3',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
