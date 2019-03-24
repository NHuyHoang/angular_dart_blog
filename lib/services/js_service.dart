@JS()
library main;

import 'package:js/js.dart';

@JS("jQuery")
external dynamic jquery(String selector);

@JS("M")
external dynamic get M;

@JS("M")
external dynamic get bodymovin;


@JS("JSON.parse")
external String jsonParse(String str);

class JSService {
  JSService();

  dynamic get $ => jquery;

  void toast(String message) => M.toast(jsonParse('{"html": "$message"}'));


}
