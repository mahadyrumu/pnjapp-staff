import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jetdispatch/services/dispatch_service.dart';
import 'package:jetdispatch/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class P2TableAll extends StatefulWidget {
  const P2TableAll({Key? key}) : super(key: key);

  @override
  State<P2TableAll> createState() => _P2TableAllState();
}

class _P2TableAllState extends State<P2TableAll>
    with AutomaticKeepAliveClientMixin<P2TableAll> {
  late RealtimeChannel _channel;
  List cells = [];

  getP2TableData() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    await DispatchService().getCompleteAllLotOne("lot2").then((res) {
      if (res != null) {
        lot2GetCompletedHistory(res);
        setState(() {
          cells = lot2GetCompletedHistory(res);
        });
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getP2TableData();
      _channel = SupabaseService()
          .liveUpdate(['LOT_2_HISTORY_UPDATE'], getP2TableData);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // var txt = "Mar 22, 2023 1:30:00 PM";
    // convertToTime(txt);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Table(
        border: TableBorder.all(),
        columnWidths: const {
          0: FractionColumnWidth(0.15),
          1: FractionColumnWidth(0.1),
          2: FractionColumnWidth(0.1),
          3: FractionColumnWidth(0.1),
          4: FractionColumnWidth(0.1),
          5: FractionColumnWidth(0.12),
          6: FractionColumnWidth(0.1),
          7: FractionColumnWidth(0.1),
          8: FractionColumnWidth(0.1),
        },
        children: [
          buildRow(
              ['Closed', 'AT', 'RFP', 'WT', 'PNJ', 'PORT', 'IL', 'PNJ', 'VT'],
              isHeader: true),
          for (var item in cells)
            TableRow(children: [
              Container(
                color: Color(int.parse(
                    item['onVanRoleColorCode'].replaceAll('#', '0xff'))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Center(
                      child: Text(
                    item['claimId'].toString(),
                    style: const TextStyle(color: Colors.white),
                  )),
                ),
              ),
              Container(
                color: item['advanceTime'] > 10 && item['advanceTime'] <= 20
                    ? Colors.yellow[800]
                    : item['advanceTime'] > 20
                        ? Colors.red
                        : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Center(child: Text(item['advanceTime'].toString())),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Center(child: Text(item['requestForPickup'])),
              ),
              Container(
                color: item['waitTime'] != null
                    ? item['waitTime'].toInt() > 10 &&
                            item['waitTime'].toInt() <= 20
                        ? Colors.yellow[800]
                        : item['waitTime'].toInt() > 20
                            ? Colors.red
                            : Colors.white
                    : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Center(
                      child: Text(item['waitTime'] != null
                          ? item['waitTime'].toString()
                          : "")),
                ),
              ),
              Container(
                color: item['isHistoryPickup'] == true
                    ? Colors.grey
                    : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Center(child: Text(item['pnj1'].toString())),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Center(child: Text(item['port'])),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Center(
                    child: Text(item['isHistoryPickup'] == true
                        ? item['islandNo'].toString()
                        : "0")),
              ),
              Container(
                color: item['isHistoryPickup'] == false
                    ? Colors.grey
                    : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Center(
                      child: Text(item['isHistoryPickup'] == true
                          ? item['offVan'].toString()
                          : "drop")),
                ),
              ),
              Container(
                color: item['vanTime'] != null
                    ? item['vanTime'] > 10 && item['vanTime'] <= 20
                        ? Colors.yellow[800]
                        : item['vanTime'] > 20
                            ? Colors.red
                            : Colors.white
                    : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Center(
                      child: Text(item['vanTime'] != null
                          ? item['vanTime'].toString()
                          : "")),
                ),
              ),
            ])
        ],
      ),
    );
  }

  @override
  void dispose() {
    SupabaseService().removeSupabaseChannel(_channel);
    super.dispose();
  }

  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
          children: cells.map((cell) {
        final style = TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal);
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: Center(
              child: Text(
            cell,
            style: style,
          )),
        );
      }).toList());

  @override
  bool get wantKeepAlive => true;
}

lot2GetCompletedHistory(response) {
  if (response['status'] == 'OK') {
    var lot1CompletedDispatchesTemp = response['data'];
    for (var i = lot1CompletedDispatchesTemp.length - 1; i >= 0; i--) {
      lot1CompletedDispatchesTemp[i] =
          parseCompletedDispatch(lot1CompletedDispatchesTemp[i], 1);
    }

    // print(lot1CompletedDispatchesTemp.toString());
    return lot1CompletedDispatchesTemp;
  }
}

parseCompletedDispatch(completedDispatch, lotNo) {
  var returnDispatch = completedDispatch;
  getMonthToInt(month) {
    List monthString = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    if (monthString.indexOf(month) <= 8) {
      return '0${monthString.indexOf(month) + 1}';
    } else {
      return (monthString.indexOf(month) + 1);
    }
  }

  getTimeString(time) {
    if (time[1] != ':') {
      return time;
    } else {
      return '0$time';
    }
  }

  getDayString(day) {
    if (day[1] != ',') {
      return day;
    } else {
      return '0$day';
    }
  }

  formateDateTime(dateTime) {
    var formatedDateTime = dateTime
        .toString()
        .split(" ")
        .map((String dateTime) => dateTime)
        .toList();
    // ignore: prefer_interpolation_to_compose_strings
    var newDateTime = formatedDateTime[2].toString() +
        "-" +
        getMonthToInt(formatedDateTime[0].toString()).toString() +
        '-' +
        getDayString(formatedDateTime[1].toString())
            .replaceAll(RegExp(r'[^\w\s]+'), '') +
        ' ' +
        getTimeString(formatedDateTime[3].toString());
    return DateTime.parse(newDateTime);
  }

  returnDispatch['start'] = '--';
  returnDispatch['requestForPickup'] = '--';
  returnDispatch['onVan'] = '--';
  returnDispatch['offVan'] = '--';
  returnDispatch['advanceTime'] = '--';
  returnDispatch['lotNo'] = lotNo;

  var eventListForDispatch = null;
  if (returnDispatch['isHistoryPickup']) {
    eventListForDispatch = returnDispatch['pickupDispatchEvents'];
  } else {
    eventListForDispatch = returnDispatch['dropOffDispatchEvents'];
  }
  for (var index = 0; index < eventListForDispatch.length; ++index) {
    var dispatchEvent = eventListForDispatch[index];

    if (dispatchEvent['eventConstant']['constantKey'] == "DROPOFF_START") {
      returnDispatch['start'] = dispatchEvent['createdAt'];
      returnDispatch['startRealTime'] = dispatchEvent['createdAt'];
    } else if (dispatchEvent['eventConstant']['constantKey'] ==
        "REQUEST_FOR_PICKUP") {
      //console.log('found the REQUEST_FOR_PICKUP');
      returnDispatch['requestForPickup'] =
          DateFormat.Hm().format(formateDateTime(dispatchEvent['createdAt']));
      returnDispatch['requestForPickupRealTime'] = dispatchEvent['createdAt'];
    } else if (dispatchEvent['eventConstant']['constantKey'] == "GET_ON_VAN") {
      //console.log('found the GET_ON_VAN');
      returnDispatch['onVan'] =
          DateFormat.Hm().format(formateDateTime(dispatchEvent['createdAt']));
      returnDispatch['onVanRealTime'] = dispatchEvent['createdAt'];
      returnDispatch['onVanUser'] = dispatchEvent['createdBy'];
      returnDispatch['onVanRole'] =
          dispatchEvent['roleConstant']['constantValue'];
      returnDispatch['onVanRoleColorCode'] =
          '#' + dispatchEvent['roleConstant']['colorCode'];
      // isWaiting = false;
    } else if (dispatchEvent['eventConstant']['constantKey'] == "GET_OFF_VAN") {
      //console.log('found the GET_OFF_VAN');
      returnDispatch['offVan'] =
          DateFormat.Hm().format(formateDateTime(dispatchEvent['createdAt']));
      returnDispatch['offVanRealTime'] = dispatchEvent['createdAt'];
    }
  }

  if (returnDispatch['isHistoryPickup'] == false &&
      returnDispatch['start'] != '--' &&
      returnDispatch['requestForPickup'] != '--') {
    returnDispatch['advanceTime'] =
        (formateDateTime(returnDispatch['requestForPickupRealTime'])
                .difference(formateDateTime(returnDispatch['startRealTime'])))
            .inMinutes;
  } else {
    returnDispatch['advanceTime'] = returnDispatch['pickupAdvanceTime'];
  }

  if (returnDispatch['onVan'] != '--' && returnDispatch['offVan'] != '--') {
    returnDispatch['vanTime'] =
        (formateDateTime(returnDispatch['offVanRealTime'])
                .difference(formateDateTime(returnDispatch['onVanRealTime'])))
            .inMinutes;
  }

  if (returnDispatch['isHistoryPickup']) {
    returnDispatch['pnj1'] = 'pick';
  } else {
    returnDispatch['pnj1'] = returnDispatch['onVan'];
  }

  if (returnDispatch['isHistoryPickup']) {
    returnDispatch['pnj2'] = returnDispatch['offVan'];
  } else {
    returnDispatch['pnj2'] = 'drop';
  }

  if (returnDispatch['isHistoryPickup']) {
    returnDispatch['port'] = returnDispatch['onVan'];
  } else {
    returnDispatch['port'] = returnDispatch['offVan'];
  }

  if (returnDispatch['isHistoryPickup']) {
    returnDispatch['island'] = returnDispatch['island'];
  } else {
    returnDispatch['island'] = 0;
  }

  if (returnDispatch['requestForPickup'] != '--' &&
      returnDispatch['onVan'] != '--') {
    returnDispatch['waitTime'] =
        (formateDateTime(returnDispatch['onVanRealTime']).difference(
                formateDateTime(returnDispatch['requestForPickupRealTime'])))
            .inMinutes;
  }

  return returnDispatch;
}
