import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:angular_blog/models/posts.dart';
import 'package:angular_blog/models/user.dart';
import 'package:angular_blog/services/blog_service.dart';
import 'package:angular_blog/services/comment_bloc.dart';
import 'package:angular_blog/services/js_service.dart';
import 'package:angular_blog/src/post/components/comment/comment_component.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_blog/routes/routes.dart';
import 'dart:html';
@Component(
    selector: 'app-post',
    templateUrl: 'posts_component.html',
    styleUrls: [
      'posts_component.css'
    ],
    directives: [
      NgIf,
      NgFor,
      NgSwitch,
      NgSwitchWhen,
      CommentComponent,
    ],
    pipes: [
      AsyncPipe,
    ])
class PostComponent implements OnActivate, CommentPresenter {
  Post post;
  final BlogService blogService;
  final JSService _js;
  final CommentBloc commentBloc;
  final Router _router;
  bool loadingComments = false;
  bool sendingComment = false;
  User author;

  PostComponent(this.blogService, this._js, this.commentBloc, this._router);

  @override
  void onActivate(RouterState previous, RouterState current) {
    final id = getId(current.parameters);
    if (id == null) return;
    post = blogService.get(id);
    author = post.author;
    //commentBloc.listCommentController.add(id);
    commentBloc.getComments(id, this);
    commentBloc.comments.listen((data) {
      if (data is Exception) _js.toast(data.toString());
    });
  }

  trackByFn(index, item) {
    return item.id; // or item.id
  }

  String getId(Map<String, String> parameters) {
    return parameters[idParam];
  }

  void setComment(String message) {
    final data = {
      "user_id": 'f469c12c-4709-11e9-957b-f45c89b50e55',
      "post_id": '${post.id}',
      "message": message,
    };
    commentBloc.setComment(data, this);
  }

  @override
  void onGetAllFailed(Exception error) {
    _js.toast('Get all comment failed. ${error.toString()}');
  }

  @override
  void onGetAllSuccess() {
    _js.toast('Get all comment successfully');
  }

  @override
  void onGettingAll() {
    loadingComments = true;
  }

  @override
  void onGetAllDone() {
    loadingComments = false;
  }

  @override
  void onPostDone() {
    sendingComment = false;
  }

  @override
  void onPostFailed(Exception error) {
    _js.toast('Post comment failed. ${error.toString()}');
  }

  @override
  void onPostSuccess() {
    _js.toast('Post comment successfully');
  }

  @override
  void onPosting() {
    sendingComment = true;
  }

  @override
  void onUnAuthorization() {
    _router.navigate(RoutePaths.dashboard.toUrl());
  }
}
