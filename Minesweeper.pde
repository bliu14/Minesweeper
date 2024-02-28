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

class Box {
  boolean bomb;
  boolean reveal;
  int bombNum, col, row;
  boolean flag;
  public Box(int row, int col) {
    this.row = row;
    this.col = col;
    int dice = (int)random(1, 10);
    if (dice == 1) {
      bomb = true;
    }
  }
  public void show() {
    if (reveal == true) {
      fill(255);
      square(col*20, row*20, 20);
      fill(0);
      text(bombNum, col*20, row*20+10);
      if (bomb == true) {
        fill(255, 0, 0);
        square(col*20, row*20, 20);
      }
    } else {
      fill(100, 100, 100);
      square(col*20, row*20, 20);
    }
    if (flag == true) {
      fill(0, 225, 0);
      text('F', col*20, row*20+10);
    }
  }
  public void reveal() {
    if (reveal == true) {
      return;
    }
    reveal = true;
    if (bombNum == 0) {
      if (row != grid.grid.length -1 && col != grid.grid[0].length -1) {
        grid.grid[row+1][col+1].reveal();
      }
      if (row != 0 && col != 0) {
        grid.grid[row-1][col-1].reveal();
      }
      if (row != grid.grid.length-1) {
        grid.grid[row+1][col].reveal();
      }
      if (row != 0) {
        grid.grid[row-1][col].reveal();
      }
      if (col != grid.grid[0].length-1) {
        grid.grid[row][col+1].reveal();
      }
      if (col != 0) {
        grid.grid[row][col-1].reveal();
      }
      if (row != grid.grid.length-1 && col != 0) {
        grid.grid[row+1][col-1].reveal();
      }
      if (row != 0 && col != grid.grid[0].length-1) {
        grid.grid[row-1][col+1].reveal();
      }
    }
  }
  boolean mouseOver() {
    if (mouseX > col*20 && mouseX < col*20+20 && mouseY > row*20 && mouseY < row*20+20) {
      return true;
    }
    return false;
  }
  void click() {
    if (mouseOver() == true && mousePressed == true) {
      if (mouseButton == LEFT) {
        reveal();
        if(bomb == true) {
          playGame = false;
        }
      } else if (mouseButton == RIGHT) {
        flag = true;
      }
    }
  }
}

class Grid {
  int bombCount = 0;
  Box[][] grid;
  public Grid() {
    grid = new Box[40][40];
    for (int row = 0; row < grid.length; row++) {
      for (int col = 0; col < grid[row].length; col++) {
        grid[row][col] = new Box(row, col);
        if(grid[row][col].bomb == true) {
          bombCount += 1;
        }
      }
    }
    calcNum();
  }
  public void show() {
    for (int row = 0; row < grid.length; row++) {
      for (int col = 0; col < grid[row].length; col++) {
        grid[row][col].show();
        grid[row][col].click();
      }
    }
  }
  public boolean checkWin() {
    int holder = 0;
    for (int row = 0; row < grid.length; row++) {
      for (int col = 0; col < grid[row].length; col++) {
        if(grid[row][col].bomb == false && grid[row][col].reveal == true) {
          holder += 1;
        }
      }
    }
    if(holder == 1600-bombCount) {
      return true;
    }
    return false;
  }
  public void calcNum() {
    for (int row = 0; row < grid.length; row++) {
      for (int col = 0; col < grid[row].length; col++) {
        int count = 0;
        if (row != grid.length -1 && col != grid[0].length -1 && grid[row+1][col+1].bomb == true) {
          count += 1;
        }
        if (row != 0 && col != 0 && grid[row-1][col-1].bomb == true) {
          count += 1;
        }
        if (row != grid.length-1 && grid[row+1][col].bomb == true ) {
          count += 1;
        }
        if (row != 0 && grid[row-1][col].bomb == true) {
          count += 1;
        }
        if (col != grid[0].length-1 && grid[row][col+1].bomb == true) {
          count += 1;
        }
        if (col != 0 && grid[row][col-1].bomb == true) {
          count += 1;
        }
        if (row != grid.length-1 && col != 0 && grid[row+1][col-1].bomb == true ) {
          count += 1;
        }
        if (row != 0 && col != grid[0].length-1 && grid[row-1][col+1].bomb == true) {
          count += 1;
        }
        grid[row][col].bombNum = count;
      }
    }
  }
}
