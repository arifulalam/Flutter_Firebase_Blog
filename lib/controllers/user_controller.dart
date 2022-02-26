import 'dart:io';

import 'package:flutter_firebase_blog/controllers/base_controller.dart';
import 'package:flutter_firebase_blog/helpers/functions.dart';
import 'package:flutter_firebase_blog/models/client.dart';
import 'package:flutter_firebase_blog/models/firebase.dart';

class UserController extends BaseController{
  Client client = Client();

  Future<void> authentication(String email, String password) async{
    await FirebaseBridge.signIn(email, password).then((value){
      printer('controller auth', value);
      if(value!.containsKey('user')){
        client = value['user'];
        value.remove('user');
      }
      setMessage(value);
    });
  }

  Future<void> register(String firstName, String lastName, String email, String password) async{
    await FirebaseBridge.signUp(firstName, lastName, email, password).then((value){
      setMessage(value);
    });
  }

  Future<void> sendActivationMail() async{
    await FirebaseBridge.activationMail().then((value){
      setMessage(value);
    });
  }

  Future<Client> getUser({String uid = ''}) async{
    return await FirebaseBridge.getUser(uid: uid);
  }

  Future<void> updateUser(Map<String, dynamic> user) async{
    await FirebaseBridge.updateUser(user).then((value) => setMessage(value));
  }
}