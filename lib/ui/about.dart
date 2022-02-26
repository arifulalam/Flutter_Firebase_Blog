import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog/helpers/constants.dart';
import 'package:flutter_firebase_blog/helpers/functions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

class About extends StatelessWidget {
  About({Key? key}) : super(key: key);

  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';

  void appInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

  @override
  Widget build(BuildContext context) {
    appInfo();
    print(appName + ' ' + packageName + ' ' + version + ' ' + buildNumber);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: constants['background_decoration'],
        width: double.infinity,
        padding: const EdgeInsets.only(top: 60),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.arrowLeft),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/colorvsblack.png'),
                radius: 70,
              ),
              const Text(
                'Ariful Alam Tuhin',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text('Designer & Developer',
                  style: TextStyle(fontSize: 18)),
              RichText(
                text: const TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                        text: 'Desktop', style: TextStyle(color: Colors.green)),
                    TextSpan(
                        text: '.',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: 'Web',
                        style: TextStyle(color: Colors.orangeAccent)),
                    TextSpan(
                        text: '.',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: 'Mobile', style: TextStyle(color: Colors.cyan)),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'PROJECT FOR',
                style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'Training for Cross Platform App Development\nby\nFLUTTER',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold),
              ),
              const Text('Batch: SD-110/L2/AV2-010/AB2-003'),
              const Text('Trainer ID: AT2-014'),
              const Text('Student ID: A2-0041'),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '.::ABOUT::.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Contact No:'),
                        TextButton(
                          onPressed: () => launchURL('tel:+8801819532885'),
                          child: const Text('+88 01819 53 2885'),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Email Address:'),
                        TextButton(
                          onPressed: () =>
                              launchURL('mailto:ariful-alam@hotmail.com'),
                          child: const Text('ariful-alam@hotmail.com'),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Github:'),
                        TextButton(
                          onPressed: () =>
                              launchURL('https://github.com/arifulalam'),
                          child: const Text('https://github.com/arifulalam'),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Web Address:'),
                        TextButton(
                          onPressed: () =>
                              launchURL('https://arifulalam.github.io'),
                          child: const Text('https://arifulalam.github.io'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
