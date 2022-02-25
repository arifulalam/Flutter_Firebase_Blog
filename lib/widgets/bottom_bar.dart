import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog/ui/about.dart';
import 'package:flutter_firebase_blog/ui/chat.dart';
import 'package:flutter_firebase_blog/ui/dashboard.dart';
import 'package:flutter_firebase_blog/ui/posts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget bottomBar(BuildContext context) {
  var selected = 1;
  return StatefulBuilder(builder: (context, newState){
    return BottomNavigationBar(
      currentIndex: selected,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.cyan[500],
      onTap: (index) {
        newState((){
          selected = index;
        });
        switch (index) {
          /*case 0:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DashboardActivity()));
            break;*/
          case 1:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PostsActivity()));
            break;
          case 2:
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChatActivity()));
            break;
          case 3:
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => About()));
            break;
          default:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DashboardActivity()));
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.tachometerAlt),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.bookOpen),
          label: 'Posts',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.comments),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.dev),
          label: 'Dev',
        ),
      ],
    );
  });

}
