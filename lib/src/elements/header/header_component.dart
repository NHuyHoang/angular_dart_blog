import 'package:angular/angular.dart';
import 'package:angular_blog/services/js_service.dart';

@Component(
  selector: 'app-header',
  templateUrl: 'header_component.html',
  styleUrls: ['header_component.css'],
  providers: [JSService]
)
class HeaderComponent implements AfterViewInit{
  final JSService _js;

  HeaderComponent(this._js);

  @override
  void ngAfterViewInit() {
    _js.$('.tabs').tabs();
  }

}