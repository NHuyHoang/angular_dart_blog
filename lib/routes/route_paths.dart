import 'package:angular_router/angular_router.dart';
const idParam = 'id';

class RoutePaths {
  static final post = RoutePath(path: 'post/:$idParam');
  static final dashboard = RoutePath(path: 'dashboard');
}