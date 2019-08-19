class Player {
  int score;
  bool playerTurn;
  bool jumped;
  bool placed;
  bool canMove;
  String name;

  Player(String n)
  {
    playerTurn = false; //defaults to false, randomized first player
    jumped = false;
    placed = false;
    canMove = true;
    name = n;
    score = 0;
  }
  void startMove()
  {
    playerTurn = true;
  }
  void endMove()
  {
    playerTurn = false;
    jumped = false;
    placed = false;
    canMove = true;
  }
  bool onTurn()
  {
    return playerTurn;
  }
  bool canMakeMove()
  {
    return canMove;
  }
  bool hasJumped()
  {
    return jumped;
  }
  bool hasPlaced()
  {
    return placed;
  }
  void makeJump()
  {
    jumped = true;
  }
  void makePlacement()
  {
    placed = true;
    canMove = false;
  }
  void noMoreMoves()
  {
    canMove = false;
  }
  void reset()
  {
    jumped = false;
    placed = false;
    canMove = true;
  }
  void win()
  {
    score++;
  }
  
  void setPlayer (Player b){
      //idk what this is :cold_sweat:
  } 
}