import 'package:angular_blog/models/user.dart';

class Comment {
  final String id;
  final String message;
  final DateTime date_add;
  final User user;

  Comment({this.id, this.message, this.date_add, this.user});

  factory Comment.fromJson(dynamic json) {
    return Comment(
      id: json['id'],
      message: json['message'],
      date_add: DateTime.parse(json['date_add']),
      user:User.fromJson(json['user'])
    );
  }
}
