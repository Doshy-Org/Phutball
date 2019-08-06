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
  select,
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
class Board {
  int rowCount;
  int columnCount;
  bool inHand;
  int prevBrow;
  int prevBcol;
  List<List<int>> board;
  Board(int r, int c)
  {
    inHand = false;
    this.rowCount = r;
    this.columnCount = c;
    board = new List(rowCount);
    // prevBrow = (rowCount/2).floor();
    // prevBcol = (columnCount/2).floor();
    for(int i = 0; i < rowCount; i++)
    {
      List<int> temp = new List(columnCount);
      for(int j = 0; j < columnCount; j++)
      {
        if(i == (rowCount/2).floor() && j == (columnCount/2).floor())
          temp[j] = 2;
        else
          temp[j] = 0;
      }
      board[i] = temp;
    }
  }
  bool isDot(int r, int c)
  {
    if(board[r][c] == 1)
      return true;
    return false;
  }
  bool isBall(int r, int c)
  {
    if(board[r][c] == 2)
      return true;
    return false;
  }
  bool setDot(int r, int c)
  {
    board[r][c] = 1;
  }
  bool setBall(int r, int c)
  {
    board[r][c] = 2;
    this.inHand = false;
  }
  bool clear(int r, int c)
  {
    board[r][c] = 0;
  }
  bool getBall(int r, int c)
  {
    this.inHand = true;
    prevBrow = r;
    prevBcol = c;
  }
  bool hasBall()
  {
    return this.inHand;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  

  // List<List<BoardSquare>> board; //board xd
  static int rowCount = 19;
  static int columnCount = 15;
  Board board;

  @override
  void initState() {
    super.initState();
    _initialiseGame();
  }

  void _initialiseGame() {  //probably inits game 
    board = new Board(rowCount,columnCount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container( //top bar oponent info or whatever
            padding: const EdgeInsets.all(10.0),
          
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.face, color: Colors.orange,size: 40.0,),
                Container(width: 7),   
                Container(           
                  child: Column(
                    children: <Widget>[
                      Text("Level 5 Ai"),
                      Container(height: 2,),
                      Text("your turn", style: TextStyle(color: Colors.green)), //change according to whos turn it is
                    ],
                  ),
                ),        
              ],
            ),
          ),
           GridView.builder(
          shrinkWrap: true,

          physics: NeverScrollableScrollPhysics(),

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            childAspectRatio: 1.0,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          itemBuilder: (context, position) {
            // Get row and column number of square

            int rowNumber = (position / columnCount).floor();
            int columnNumber = (position % columnCount);
            
            Image image;
            
            if(board.isDot(rowNumber,columnNumber)){  //draw the image into each square
              image = getImage(ImageType.player);
            }
            else if(board.isBall(rowNumber,columnNumber)){  
              image = getImage(ImageType.ball);
            }
            else{
              image = getImage(null);
            }

            return InkWell(
              // draw square
                onTap: () { //glitchy and needs to be fixed //update square
                //bruh wtf is this long line
                  if(board.hasBall() && !board.isBall(rowNumber,columnNumber) && !board.isDot(rowNumber,columnNumber) && (rowNumber == board.prevBrow || columnNumber == board.prevBcol || (columnNumber-board.prevBcol).abs() == (rowNumber-board.prevBrow).abs())) //jump part 2
                  {
                    setState(() {
                      // board.setBall(rowNumber,columnNumber);
                      int a = 1,b = 1;
                      if(rowNumber < board.prevBrow)
                      {
                        a = -1;
                      }
                      if(columnNumber < board.prevBcol)
                      {
                        b = -1;
                      }
                      for(int i = board.prevBrow; i <= rowNumber; i += a) //i in range prevBrow, rowNumber
                        for(int j = board.prevBcol; j <= columnNumber; j += b) //j in range prevBcol, columnNumber
                        {
                          if(board.isDot(i,j) || board.isBall(i,j)) //black stone exists
                            board.clear(i,j);
                        }
                      board.setBall(rowNumber,columnNumber);
                    });
                  }
                  else if (!board.isBall(rowNumber,columnNumber) && !board.isDot(rowNumber,columnNumber)) //placing a new stone
                  {                 
                    setState(() {
                      board.setDot(rowNumber,columnNumber);
                    });
                  }
                  if(board.isBall(rowNumber,columnNumber)) //jumping tap one
                  {
                    setState(() {
                      board.clear(rowNumber,columnNumber);
                    });
                    board.getBall(rowNumber,columnNumber);
                  }
                },

              splashColor: Colors.lightBlueAccent,
              child: Container(
                  decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 0.5, color: Color(0xFFFFFFFFFF)),
                    left: BorderSide(width: 0.5, color: Color(0xFFFFFFFFFF)),
                    right: BorderSide(width: 0.5, color: Color(0xFFFF000000)),
                    bottom: BorderSide(width: 0.5, color: Color(0xFFFF000000)),
                  ),
                ),
                child: image,   
              ),
            );
          },
          itemCount: rowCount * columnCount,
      )
        ]
      ),
    );
  }

  Image getImage(ImageType type) {
    switch (type) {
      case ImageType.ball:
        return Image.asset('images/ball.png');
      case ImageType.player:
        return Image.asset('images/player.png');
      case ImageType.select:
        return Image.asset('images/ballSelect.png');
      default:
        return null;
    }
  }
}
// i have no clue what im doing  https://github.com/deven98/FlutterMinesweeper
