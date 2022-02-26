import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog/models/firebase.dart';

class BaseController with ChangeNotifier{
  Map<String, dynamic>? _message;
  bool _isLoading = false;

  Map<String, dynamic>? get message => _message;
  bool get isLoading => _isLoading;

  setMessage(Map<String, dynamic>? message) {
    _message = message;
    notifyListeners();
  }

  setIsLoading(bool isLoading){
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<String?> uploadFile(
      {required File? file, required String directory, uid}){
    return FirebaseBridge.uploadFile(file: file, uid: uid, directory: directory);
  }
}