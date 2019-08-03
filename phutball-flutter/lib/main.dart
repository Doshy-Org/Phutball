import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

enum ImageType{
  player,
  ball,
  grid,
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class BoardSquare { // each square is this
  bool isDot; //player
  bool isBall;
}

class _MyHomePageState extends State<MyHomePage> {
  int rowCount = 19;
  int columnCount = 15;
  List<List<BoardSquare>> board; //board xd

  void _incrementCounter() { //idk remove this
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    _initialiseGame();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phutball"),
      ),
      body: //this is just to see that grid works lol
        GridView.builder( //replace this it is gay
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columnCount,),

        itemBuilder: (_, index) => getImage(ImageType.grid),
          itemCount: rowCount*columnCount,
        )
    );
  }

   void _initialiseGame() { 
    board = List.generate(rowCount, (i) {
      return List.generate(columnCount, (j) {
        return BoardSquare();
      });
    });
  }

  Image getImage(ImageType type) {
    switch (type) {
      case ImageType.ball:
        return Image.asset('images/ball.png');
      case ImageType.player:
        return Image.asset('images/player.png');
      case ImageType.grid:
        return Image.asset('images/grid.png');
      default:
        return null;
    }
  }
}
// i have no clue what im doing  https://github.com/deven98/FlutterMinesweeper
