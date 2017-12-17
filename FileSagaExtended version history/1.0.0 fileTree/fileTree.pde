int gridSize=40;//size in pixels of a grid square
color bgColor=#000000, lineColor=#FFFFFF;
PImage cursorImage, UIimage;
int mX=0, mY=0;//mouse coordinates on the grid
PFont myFont;
Player p;//initialise player object

void setup(){
	size(801,901,P2D);//size of the window
	myFont = createFont("pcsenior.ttf", 8);
	textFont(myFont);
	textAlign(CENTER, BOTTOM);
	p = new Player();
	p.begin("doc");
	while(!focused){}//wait until the player clisks in the window
	UIimage = loadImage("action bar.png");
	cursorImage = loadImage("cursor.png");//sets the cursor imagesize
	cursor(cursorImage);//
}

void drawBg(){//draws the background grid
  fill(bgColor); stroke(lineColor);
  for(int i=0; i<width/gridSize; i++){
	  for(int j=0; j<width/gridSize; j++){
		  rect(i*gridSize, j*gridSize, gridSize, gridSize);
	  }
  }
}

void draw(){
	drawBg();
	p.display();
	image(UIimage, 0, 801);
	fill(0);
	text("Ramen healed XxBeanBagChairxX",669 ,890);
}