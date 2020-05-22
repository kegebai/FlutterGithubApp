import 'package:flutter/material.dart';

class IpCons {
  static const String apiHost = "https://api.github.com/";
  static const String webHost = "https://github.com/";

  static const String graphqlHost = 'https://api.github.com/graphql';
  static const String graphicHost = 'https://ghchart.rshah.org/';

  static const String updateUrl = 'https://www.pgyer.com/guqa';
}

class Cons {
  static Locale curLocale;

  static const String themeColorIndex = 'theme_color_index';
  static const String fontFamilyIndex = 'font_family_index';
  static const String languageIndex   = 'language_index';

  static const fontFamilySupport = <String>[
    'local',
    'ComicNeue',
    'IndieFlower',
    'BalooBhai2',
    'Inconsolata',
    'Neucha',
  ];

  static final themeColorSupport = <MaterialColor, String>{
    Colors.purple:   '高贵紫',
    Colors.pink:     '典雅红',
    Colors.yellow:   '亘古黄',
    Colors.cyan:     '水之蓝',
    Colors.blue:     '天之蓝',
    Colors.teal:     '水鸭蓝',
    Colors.indigo:   '烟雨青',
    Colors.blueGrey: '神秘灰',
  };

  static const languageSupport = <String>[
    'zh-CN',
    'en-US',
  ];
}

class TimeCons {
  static final double millis = 1000.0;
  static final double seconds = 60 * millis;
  static final double minutes = 60 * seconds;
  static final double hours = 24 * minutes;
  static final double days = 30 * hours;
}
