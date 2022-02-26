import 'package:flutter_firebase_blog/models/client.dart';

class Comment {
  String? id;
  String? postId;
  String? comment;
  String? userId;
  DateTime? createdOn;
  Client? client;

  Comment(
      {this.id,
      this.postId,
      this.comment,
      this.userId,
      this.createdOn,
      this.client});

  Map<String, dynamic> get dataModel{
    return {
      'id': id,
      'postId': postId,
      'userId': userId,
      'comment': comment,
      'createdOn': createdOn,
    };
  }
}
