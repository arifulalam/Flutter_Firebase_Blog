import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

String formattedTitle(String title) {
  var length = 30;
  if (title.length > length) {
    return title.substring(0, length) + '...';
  }
  return title;
}

String formattedDate(DateTime datetime, {format= 'd MMM yyyy h:m a'}) {
  return DateFormat(format).format(datetime).toString();
}

Future<String?> getDate(BuildContext context, {initialDate, dateFrom, dateTo, format = 'd MMM yyyy h:m a'}) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: (initialDate == null) ? DateTime.now() : initialDate,
      firstDate: (dateFrom == null) ? DateTime(DateTime.now().year - 100) : dateFrom,
      lastDate: (dateTo == null) ? DateTime.now() : dateTo
  );
  if(picked != null) return formattedDate(picked, format: 'd MMM yyyy');
  return null;
}

int randomNumber(int inBetween) {
  return Random().nextInt(inBetween);
}

String loremIpsum(int word, int paragraph) {
  return lorem(paragraphs: paragraph, words: word);
}

String avatar() {
  return 'https://i.pravatar.cc/300?img=' + randomNumber(70).toString();
}

void launchURL(String url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}

Future<Map> checkConnection({String url = ''}) async {
  bool network = false, connection = false;
  String type = 'none';

  List<String> urls = ['www.google.com', 'www.microsoft.com', 'www.amazon.com'];
  var networkResult = await (Connectivity().checkConnectivity());
  network = (networkResult == ConnectivityResult.none) ? false : true;
  type = networkResult.toString().split('.')[1];

  try {
    final response = await InternetAddress.lookup(
        (url.isEmpty) ? urls[Random().nextInt(urls.length)] : url);
    connection = response.isNotEmpty;
  } on SocketException catch (e) {
    connection = false;
  }

  return {'network': network, 'type': type, 'connection': connection};
}

Future<int> alert(BuildContext context, title, message,
    {List<Map<String, dynamic>>? buttons}) async {
  buttons ??= [
    {
      'text': 'Ok',
      'value': 1,
    }
  ];

  int result = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: buttons
            ?.map((item) => ElevatedButton(
                  onPressed: () => Navigator.pop(context, item['value']),
                  child: Text(item['text']),
                ))
            .toList(),
      );
    },
  );
  return result;
}

alertSnackBar(context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

void toast(String message,
    {Color color = Colors.white, Color backgroundColor = Colors.black}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: color,
      fontSize: 16.0);
}

mixin passwordValidationMixin {
  bool isPasswordLengthValid(String password) => password.length >= 8;

  bool isEmailValid(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }
}

void printer(String area, dynamic object){
  print('Printing $area');
  print(object);
  print('Ending $area');
}
