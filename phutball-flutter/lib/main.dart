/*
todo
array to erase dots
end game condition
indicate endzones
*/

import 'package:phutball/game.dart';
import 'package:flutter/material.dart';
import 'package:phutball/menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
      ),
      home: MenuScreen(),
    );
  }
}

