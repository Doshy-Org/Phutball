class Board {
  int rowCount;
  int columnCount;
  bool inHand;
  int prevBrow;
  int prevBcol;
  List<List<int>> board;
  // if the ball is in hand

  Board(int r, int c)
  {
    inHand = false;
    this.rowCount = r;
    this.columnCount = c;
    board = new List(rowCount);
    prevBrow = (rowCount/2).floor();
    prevBcol = (columnCount/2).floor();
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
    prevBrow = r;
    prevBcol = c;
  }
  bool hasBall()
  {
    return this.inHand;
  }

  bool endzone(){
    return rowCount == 0; // add other row soon
  }
}