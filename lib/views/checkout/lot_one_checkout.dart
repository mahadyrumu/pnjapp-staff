import 'package:flutter/material.dart';
import 'package:jetdispatch/controller/pickups_controller.dart';
import 'package:jetdispatch/services/pickup_service.dart';
import 'package:jetdispatch/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LotOneCheckOut extends StatefulWidget {
  const LotOneCheckOut({Key? key}) : super(key: key);

  @override
  State<LotOneCheckOut> createState() => _LotOneCheckOutState();
}

class _LotOneCheckOutState extends State<LotOneCheckOut>
    with AutomaticKeepAliveClientMixin<LotOneCheckOut> {
  late RealtimeChannel _channel;
  List datas = [];

  // void _getCheckInData() async {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       });
  //   await DropoffService().getDropoffAllLotOne().then((res) {
  //     if (res != null) {
  //       var checkInData =
  //           CheckInController().processCheckInSuccessResponse(res);
  //       setState(() {
  //         datas = checkInData['checkInData'];
  //       });
  //       Navigator.of(context).pop();
  //     }
  //   });
  // }

  void _getDropoffs() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    await PickupService().getPickupAllLotOne().then((res) {
      if (res != null) {
        var dropoffs = PickupsController().processPickupSuccessResponse(res);
        setState(() {
          datas = dropoffs['pickups'];
        });
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // _getCheckInData();
      _getDropoffs();
      _channel =
          SupabaseService().liveUpdate(['LOT_1_DISPATCH_UPDATE'], _getDropoffs);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Table(
          border: TableBorder.all(),
          columnWidths: const {
            0: FractionColumnWidth(0.24),
            1: FractionColumnWidth(0.12),
            2: FractionColumnWidth(0.10),
            3: FractionColumnWidth(0.12),
          },
          children: [
            buildRow([
              'Claim Id',
              'Location',
              'Time ',
              'Delay',
            ], isHeader: true),
            for (var data in datas)
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Center(
                      child: Text(
                    data['claimId'].toString(),
                    style: const TextStyle(color: Colors.blue),
                  )),
                ),
                Container(
                  color: data['row'] == '' || data['stall'] == ''
                      ? Colors.red
                      : data['row'] != '' &&
                              data['stall'] != '' &&
                              data['parkingStatus'] == 'TEMP'
                          ? Colors.red
                          : data['row'] != '' &&
                                  data['stall'] != '' &&
                                  data['parkingStatus'] != 'TEMP'
                              ? const Color(0xff009EFF)
                              : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Center(
                        child: Text(
                      data['row'] == '' && data['stall'] == ''
                          ? "NA"
                          : data['row'] + " " + data['stall'],
                      style: const TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Center(
                      child: Text(data['lotTime'] != null
                          ? data['lotTime'].toString()
                          : 'NA')),
                ),
                Container(
                  color: data['lateDays'] > 0 ? Colors.red : Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Center(
                        child: Text(
                      data['lateDays'] > 0
                          ? data['lateDays'].toString()
                          : 'Not Late',
                      style: const TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              ])
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

  TableRow buildRow(List<String> datas, {bool isHeader = false}) => TableRow(
          children: datas.map((data) {
        final style = TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal);
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: Center(
              child: Text(
            data,
            style: style,
          )),
        );
      }).toList());

  @override
  bool get wantKeepAlive => true;
}
