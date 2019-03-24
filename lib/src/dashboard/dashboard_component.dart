import 'package:angular/angular.dart';
import 'package:angular_blog/services/session_bloc.dart';

@Component(
  selector: 'app-dashboard',
  templateUrl: 'dashboard_component.html',
)
class DashboardComponent {
  final SessionBloc _session;

  DashboardComponent(this._session);

  onLogin() {
    print("on login");
    this._session.login();
  }
}
