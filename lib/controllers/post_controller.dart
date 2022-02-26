import 'package:flutter_firebase_blog/controllers/base_controller.dart';
import 'package:flutter_firebase_blog/helpers/functions.dart';
import 'package:flutter_firebase_blog/models/post.dart';

import '../models/firebase.dart';

class PostController extends BaseController{
  Post post = Post();

  Future<Map<String, dynamic>> create(Map<String, dynamic> dataModel) async{
    return await FirebaseBridge.create('Posts', dataModel).then((value){
      return value;
    });
  }

  Future<void> update() async{

  }

  Future<void> delete() async{

  }

  Future<List<Post>> getPostsByUser(String uid) async{
    List<Post> posts = [];

    /*await FirebaseBridge.getPostsByUser(uid).then((value){

    });*/
    await FirebaseBridge.getPostsByUser(uid).then((value) => posts = value);

    return posts;
  }
}