import 'dart:async';

import 'package:alan/blocs/theme_bloc.dart';
import 'package:flutter/material.dart';

import 'router.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  ThemeData themeData = blocTheme.themeData;
  late StreamSubscription themeStream;

  @override
  void initState() {
    super.initState();
    themeStream = blocTheme.themeDataStream.listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    themeStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voice Demo',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      // home: const MyHomePage(),
      initialRoute: AppRoutes.getSplash,
      routes: AppRoutes.routes,
    );
  }
}
