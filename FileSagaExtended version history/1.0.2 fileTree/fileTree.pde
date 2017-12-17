int gridSize=40;//size in pixels of a grid square
color bgColor=#000000, lineColor=#FFFFFF;
PImage cursorImage, UIimage;
int mX=0, mY=0;//mouse coordinates on the grid
PFont myFont;

int currentPlayersInGame=0, maxPlayersConnected=6, currentEnemiesInGame=0;
Player[] player = new Player[maxPlayersConnected];//initialise player object array with max number of players
Enemy[] enemy = new Enemy[4];//FIX THIS

public Console console;

TurnManager tm;

GridButton[][] gb = new GridButton[25][15];

void setup(){
	size(1001, 751,P2D);//size of the window
	cursorImage = loadImage("cursor.png");//sets the cursor image
	//cursor(cursorImage);
	while(!focused){}//waits until the player clisks in the window
	myFont = createFont("pcsenior.ttf", 8);//sets the font
	textFont(myFont);
	
	
	
	for(int i=0; i<25; i++){
	  for(int j=0; j<15; j++){
		  gb[i][j] = new GridButton(i, j);
	  }
	}
	
	if(maxPlayersConnected>15)println("ERROR maxPlayersConnected can not be larger than 15");
	
	console = new Console(width/2, height-10, 100);
	//make a function to handle player joining
	tm = new TurnManager();
	
	player[0] = new Player("XxZebraxX","doc");
	enemy[0] = new Enemy(0);
	
	tm.begin();
}

void drawBg(){//draws the background grid
  background(0);
  fill(bgColor); stroke(lineColor);
  for(int i=0; i<25; i++){
	  for(int j=0; j<15; j++){
		  rect(i*gridSize, j*gridSize, gridSize, gridSize);
	  }
  }
}

void draw(){
	//if(enemy counter rteached 0)do the end game thing
	drawBg();
	tm.draw();
	console.draw();
	for(int i=0; i<currentPlayersInGame; i++) player[i].draw();
	for(int i=0; i<currentEnemiesInGame; i++) enemy[i].draw();
}

void EnemyDie(int id){
	for(int i=id; i<currentEnemiesInGame-1; i++){
		enemy[i]=enemy[i+1];
	}
	enemy[currentEnemiesInGame-1]=null;
	currentEnemiesInGame--;
}

void keyPressed(){
	if(key=='m')tm.ButtonEvent("m");
	if(key=='a')tm.ButtonEvent("atk");
}

void mousePressed(){
	for(int i=0; i<25; i++){
		for(int j=0; j<15; j++){
			gb[i][j].mouseClicked();
		}
	}	
}
