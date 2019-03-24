// @JS()
// library materialize;
// import 'package:js/js.dart';

import 'dart:async';
import 'package:angular_blog/services/http_service.dart';
import 'package:angular_blog/models/posts.dart';
import './js_service.dart';
import 'package:rxdart/rxdart.dart';

// @JS("materialize")
// external dynamic M();

class BlogService {
  static final url = 'posts/'; // URL to web API
  final JSService _js;
  final HttpService _http;
  Map<String, Post> _postMap = {};

  final BehaviorSubject<Map<String, Post>> _posts;

  BlogService(this._http, this._js)
      : _posts = new BehaviorSubject<Map<String, Post>>();

  //Map<String, Post> get posts => _postMap;
  Sink get postsController => _posts.sink;
  Stream get posts => _posts.stream;

  Future<void> getAll() async {
    try {
      final List<dynamic> data =
          await _http.send(url: url, method: HTTP_METHOD.GET);
      final List<Post> postList =
          data.map((dynamic record) => Post.fromJson(record));

      _postMap =
          new Map.fromIterable(postList, key: (p) => p.id, value: (p) => p);

      postsController.add(_postMap);
      _js.toast("Successfully loaded");
    } catch (e) {
      rethrow;
    }
  }

  Post get(String id) {
    if (_postMap.isEmpty) return null;
    return _postMap[id];
  }
}
