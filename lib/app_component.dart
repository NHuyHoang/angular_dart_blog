import 'package:angular/angular.dart';
import 'package:angular_blog/services/blog_service.dart';
import 'package:angular_blog/services/comment_bloc.dart';
import 'package:angular_blog/services/http_service.dart';
import 'package:angular_blog/services/js_service.dart';
import 'package:angular_blog/services/session_bloc.dart';
import 'package:angular_router/angular_router.dart';
import 'routes/routes.dart';

//component
import 'src/sidenav/sidenav_component.dart';
import 'src/elements/header/header_component.dart';
import 'src/todo_list/todo_list_component.dart';

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [
    TodoListComponent,
    SideNavComponent,
    HeaderComponent,
    routerDirectives
  ],
  providers: [
    ClassProvider(JSService),
    ClassProvider(BlogService),
    ClassProvider(CommentBloc),
    ClassProvider(HttpService),
    ClassProvider(SessionBloc)
  ],
  exports: [Routes],
)
class AppComponent implements AfterViewInit {
  @override
  void ngAfterViewInit() {
    print('View Init done');
  }
}
