import 'dart:convert';

import 'package:angular_blog/services/http_service.dart';
import 'package:http/http.dart';

class SessionBloc {
  final HttpService _http;

  SessionBloc(this._http);

  login() async {
    try {
      final data = {"username": "admin", "password": "huyhoang123"};
      final res = await _http.send(
          url: "auth/", body: json.encode(data), method: HTTP_METHOD.POST);
      //set an interval for refresh new token using the res['token']
      //if refresh failed -> jwt_secret has changed -> cancelInterval()
      print(res);
    } catch (e) {
      
    }
  }
}
