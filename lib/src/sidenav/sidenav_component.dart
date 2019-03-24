import 'package:angular_blog/models/index.dart';
import 'package:angular/angular.dart';
import 'package:angular_blog/services/blog_service.dart';
import 'package:angular_blog/services/js_service.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_blog/routes/routes.dart';

@Component(
  selector: 'side-nav',
  styleUrls: ['sidenav_component.css'],
  templateUrl: 'sidenav_component.html',
  directives: [NgFor, NgIf],
  pipes: [AsyncPipe]
)
class SideNavComponent implements AfterViewInit, OnInit {
  final BlogService blogService;
  final JSService _js;
  final Router _router;

  SideNavComponent(this.blogService, this._js, this._router);

  @override
  void ngAfterViewInit() {
    _js.$('.sidenav').sidenav();
    _js.$('.collapsible').collapsible();
    _js.$('.fixed-action-btn').floatingActionButton();
  }

  @override
  void ngOnInit() {
    blogService.getAll();
  }

  String _postUrl(String id) {
    return RoutePaths.post.toUrl(parameters: {idParam: '$id'});
  }

  Future<NavigationResult> getPost(Post post) {
    _router.navigate(_postUrl(post.id));
  }
}
