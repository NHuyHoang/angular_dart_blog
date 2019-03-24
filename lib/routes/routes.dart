import 'package:angular_router/angular_router.dart';
import 'package:angular_blog/src/post/posts_component.template.dart'
    as posts_template;
import 'package:angular_blog/src/dashboard/dashboard_component.template.dart'
    as dashboard_template;
import 'route_paths.dart';

export 'route_paths.dart';

class Routes {
  static final post = RouteDefinition(
    routePath: RoutePaths.post,
    component: posts_template.PostComponentNgFactory,
  );

  static final dashboard = RouteDefinition(
    routePath: RoutePaths.dashboard,
    component: dashboard_template.DashboardComponentNgFactory,
  );

  static final all = <RouteDefinition>[
    post,
    dashboard,
    RouteDefinition.redirect(
      path: '',
      redirectTo: RoutePaths.dashboard.toUrl(),
    )
  ];
}
