import 'package:flutter/material.dart';

dynamic constants = {
  'colors': {
    'primary': '',
    'secondary': '',
  },
  'images': {
    'base_path': 'assets/images/',
    'avatar': 'avatar.png',
    'logo': 'blog.png',
    'cover': {
      'landscape': 'landscape.png',
      'portrait': 'portrait.png',
    }
  },
  'background_decoration': const BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          alignment: Alignment.topCenter,
          fit: BoxFit.fitHeight)),
  'fonts': [
    {
      'name': 'Luxurious Roman',
      'style': {
        'regular': 'LuxuriousRoman-Regular.ttf',
      }
    }
  ],
};
