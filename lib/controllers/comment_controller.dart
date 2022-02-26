import 'package:flutter_firebase_blog/controllers/base_controller.dart';
import 'package:flutter_firebase_blog/models/post.dart';

import '../models/firebase.dart';

class CommentController extends BaseController{
  Future<Map<String, dynamic>> create(Map<String, dynamic> dataModel) async{
    return await FirebaseBridge.create('Comments', dataModel).then((value){
      return value;
    });
  }

  Future<Map<String, dynamic>> update() async{
    return {};
  }

  Future<Map<String, dynamic>> delete() async{
    return {};
  }

  Future<List<Post>> getPostsByUser(String uid) async{
    List<Post> posts = [];

    /*await FirebaseBridge.getPostsByUser(uid).then((value){

    });*/
    await FirebaseBridge.getPostsByUser(uid).then((value) => posts = value);

    return posts;
  }
}