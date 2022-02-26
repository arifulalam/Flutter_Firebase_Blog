import 'package:flutter_firebase_blog/models/comment.dart';
import 'package:flutter_firebase_blog/models/client.dart';
import 'package:flutter_firebase_blog/models/like.dart';

class Post {
  String? id;
  String? title;
  String? content;
  String? userId;
  String? cover;
  int views = 0;
  DateTime? createdOn;
  bool isPublished = false;
  DateTime? updatedOn;
  List<Comment>? comments;
  List<Like>? likes;
  Client? client;

  Post(
      {this.id,
      this.title,
      this.content,
      this.userId,
      this.cover,
      this.views = 0,
      this.createdOn,
      this.isPublished = false,
      this.updatedOn,
      this.comments,
      this.likes,
      this.client});

  Map<String, dynamic> get post {
    return {
      'id': id,
      'title': title,
      'content': content,
      'userId': userId,
      'cover': cover,
      'views': views,
      'createdOn': createdOn,
      'isPublished': isPublished,
      'updatedOn': updatedOn,
      'comments': comments,
      'likes': likes,
      'client': client,
    };
  }

  Map<String, dynamic> get dataModel{
    return {
      'id': id,
      'title': title,
      'content': content,
      'cover': cover,
      'isPublished': isPublished,
      'views': views,
      'userId': userId,
      'createdOn': createdOn,
      'updatedOn': updatedOn,
    };
  }
}
