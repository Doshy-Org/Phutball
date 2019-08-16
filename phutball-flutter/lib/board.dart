import 'dart:math';

class Board {
  int rowCount;
  int columnCount;
  bool inHand;
  int prevBrow;
  int prevBcol;
  List<List<int>> board;
  List<List<int>> temp;
  int dx,dy;
  int distance;

  int moved; // if you have moved you can end turn or undo, cannot click more
  bool playerTurn;

  Board(int r, int c)
  {
    inHand = false;
    rowCount = r;
    columnCount = c;
    board = new List(rowCount);
    temp = new List(rowCount);
    // board = new List<List<int>>.filled(rowCount, new List<int>(columnCount), growable: false); //big brain code
    prevBrow = (rowCount/2).floor();
    prevBcol = (columnCount/2).floor();
    // board[prevBrow][prevBcol] = 2;
    for(int i = 0; i < rowCount; i++)
    {
      List<int> temp = new List(columnCount);
      for(int j = 0; j < columnCount; j++)
      {
        if(i == prevBrow && j == prevBcol)
          temp[j] = 2;
        else
          temp[j] = 0;
      }
      board[i] = temp;
    }
  }
  bool isDot(int r, int c)
  {
    return board[r][c] == 1;
  }
  bool isBall(int r, int c)
  {
    return board[r][c] == 2;
  }
  void setDot(int r, int c)
  {
    board[r][c] = 1;
  }
  void setBall(int r, int c)
  {
    board[r][c] = 2;
    this.inHand = false;
  }
  void clear(int r, int c)
  {
    board[r][c] = 0;
  }
  void getBall(int r, int c)
  {
    this.inHand = true;
    this.prevBrow = r;
    this.prevBcol = c;
  }
  void dropBall()
  {
    this.inHand = false;
  }
  bool hasBall()
  {
    return this.inHand;
  }
  void initJump(int rowNumber, int columnNumber)
  {
    dx = 0; dy = 0; //resets
    if(rowNumber < this.prevBrow) //my brain cells r gone
    {
      dy = -1;  //changing rows goes up and down so y 
      //print("y: -1");
    }
    if(rowNumber > this.prevBrow)
    {
      //print("y: 1");
      dy = 1;
    }
    if(columnNumber < this.prevBcol)
    {
      //print("x: 1 (down is pos)");
      dx = -1;
    }
    if(columnNumber > this.prevBcol)
    {
      //print("x: 1");
      dx = 1;
    }

    int a = this.prevBcol- columnNumber; //finding distance needed to get from ball to click location
    int b = this.prevBrow-rowNumber;
    //print("a: $a b: $b");
    distance  = max(a.abs(), b.abs());
   // print("distance $distance");
  }

  bool checkJump(int rowNumber, int columnNumber)
  {
      if(distance == 1){//distance = 1 means user clicked space next to ball
        return false;
      }
      bool valid = true;//check if location is a valid move
    // int dx = 0,dy = 0; //distance to move x/y each time   // REMEBER THAT 0,0 IS TOP LEFT CORNER
      int x = this.prevBcol; //this hurts brain
      int y = this.prevBrow; //x changes when col++
      
      for(int i = 0; i < distance ; i++){
        x+=dx;
        y+=dy;
        //print(distance);
        //print(i);
        if(i == distance-1){   
          if(y != rowNumber ||  x != columnNumber){
            valid = false;
          }
          break;
        }
        else if(!this.isDot(y, x)){ // REEEEEEEEEEe idk why its y x but works
          valid = false;
          break;
        }
      }
      //print(valid);
    return valid;
  }
  void jump(int rowNumber, int columnNumber)
  {
    int x = this.prevBcol; //reset x and y || alternate could save locations into a matrix
    int y = this.prevBrow; 
    for(int i = 0; i < distance-1 ; i++){ // matrix would prob be slower / same
      x+=dx;
      y+=dy;
      this.clear(y, x);      
    }
    this.clear(this.prevBrow, this.prevBcol);
    this.setBall(rowNumber,columnNumber);
  }

  void saveState()
  {
    for(int i = 0; i < rowCount; i++)
    {
      List<int> tempree = new List(columnCount);
      for(int j = 0; j < columnCount; j++)
      {
        tempree[j] = board[i][j];
      }
      temp[i] = tempree;
    }
  }
  void loadState()
  {
    for(int i = 0; i < rowCount; i++)
    {
      List<int> tempree = new List(columnCount);
      for(int j = 0; j < columnCount; j++)
      {
        tempree[j] = temp[i][j];
      }
      board[i] = tempree;
    }
  }

  bool endzone(){  //idk what this is rn
    return rowCount == 0 || rowCount == 18; // add other row soon
  }

  void endGame()
  {
    print("ree");
  }

  void setBoard (Board b){
      //will this work
  } 
}