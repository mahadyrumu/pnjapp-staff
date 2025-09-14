import 'package:flutter/material.dart';
import 'package:jetdispatch/controller/pickups_controller.dart';
import 'package:jetdispatch/services/pickup_service.dart';
import 'package:jetdispatch/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LotOnePickup extends StatefulWidget {
  const LotOnePickup({Key? key}) : super(key: key);

  @override
  State<LotOnePickup> createState() => _LotOnePickupState();
}

class _LotOnePickupState extends State<LotOnePickup>
    with AutomaticKeepAliveClientMixin<LotOnePickup> {
  late RealtimeChannel _channel;
  bool loader = true;
  List datas = [];

  void _getPickups() async {
    if (loader) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
    }
    await PickupService().getPickupAllLotOne().then((res) {
      if (res != null) {
        var pickups = PickupsController().processPickupSuccessResponse(res);
        setState(() {
          loader = false;
          datas = pickups['pickups'];
        });
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getPickups();
      _channel =
          SupabaseService().liveUpdate(['LOT_1_DISPATCH_UPDATE'], _getPickups);
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
            buildRow(['Pickup', 'RFP', 'AT', 'PORT', 'IL', 'PNJ', 'lo'],
                isHeader: true),
            for (var data in datas)
              TableRow(children: [
                Container(
                  color: Color(int.parse(data['requestForPickupRoleColorCode']
                      .replaceAll('#', '0xff'))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Center(
                        child: Text(
                      data['rsvnId'].toString(),
                      style: const TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                Container(
                  color: Color(int.parse(data['requestForPickupRoleColorCode']
                      .replaceAll('#', '0xff'))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Center(
                        child: Text(
                      data['requestForPickup'],
                      style: const TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Center(
                      child: Text(data['pickupAdvanceTime'] != null
                          ? data['pickupAdvanceTime'].toString()
                          : "--")),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Center(child: Text(data['offVan'])),
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
