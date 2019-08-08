import 'package:phutball/board.dart';
import 'package:flutter/material.dart';
import 'dart:math';

enum ImageType{
  player,
  ball,
  select,
  redend,
  blueend,
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List<List<BoardSquare>> board; //board xd
  static int rowCount = 19;
  static int columnCount = 15;
  Board board;
  bool turn;

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
              else if(board.isBall(rowNumber,columnNumber) &&  board.inHand == true ){  //ball selected
                image = getImage(ImageType.select);
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
                   /* if(board.hasBall() && !board.isBall(rowNumber,columnNumber) && !board.isDot(rowNumber,columnNumber) && (rowNumber == board.prevBrow || columnNumber == board.prevBcol || (columnNumber-board.prevBcol).abs() == (rowNumber-board.prevBrow).abs())) //jump part 2
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
                    }*/
                    
                    if(board.isBall(rowNumber,columnNumber) && board.inHand == false){ //select ball
                      print("select");
                      setState(() {
                        board.inHand = true;
                         board.prevBcol = columnNumber;
                        board.prevBrow = rowNumber;
                      });
                    }

                    else if(board.inHand == true){ //select ball  
                      if(board.isBall(rowNumber,columnNumber) || board.isDot(rowNumber, columnNumber)){
                        setState(() {
                          board.inHand = false;
                        });
                      }
                      else{
                        bool valid = true;
                        int a = 1,b = 1;
                          if(rowNumber < board.prevBrow)
                          {
                            a = -1;
                          }
                          if(columnNumber < board.prevBcol)
                          {
                            b = -1;
                          }
                          for(int i = board.prevBrow; i <= rowNumber; i += a){ //i in range prevBrow, rowNumber
                            for(int j = board.prevBcol; j <= columnNumber; j += b){ //j in range prevBcol, columnNumber
                              if(!board.isDot(i,j)){
                                valid = false;
                                print(valid);      
                              } //black stone exists  
                            }
                          }
                          print("ree");
                          print(valid);
                          if(valid){
                            print ("truuu");
                            setState(() {
                              for(int i = board.prevBrow; i <= rowNumber; i += a){ //i in range prevBrow, rowNumber
                                for(int j = board.prevBcol; j <= columnNumber; j += b){ //j in range prevBcol, columnNumber
                                  if(!board.isDot(i,j) || !board.isBall(i,j)){
                                    board.clear(i,j);      
                                  }  //black stone exists  
                                }
                              }
                                board.setBall(rowNumber,columnNumber);
                                board.inHand = false;
                                board.clear(rowNumber,columnNumber);
                               
                            });
                        } 
                        else{
                          setState(() {
                            board.inHand = false;
                          });
                        }     
                      }  
                    }     
                   /* else if(){ //if ball selected and valid move , move ball selected  = false
                      setState(){
                        //move ball
                        board.isHand = false;
                      }*/
                    else{
                      setState(() {
                        board.setDot(rowNumber,columnNumber);
                      });
                    }
                  },

                splashColor: Colors.lightBlueAccent,
                child: Container(     
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('images/grid.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: image,   //ball png or whatever
                ),
              );
            },
            itemCount: rowCount * columnCount,
         ),
          Container( //bottom bar oponent info or whatever
            padding: const EdgeInsets.all(10.0),
          
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new RaisedButton(
                  child: const Text('End Turn'),
                  color: Theme.of(context).accentColor,
                  elevation: 4.0,
                  splashColor: Colors.white,
                  onPressed: () {
                    // end turn
                  },
                ),      
              ],
            ),
          ),
        ]
      ),
    );
  }

  //images list
  Image getImage(ImageType type) {
    switch (type) {
      case ImageType.ball:
        return Image.asset('images/ball.png');
      case ImageType.player:
        return Image.asset('images/player.png');
      case ImageType.select:
        return Image.asset('images/ballSelect.png');
      case ImageType.redend:
        return Image.asset('images/red.png');
      case ImageType.blueend:
        return Image.asset('images/blue.png');
      default:
        return null;
    }
  }
}
// i have no clue what im doing  https://github.com/deven98/FlutterMinesweeper
