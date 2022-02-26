import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_blog/controllers/post_controller.dart';
import 'package:flutter_firebase_blog/controllers/user_controller.dart';
import 'package:flutter_firebase_blog/models/client.dart';
import 'package:flutter_firebase_blog/models/post.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_firebase_blog/models/firebase.dart';

import 'package:flutter_firebase_blog/helpers/functions.dart';

import 'package:flutter_firebase_blog/ui/main_activity.dart';
import 'package:flutter_firebase_blog/ui/dashboard.dart';
import 'package:flutter_firebase_blog/ui/profile.dart';
import 'package:flutter_firebase_blog/ui/chat.dart';
import 'package:flutter_firebase_blog/ui/posts.dart';
import 'package:flutter_firebase_blog/ui/post.dart';

import 'about.dart';

class Screener extends StatefulWidget {
  String? activity;

  Screener({this.activity, Key? key}) : super(key: key);

  @override
  _ScreenerState createState() => _ScreenerState();
}

class _ScreenerState extends State<Screener> {
  final dynamic pages = {
    'main': {
      'appBar': false,
      'activity': MainActivity(),
      'bottomBar': false,
    },
    'profile': {
      'appBar': false,
      'title': 'Profile',
      'activity': ProfileActivity(),
      'bottomBar': false,
    },
    'dashboard': {
      'appBar': true,
      'title': 'Dashboard',
      'activity': const DashboardActivity(),
      'bottomBar': true,
    },
    'posts': {
      'appBar': true,
      'title': 'Posts',
      'activity': PostsActivity(),
      'bottomBar': true,
    },
    'post': {
      'appBar': false,
      'title': 'Post',
      'activity': PostActivity(),
      'bottomBar': true,
    },
    'about': {
      'appBar': false,
      'activity': About(),
      'bottomBar': false,
    },
    /*'chat': {
      'appBar': true,
      'title': 'Chat',
      'activity': ChatActivity(),
      'bottomBar': true,
    },*/
  };
  var screens = ['dashboard', 'posts', 'about'/*,'chat'*/] ;
  int screen = 0;

  UserController _userController = UserController();
  PostController _postController = PostController();
  Client client = Client();
  List<Post> posts = [];

  void initialize() async {
    client = await _userController.getUser();
    posts = await _postController.getPostsByUser('');
    printer('client in screener', client.client);
  }

  @override
  initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String clientName = '';
    String clientEmail = '';
    if(client.firstName != null) clientName = client.firstName!;
    if(client.lastName != null) clientName += ' ' +client.lastName!;
    if(client.emailAddress != null) clientEmail = client.emailAddress!;
    return Scaffold(
      //backgroundColor: Colors.transparent,
      drawer: Drawer(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 60),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/images/drawer.png',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 40,
                    left: 5,
                    child: SizedBox(
                      width: 300,
                      child: Row(
                        children: [
                          (client.avatar != null)
                              ? CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(client.avatar.toString()),
                                  radius: 40,
                                )
                              : const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/avatar.png'),
                                  radius: 40,
                                ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  clientName,
                                  style: const TextStyle(
                                      fontSize: 22, color: Colors.white)),
                              Text(
                                clientEmail,
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.tachometerAlt,
                    color: (screen == 0) ? Colors.cyan : Colors.blueGrey),
                title: const Text('Home'),
                onTap: () => setState(() {
                  screen = 0;
                  widget.activity = screens[0];
                  Navigator.pop(context);
                }),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.bookOpen,
                    color: (screen == 1) ? Colors.cyan : Colors.blueGrey),
                title: const Text('Posts'),
                onTap: () => setState(() {
                  screen = 1;
                  widget.activity = screens[1];
                  Navigator.pop(context);
                }),
              ),
              /*ListTile(
                  leading: FaIcon(FontAwesomeIcons.comments,
                      color: (screen == 2) ? Colors.cyan : Colors.blueGrey),
                  title: const Text('Chat'),
                  onTap: () => setState(() {
                    screen = 2;
                        widget.activity = screens[2];
                        Navigator.pop(context);
                      })),*/
              ListTile(
                  leading: FaIcon(FontAwesomeIcons.dev,
                      color: (screen == 3) ? Colors.cyan : Colors.blueGrey),
                  title: const Text('About'),
                  onTap: () => setState(() {
                    screen = 3;
                        widget.activity = screens[3];
                        Navigator.pop(context);
                      })),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.signOutAlt),
                title: const Text('Sign Out'),
                onTap: () {
                  FirebaseBridge.logout();
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
      appBar: (((widget.activity != null)
                  ? pages[widget.activity]['appBar']
                  : pages[screens[screen]]['appBar']) ==
              true)
          ? AppBar(
              //backgroundColor: Colors.transparent,
              title: const Text('_blog'),
              centerTitle: true,
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Screener(
                                          activity:
                                          'profile')));
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.account_circle),
                            Text('Profile')
                          ],
                        ),
                      )),
                      PopupMenuItem(
                          child: TextButton(
                        onPressed: () {
                          FirebaseBridge.logout();
                          SystemNavigator.pop();
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.exit_to_app),
                            Text('Sign Out')
                          ],
                        ),
                      ))
                    ];
                  },
                ),
              ],
            )
          : null,
      //extendBody: true,
      //extendBodyBehindAppBar: true,
      body: (widget.activity != null)
          ? pages[widget.activity]['activity']
          : pages[screens[screen]]['activity'],
      bottomNavigationBar: (((widget.activity != null)
                  ? pages[widget.activity]['bottomBar']
                  : pages[screens[screen]]['bottomBar']) ==
              true)
          ? BottomNavigationBar(
              currentIndex: screen,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.cyan[500],
              onTap: (index) => setState(() {
                screen = index;
                widget.activity = screens[screen];
                print(widget.activity);
                print(index);
              }),
              items: const [
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.tachometerAlt),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.bookOpen),
                  label: 'Posts',
                ),
                /*BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.comments),
                  label: 'Chat',
                ),*/
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.dev),
                  label: 'Dev',
                ),
              ],
            )
          : null,
    );
  }
}
