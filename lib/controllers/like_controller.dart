import 'package:flutter_firebase_blog/controllers/base_controller.dart';
import 'package:flutter_firebase_blog/models/post.dart';

import '../models/firebase.dart';

class LikeController extends BaseController{
  Future<Map<String, dynamic>> create(Map<String, dynamic> dataModel) async{
    return await FirebaseBridge.create('Likes', dataModel).then((value){
      return value;
    });
  }

  Future<Map<String, dynamic>> delete(String likeId) async{
    return await FirebaseBridge.delete('Likes', likeId).then((value){
      if(value == true){
        return {'status': true, 'code': 200, 'message': 'Like removed'};
      }else{
        return {'status': false, 'code': 301, 'message': 'Something went wrong. Try again!'};
      }
    });
  }
}