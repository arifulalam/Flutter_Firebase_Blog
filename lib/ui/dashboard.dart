import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog/controllers/post_controller.dart';
import 'package:flutter_firebase_blog/controllers/user_controller.dart';
import 'package:flutter_firebase_blog/helpers/constants.dart';
import 'package:flutter_firebase_blog/helpers/functions.dart';
import 'package:flutter_firebase_blog/ui/screener.dart';

class DashboardActivity extends StatefulWidget {
  const DashboardActivity({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardActivityState();
}

class _DashboardActivityState extends State<DashboardActivity> {
  UserController userController = UserController();
  PostController postController = PostController();

  @override
  Widget build(BuildContext context) {
    postController.getPostsByUser('');
    return SafeArea(
        child: Container(
          decoration: constants['background_decoration'],
          padding: const EdgeInsets.only(top: 90),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Screener(activity: 'posts')));
                  },
                  child: const Text('Posts'),
                ),
              ],
            ),
          ),
        ));
  }
}
