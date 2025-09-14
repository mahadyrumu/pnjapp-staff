import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jetdispatch/config/urls.dart';

class DispatchService {
  getCompleteAllLotOne(String lot) async {
    try {
      var fullUrl =
          "${getApiBaseUrl(lot)}/dispatcher/dispatchs/completed/all?count=15";
      var response = await http.get(Uri.parse(fullUrl), headers: _setHeaders());
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

Future<List<dynamic>> fetchDispatchInfo(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load dispatch info!');
  }
}
