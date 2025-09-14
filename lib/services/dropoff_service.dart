import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jetdispatch/config/urls.dart';

class DropoffService {
  getDropoffAllLotOne() async {
    try {
      var fullUrl = "${getApiBaseUrl('lot1')}/dispatcher/dispatchs/dropoff/all";
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

  getDropoffAllLotTwo() async {
    try {
      var fullUrl = "${getApiBaseUrl('lot2')}/dispatcher/dispatchs/dropoff/all";
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

  // _getToken() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var token = localStorage.getString('token');
  //   return '?token=$token';
  // }
}
