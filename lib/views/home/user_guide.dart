import 'package:flutter/material.dart';

class UserGuide extends StatefulWidget {
  const UserGuide({Key? key}) : super(key: key);

  @override
  State<UserGuide> createState() => _UserGuideState();
}

class _UserGuideState extends State<UserGuide> {
  bool isExpanded = false;
  int cardID = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Card(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isExpanded == true) {
                        isExpanded = false;
                        cardID = 0;
                      } else {
                        isExpanded = true;
                        cardID = 1;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        isExpanded == true && cardID == 1
                            ? const Icon(Icons.remove)
                            : const Icon(Icons.add),
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Abbreviations",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isExpanded == true && cardID == 1
                    ? const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "RFP",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(" : Request For Pickup",
                                      style: TextStyle(fontSize: 16))
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "AT",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(" : Advance Time",
                                      style: TextStyle(fontSize: 16))
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "P1",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(" : Lot 1",
                                      style: TextStyle(fontSize: 16))
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "P2",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(" : Lot 2",
                                      style: TextStyle(fontSize: 16))
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Io",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(" : Location",
                                      style: TextStyle(fontSize: 16))
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "IL",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(" : Island",
                                      style: TextStyle(fontSize: 16))
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "WT",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(" : Wait Time",
                                      style: TextStyle(fontSize: 16))
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "VT",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(" : Van Time",
                                      style: TextStyle(fontSize: 16))
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "IN-p",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(" : Checkin Progress",
                                      style: TextStyle(fontSize: 16))
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "OUT-p",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(" : Checkout Progress",
                                      style: TextStyle(fontSize: 16))
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isExpanded == true) {
                        isExpanded = false;
                        cardID = 0;
                      } else {
                        isExpanded = true;
                        cardID = 2;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        isExpanded == true && cardID == 2
                            ? const Icon(Icons.remove)
                            : const Icon(Icons.add),
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Header details",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isExpanded == true && cardID == 2
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.asset("assets/images/header.png")
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isExpanded == true) {
                        isExpanded = false;
                        cardID = 0;
                      } else {
                        isExpanded = true;
                        cardID = 3;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        isExpanded == true && cardID == 3
                            ? const Icon(Icons.remove)
                            : const Icon(Icons.add),
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Footer details",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isExpanded == true && cardID == 3
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.asset("assets/images/footer.png")
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isExpanded == true) {
                        isExpanded = false;
                        cardID = 0;
                      } else {
                        isExpanded = true;
                        cardID = 4;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        isExpanded == true && cardID == 4
                            ? const Icon(Icons.remove)
                            : const Icon(Icons.add),
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Pickup entry details",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isExpanded == true && cardID == 4
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                        "The first row of the pickup entry fields are named on the header, the fields are as:",
                                        style: TextStyle(fontSize: 16)),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "Pickup :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " Claim Id of reservation once tapped on Claim Id we can select extra events that admin is created by PNJ-Admin Web Interface",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "RFP :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text: " Request For Pickup time",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "AT :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " Advance Time, Time that customer set, which customer can reach to given island)",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "PORT :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " Time that customer picked up from the island or checkbox that driver should select and click OK once customer is picked up",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "IL :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " Island that customer is waiting at",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "PNJ :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " Time that customer arrives to Lot or checkbox that driver should select and click OK once customer gets off van at Lot",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "lo :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text: " Location of customer's vehicle",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Image.asset("assets/images/pickup-details.png")
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isExpanded == true) {
                        isExpanded = false;
                        cardID = 0;
                      } else {
                        isExpanded = true;
                        cardID = 5;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        isExpanded == true && cardID == 5
                            ? const Icon(Icons.remove)
                            : const Icon(Icons.add),
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Dropoff entry details",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isExpanded == true && cardID == 5
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                        "The first row of the drop off entry fields are named on the header, the fields are as:",
                                        style: TextStyle(fontSize: 16)),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "Dropoff :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " Claim Id of reservation once tapped on Claim Id we can select extra events that admin is created by PNJ-Admin Web Interface ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "Start :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " Start of drop off dispatch, the time when checkin is processed in office",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "RFP :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text: " Request For Pickup time",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "PNJ :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " Time that customer gets on van at Lot or checkbox that driver should select and click OK once customer gets on van at Lot",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "IL :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " Island that customer should be dropped off",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "PORT :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " Time that customer dropped off to the island or checkbox that driver should select and click OK once customer is dropped off at island",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "lo :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text: " Location of customer's vehicle",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Image.asset("assets/images/drop-off-details.png")
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isExpanded == true) {
                        isExpanded = false;
                        cardID = 0;
                      } else {
                        isExpanded = true;
                        cardID = 6;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        isExpanded == true && cardID == 6
                            ? const Icon(Icons.remove)
                            : const Icon(Icons.add),
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "History details",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isExpanded == true && cardID == 6
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "Closed :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text: " Claim id of the reservation ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "AT :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " Advance Time of the dispatch, if pickup, the time that customer set will be shown, if drop off the time difference between start time and request for pickup time will be shown ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "RFP :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text: " Request for pickup time ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "WT :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " Wait time, time difference between RFP and onboard to van in minutes ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "PNJ :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " onboard time if drop off dispatch ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "PORT :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " off van time if drop off, onboard time if pickup ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "IL :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text: " Island number ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "PNJ :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text: " off van time if pickup dispatch ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "VT :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " Van time in minutes, how long customer spend on van. ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isExpanded == true) {
                        isExpanded = false;
                        cardID = 0;
                      } else {
                        isExpanded = true;
                        cardID = 7;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        isExpanded == true && cardID == 7
                            ? const Icon(Icons.remove)
                            : const Icon(Icons.add),
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Check in progress (IN-p)",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isExpanded == true && cardID == 7
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                        "There are 3 tabs on check in progress, Valet which is the progress for valet type of reservations, Self which is the progress for self type of reservations and All for both.",
                                        style: TextStyle(fontSize: 16)),
                                  )
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                        "There are 3 fields for Checkin progress: ",
                                        style: TextStyle(fontSize: 16)),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "Claim Id :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text: " The claim id of the reservation ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "Location :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " The location of the vehicle for reservation, once this field is tapped, user can change the location of the vehicle from showing modal view that includes the available locations.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text:
                                          "Parking Verified / Key Stored in Cabinet :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " For self reservations this field will act as parking verification, employee should select the checkbox and click on OK to verify parking for a given self parking. If the reservation is valet then this field will act as Key Stored in Cabinet, which employee should select the checkbox and click on OK after storing the key of the vehicle to the cabinet for a valet parking.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isExpanded == true) {
                        isExpanded = false;
                        cardID = 0;
                      } else {
                        isExpanded = true;
                        cardID = 8;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        isExpanded == true && cardID == 8
                            ? const Icon(Icons.remove)
                            : const Icon(Icons.add),
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Check out progress (OUT-p)",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isExpanded == true && cardID == 8
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                        "There are 4 fields for check out progress: ",
                                        style: TextStyle(fontSize: 16)),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "Claim Id :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text: " The claim id of the reservation ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "Current Loc :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " The location of the vehicle for reservation, once this field is tapped, user can change the location of the vehicle from showing modal view that includes the available locations.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "Status :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " The day difference from the original pickup time, if customer comes early this field will be green and showing the day count of how many days earlier customer has arrived, if customer comes late this field will be red and showing how many days customer comes late from original pickup date, if customer is late the next field, which is Check out button, will be disabled",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RichText(
                                  text: const TextSpan(
                                      text: "Action :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text:
                                          " Quick checkout button, once clicked the reservation will be checked out in parking system ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                  ])),
                            ),
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
