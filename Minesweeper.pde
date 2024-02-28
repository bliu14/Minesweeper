Grid grid;
boolean playGame = true;
void setup() {
  size(500, 500);
  grid = new Grid();
}
void draw() {
  grid.show();
  if (grid.checkWin() == true) {
    textSize(64);
    fill(0,225,0);
    text("You Win!!", 200, 200);
    noLoop();
  }
  if (playGame == false) {
    textSize(64);
    fill(225,0,0);
    text("You Lose!!!", 200, 200);
    noLoop();
  }
}
