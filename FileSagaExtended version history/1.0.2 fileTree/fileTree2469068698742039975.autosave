int gridSize=40;//size in pixels of a grid square
color bgColor=#000000, lineColor=#FFFFFF;
PImage cursorImage;
int mX=0, mY=0;//mouse coordinates on the grid

Player p;//initialise player object

void settings(){
	size(800,800,P2D);//size of the window
}

void setup(){
	while(!focused){}//wait until the player clisks in the window
	cursorImage = loadImage("cursor.png");//sets the cursor imagesize
	cursor(cursorImage);//
}

void drawBg(){//draws the background grid
  fill(bgColor); stroke(lineColor);
  for(int i=0; i<width/gridSize; i++){
	  for(int j=0; j<height/gridSize; j++){
		  rect(i*gridSize, j*gridSize, gridSize, gridSize);
	  }
  }
}

void draw(){
	drawBg();
	p.display();
}

class Player{
  int x=12, y=12, speed=4, attack=2;
  color Color = #A0F020;
  int gridSize=40;

  void display(){
    fill(Color); stroke(#FFFFFF);
    rect(gridSize*x, gridSize*y, gridSize, gridSize);
  }
  
  void move(){
    fill(#555555); stroke(#FFFFFF);
    for(int i=1; i<=speed; i++){
      rect((x+i)*gridSize, y*gridSize, gridSize, gridSize);
      rect(x*gridSize, (y+i)*gridSize, gridSize, gridSize);
      rect((x-i)*gridSize, y*gridSize, gridSize, gridSize);
      rect(x*gridSize, (y-i)*gridSize, gridSize, gridSize);
    }
  }
}