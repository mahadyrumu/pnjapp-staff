import 'dart:convert';
import 'package:http/http.dart' as http;

class ReservationService {
  static const String reservationsForLot1 =
      'http://prodlot1.parknjetseatac.com:9000/jqmNewReservations';
  static const String reservationsForLot2 =
      'http://prodlot2.parknjetseatac.com:9000/jqmNewReservations';

  getReservationLotOne() async {
    try {
      var response = await http.get(Uri.parse(reservationsForLot1),
          headers: _setHeaders());
      if (response.body.isNotEmpty) {
        var data = json.decode(response.body);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      // print("Unable to fetch pickup $e");
    }
  }

  _setHeaders() =>
      {'Content-type': 'application/json', 'Accept': 'application/json'};
}
