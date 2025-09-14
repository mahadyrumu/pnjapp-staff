import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApi {
  final String _baseUrl = "http://prodlot2.parknjetseatac.com:9000/dispatcher/";

  signIn(data, endPoint) async {
    return await http.post(
      Uri.parse(_baseUrl + endPoint),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  _setHeaders() =>
      {'Content-type': 'application/json', 'Accept': 'application/json'};
}
