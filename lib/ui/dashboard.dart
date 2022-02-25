import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog/helpers/functions.dart';
import 'package:flutter_firebase_blog/ui/posts.dart';
import 'package:flutter_firebase_blog/widgets/drawer.dart';

class DashboardActivity extends StatefulWidget {
  final String? uid;
  const DashboardActivity({Key? key, this.uid}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardActivityState();
}

class _DashboardActivityState extends State<DashboardActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: DrawerMenu(context),
        ),
        appBar: AppBar(
          title: const Text('_blog Posts'),
          centerTitle: true,
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      child: TextButton(
                    onPressed: () {},
                    child: Row(
                      children: const [
                        Icon(Icons.account_circle),
                        Text('Profile')
                      ],
                    ),
                  )),
                  PopupMenuItem(
                      child: TextButton(
                    onPressed: () {},
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
        ),
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(Avatar()),
                radius: 80,
              ),
              Text(
                LoremLipsum(2, 1),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Text('you@domain.com'),
              Text('+8801819532885'),
              Text('Joined on: 01 January, 2022'),
              Hero(
                tag: 'HeroPost',

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostsActivity()));
                  },
                  child: Text('Posts'),
                ),
              )
            ],
          ),
        )));
  }
}
