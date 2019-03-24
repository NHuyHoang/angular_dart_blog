@JS('console') // Our `console` namespace
library main; // library name can be whatever you want
import 'package:js/js.dart';
@JS('log') // Setting the proxy to the `console.log` method
external void log(dynamic str);
void main() {
  log('Hello world!');
}