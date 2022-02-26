class Like {
  String? id;
  String? postId;
  String? userId;

  Like({this.id, this.userId, this.postId});

  Map<String, dynamic> get dataModel{
    return{
      'id': id,
      'postId': postId,
      'userId': userId,
    };
  }
}
