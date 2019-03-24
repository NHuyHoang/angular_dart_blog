import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:angular_blog/models/comment.dart';
import 'package:angular_blog/public/globalkey.dart';
import 'package:angular_blog/services/http_service.dart';
import 'package:rxdart/rxdart.dart';

class CommentBloc {
  static final _api = '${GlobalKey.BASE_URL}posts/';
  CommentPresenter _presenter;
  //final JSService _js;
  final HttpService _http;
  List<Comment> _commentRepo;

  StreamController<String> _listCommentController;
  StreamController<dynamic> _addCommentController;

  BehaviorSubject<List<Comment>> _comments;
  Stream<List<Comment>> get comments => _comments.stream;

  BehaviorSubject<Comment> _comment;
  Stream<Comment> get comment => _comment.stream;

  void dispose() {
    _listCommentController.close();
    _comments.close();
  }

  CommentBloc(this._http) {
    _commentRepo = [];
    _comments = new BehaviorSubject<List<Comment>>();
    _comment = new BehaviorSubject<Comment>();

    _listCommentController = new StreamController<String>()
      ..stream.listen((String id) => _getComments(id));

    _addCommentController = new StreamController<dynamic>()
      ..stream.listen((dynamic data) => _setComment(data));
  }

  void getComments(String postId, CommentPresenter presenter) {
    _presenter = presenter;
    _listCommentController.sink.add(postId);
  }

  Future<void> _getComments(String postId) async {
    _presenter.onGettingAll();
    List<Comment> results;
    try {
      final comments = await _http.send(
          url: 'posts/$postId/comments/', method: HTTP_METHOD.GET);
      results = comments
          .map<Comment>((dynamic comment) => new Comment.fromJson(comment))
          .toList();
      results.sort((Comment a, Comment b) {
        return -a.date_add.compareTo(b.date_add);
      });
      _commentRepo = results;
      _comments.add(results);
      _presenter.onGetAllSuccess();
    } on UnauthorizedException catch (e) {
      _presenter.onUnAuthorization();
      _presenter.onGetAllFailed(e);
    } catch (e) {
      _presenter.onGetAllFailed(e);
    } finally {
      _presenter.onGetAllDone();
    }
  }

  void setComment(dynamic data, CommentPresenter presenter) {
    _presenter = presenter;
    _addCommentController.sink.add(data);
  }

  Future<void> _setComment(dynamic data) async {
    try {
      if (data['user_id'] == null) {
        _presenter.onPostFailed(new Exception('Have you signed-in yet?'));
        return;
      }
      if (data['post_id'] == null) {
        _presenter.onPostFailed(new Exception('This post is not exist'));
        return;
      }
      final comment = await _http.send(
          url: 'comments/', method: HTTP_METHOD.POST, body: json.encode(data));

      _comment.add(new Comment.fromJson(comment));

      List<Comment> newList = _comments.value;
      newList.insert(0, new Comment.fromJson(comment));

      _comments.add(newList);
      _presenter.onPostSuccess();
    } on UnauthorizedException catch (e) {
      _presenter.onUnAuthorization();
      _presenter.onPostFailed(e);
    } catch (e) {
      print(e);
      _presenter.onPostFailed(e);
    } finally {
      _presenter.onPostDone();
    }
  }
}

mixin Presenter {
  void onUnAuthorization();
}

abstract class CommentPresenter with Presenter {
  void onGetAllSuccess();
  void onGettingAll();
  void onGetAllFailed(Exception e);
  void onGetAllDone();

  void onPosting();
  void onPostSuccess();
  void onPostFailed(Exception e);
  void onPostDone();
}
