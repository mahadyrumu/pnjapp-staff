import 'package:flutter/material.dart';
import 'package:jetdispatch/controller/dropoff_controller.dart';
import 'package:jetdispatch/services/dropoff_service.dart';
import 'package:jetdispatch/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LotOneDropoff extends StatefulWidget {
  const LotOneDropoff({Key? key}) : super(key: key);

  @override
  State<LotOneDropoff> createState() => _LotOneDropoffState();
}

class _LotOneDropoffState extends State<LotOneDropoff>
    with AutomaticKeepAliveClientMixin<LotOneDropoff> {
  late RealtimeChannel _channel;
  List datas = [];

  void _getDropoffs() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    await DropoffService().getDropoffAllLotOne().then((res) {
      if (res != null) {
        var dropoffs = DropoffController().processDropoffSuccessResponse(res);
        setState(() {
          datas = dropoffs['dropoffs'];
        });
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
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
            2: FractionColumnWidth(0.14),
            3: FractionColumnWidth(0.12),
            4: FractionColumnWidth(0.10),
            5: FractionColumnWidth(0.14),
            6: FractionColumnWidth(0.14),
          },
          children: [
            buildRow(['Dropoff', 'Start', 'RFP', 'PNJ', 'IL', 'PORT', 'lo'],
                isHeader: true),
            for (var data in datas)
              TableRow(children: [
                Container(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Center(
                        child: Text(
                      data['claimId'].toString(),
                      style: const TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                Container(
                  color: Color(int.parse(
                      data['startRoleColorCode'].replaceAll('#', '0xff'))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Center(
                        child: Text(
                      data['start'],
                      style: const TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                Container(
                  color: Color(int.parse("0xffCACA12")),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Center(
                        child: Text(data['requestForPickup'].toString())),
                  ),
                ),
                Container(
                  color: Color(int.parse(
                      data['onVanRoleColorCode'].replaceAll('#', '0xff'))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Center(
                        child: Text(
                      data['onVan'],
                      style: const TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Center(child: Text(data['islandNo'].toString())),
                ),
                Container(
                  color: data['offVanRoleColorCode'] != null
                      ? Color(int.parse(
                          data['offVanRoleColorCode'].replaceAll('#', '0xff')))
                      : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Center(
                        child: Text(data['offVan'],
                            style: TextStyle(
                                color: data['offVanRoleColorCode'] != null
                                    ? Colors.white
                                    : Colors.black))),
                  ),
                ),
                Container(
                  color: Color(int.parse(
                      data['onVanRoleColorCode'].replaceAll('#', '0xff'))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Center(
                        child: Text(
                      data['row'] == "" && data['stall'] == ""
                          ? "--"
                          : data['row'] + " " + data['stall'],
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
