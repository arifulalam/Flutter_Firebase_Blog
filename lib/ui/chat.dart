import 'package:flutter/material.dart';

class ChatActivity extends StatefulWidget {
  const ChatActivity({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatActivityState();
}

class _ChatActivityState extends State<ChatActivity> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('CHAT'),
        ),
      ),
    );
  }
}
