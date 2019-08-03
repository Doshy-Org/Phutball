import 'dart:math';

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
  BoardSquare({this.isDot = false, this.isBall = false});
}

class _MyHomePageState extends State<MyHomePage> {
  int rowCount = 19;
  int columnCount = 15;

  List<List<BoardSquare>> board; //board xd

  @override
  void initState() {
    super.initState();
    _initialiseGame();
  }

   void _initialiseGame() { 
    board = List.generate(rowCount, (i) {
      return List.generate(columnCount, (j) {
        return BoardSquare();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phutball"),
      ),
      body: 
          GridView.builder(
            shrinkWrap: true,

            physics: NeverScrollableScrollPhysics(),

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnCount,
            ),

            itemBuilder: (context, position) {
              // Get row and column number of square
              int rowNumber = (position / columnCount).floor();
              int columnNumber = (position % columnCount);

              Image image;
              if(board[rowNumber][columnNumber].isBall == null){ // idk for some reason they are null on init
                board[rowNumber][columnNumber].isBall = false;
                board[rowNumber][columnNumber].isDot = false;
              }

              if(board[rowNumber][columnNumber].isDot == true){  //these lines r giving error- Another exception was thrown: Failed assertion: boolean expression must not be null
                image = getImage(ImageType.player);
              }
              if(board[rowNumber][columnNumber].isBall == true{  
                image = getImage(ImageType.ball);
              }
              else{
                image = getImage(null);
              }

              return InkWell(
                // drawing square
                  onTap: () { // i hope this works but no idea 
                    if (board[rowNumber][columnNumber].isBall == false &&board[rowNumber][columnNumber].isDot == false) {                 
                      setState(() {
                        board[rowNumber][columnNumber].isBall = true;
                      });
                    }
                  },


                splashColor: Colors.lightBlueAccent,
                child: Container(
                   decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                      left: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                      right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                      bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                   ),
                  ),
                  child: image,
                  
                ),
              );
            },
            itemCount: rowCount * columnCount,
        )
    );
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
