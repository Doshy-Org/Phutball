/*
todo
array to erase dots
end game condition
indicate endzones
*/

import 'package:flutter/material.dart';
import 'package:phutball/menu.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromRGBO(250, 250, 250, 1), // navigation bar color
      statusBarColor: Color.fromRGBO(250, 250, 250, 1), // status bar color
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
      ),
      home: MenuScreen(),
    );
  }
}

