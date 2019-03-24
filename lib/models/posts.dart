import './user.dart';

class Post {
  final String id;
  final String title;
  final String body;
  final User author;
  final List<String> comments;

  Post({this.id, this.title, this.body, this.author, this.comments});

  factory Post.fromJson(dynamic json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      author: User.fromJson(json['author']),
      //comments: json['comments'].map((id) => id.toString()),
      comments: ['123','321'],
    );
  }
}
