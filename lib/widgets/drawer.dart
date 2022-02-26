import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_blog/ui/screener.dart';

import '../models/firebase.dart';

Widget DrawerMenu(BuildContext context) {
  return Container(
    width: double.infinity,
    //padding: EdgeInsets.all(10),
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
                    /*(FirebaseBridge.client['avatar'] != null)
                        ? CircleAvatar(
                      backgroundImage:
                      NetworkImage(FirebaseBridge.client['avatar'].toString()),
                      radius: 40,
                    )
                        : const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                      radius: 40,
                    ),*/
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        /*Text(FirebaseBridge.client!['firstName'] +
                            ' ' +
                            FirebaseBridge.client!['lastName'],
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white)),
                        Text(
                          FirebaseBridge.client!['emailAddress'],
                          style: const TextStyle(color: Colors.white),
                        )*/
                        SizedBox(),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Posts'),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Screener(activity: 'posts')));
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('About'),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Screener(activity: 'about'))),
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Sign Out'),
          onTap: (){
            FirebaseBridge.logout();
            SystemNavigator.pop();
          },
        ),
      ],
    ),
  );
}
