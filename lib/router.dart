import 'package:flutter/material.dart';

import 'blocs/voice_bloc.dart';
import 'pages/help_page.dart';
import 'pages/home_page.dart';

class AppRoutes {
  static String get getSplash => home;

  static String get currentScreen => _currentScreen;
  static const home = '/';
  static late BuildContext _context;
  static RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const MyHomePage(),
    '/help': (context) => const HelpPage(),
  };
  static String _currentScreen = '/';

  setBuildContext(BuildContext context) {
    _context = context;
  }

  static routeTo(String key) {
    _currentScreen = key;
    if (key[0] != '/') {
      key = '/$key';
    }
    _currentScreen = key;
    voiceBloc.setVisuals(key);
    if (routes.containsKey(key)) {
      Navigator.pushNamed(_context, key);
    } else {
      Navigator.pushNamed(_context, getSplash);
    }
  }

  static goBack() {
    if (Navigator.canPop(_context)) {
      Navigator.pop(_context);
      voiceBloc.setVisuals(Navigator.defaultRouteName);
    }
  }

  static void setContext(BuildContext context) {
    _context = context;
  }

  static void addRoute(String key, Widget widget) {
    routes['/$key'] = (context) => widget;
  }
}
