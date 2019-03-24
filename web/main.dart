import 'package:angular/angular.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_blog/app_component.template.dart' as ng;
import 'main.template.dart' as self;

@GenerateInjector([
  ClassProvider(BrowserClient),
  routerProvidersHash,
])
final InjectorFactory injector = self.injector$Injector;

void main() {
  runApp(ng.AppComponentNgFactory, createInjector: injector);
}
