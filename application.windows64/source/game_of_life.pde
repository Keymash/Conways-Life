/*
    Any live cell with two or three live neighbours survives.
 Any dead cell with three live neighbours becomes a live cell.
 All other live cells die in the next generation. Similarly, all other dead cells stay dead.
 */

boolean[][] cells, buffer;
int cols = 25;
int rows = 25;
int cellSize = 20;
boolean paused = true;

void setup() {
  size(500, 500);
  cells = new boolean[cols][rows];
  buffer = new boolean[cols][rows];
}

void mousePressed() {
  int x = floor(mouseX/cellSize);
  int y = floor(mouseY/cellSize);
  cells[x][y] = !cells[x][y];
}

void keyPressed() {
  paused = !paused;
}

void draw() {
  color col;
  stroke(100);
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if (cells[x][y]) {
        col = color(255);
      } else {
        col = color(0);
      }
      fill(col);
      rect(x * cellSize, y * cellSize, cellSize -1, cellSize -1);
    }
  }
  if (!paused) {
    if (frameCount % 30 == 0) {
      update();
    }
  }
}

void update() {
  buffer = new boolean[cols][rows];
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      int adj = 0;
      //check N
      if (valid(x, y-1)) {
        if (cells[x][y-1]) {
          adj++;
        }
      }
      //check NE
      if (valid(x+1, y-1)) {
        if (cells[x+1][y-1]) {
          adj++;
        }
      }
      //check E
      if (valid(x+1, y)) {
        if (cells[x+1][y]) {
          adj++;
        }
      }
      //check SE
      if (valid(x+1, y+1)) {
        if (cells[x+1][y+1]) {
          adj++;
        }
      }
      //check S
      if (valid(x, y+1)) {
        if (cells[x][y+1]) {
          adj++;
        }
      }
      //check SW
      if (valid(x-1, y+1)) {
        if (cells[x-1][y+1]) {
          adj++;
        }
      }
      //check W
      if (valid(x-1, y)) {
        if (cells[x-1][y]) {
          adj++;
        }
      }
      //check NW
      if (valid(x-1, y-1)) {
        if (cells[x-1][y-1]) {
          adj++;
        }
      }
      //apply rule for live cells and store in buffer
      if (cells[x][y]) {
        if (adj == 2 || adj ==3) {
          buffer[x][y] = true;
        } else {
          buffer[x][y] = false;
        }
      } else {
        //apply rule for dead cells and store in buffer
        if (adj == 3) {
          buffer[x][y] = true;
        } else {
          buffer[x][y] = false;
        }
      }
    }
  }
  //push buffer to cells
  for (int x = 0; x < cols; x++){
    for (int y = 0; y < rows; y++){
      cells[x][y] = buffer[x][y];
    }
  }
}

boolean valid(int x, int y) {
  if (x >= 0 && x < cols && y >= 0 && y < rows) {
    return true;
  }
  return false;
}
