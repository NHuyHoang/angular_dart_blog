import 'dart:convert';
import 'package:angular_blog/public/globalkey.dart';
import 'package:http/browser_client.dart';
import 'dart:io';
import 'package:http/http.dart';
import 'package:angular_blog/public/globalkey.dart';

enum HTTP_METHOD { GET, POST, PUT, PATCH, DELETE }

class HttpService {
  final BrowserClient _http;
  static final _api = '${GlobalKey.BASE_URL}';
  Map<String, String> headers = {
    "content-type": "Application/json",
    // "Access-Control-Allow-Headers":"*",
    // 'Access-Control-Allow-Credentials': 'true',
    // "Access-Control-Allow-Origin": "*"
  };

  HttpService(this._http) {
    this._http.withCredentials = true;
  }

  Future<dynamic> send({
    HTTP_METHOD method,
    String url,
    dynamic body,
  }) {
    Cookie cookie = new Cookie('test_cookie', 'test_value___')..httpOnly = true;
    try {
      var _url = '$_api$url';
      switch (method) {
        case HTTP_METHOD.POST:
          if (body == null)
            throw new Exception('Please provide body for POST request');
          return _post(_url, body);
        case HTTP_METHOD.PUT:
        case HTTP_METHOD.DELETE:
        case HTTP_METHOD.PATCH:
        default:
          return _get(_url);
          ;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<dynamic> _get(url) async {
    try {
      Response res = await _http.get(url, headers: headers);
      this._statusCodeHandle(res);
      if (res.statusCode != HttpStatus.ok)
        throw new ClientException('Failed to get data');
      return _expandResponse(res);
    } on UnauthorizedException catch (e) {
      rethrow;
    } catch (e) {
      throw new Exception(e.toString());
    }
  }

  Future<dynamic> _post(url, dynamic body) async {
    try {
      Response res = await _http.post(url, headers: headers, body: body);
      this._statusCodeHandle(res);
      if (res.statusCode == HttpStatus.created ||
          res.statusCode == HttpStatus.ok) return _expandResponse(res);
      if (res.statusCode == HttpStatus.notAcceptable) {
        var errorResponse = _expandResponse(res, prefix: 'post failed');
        throw new ClientException(errorResponse['message']);
      }
      throw new ClientException('Data not created');
    } on UnauthorizedException catch (e) {
      rethrow;
    } catch (e) {
      throw new Exception(e.toString());
    }
  }

  Exception _statusCodeHandle(Response res) {
    switch (res.statusCode) {
      case HttpStatus.unauthorized:
        throw new UnauthorizedException('Please sign-in');
      default:
        return null;
    }
  }

  dynamic _expandResponse(Response res, {String prefix}) {
    try {
      return json.decode(res.body);
    } catch (e) {
      if (prefix != null) {
        throw new Exception('$prefix. ${e.toString()}');
      } else
        rethrow;
    }
  }
}

class UnauthorizedException implements Exception {
  final String errorMesage;
  UnauthorizedException(this.errorMesage);
  String toString() => errorMesage;
}

class NotAcceptableException implements Exception {
  String errorMesage;
  NotAcceptableException(String errorMesage);
}
