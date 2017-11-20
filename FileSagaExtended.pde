int gridSize=40;//size in pixels of a grid square
color bgColor=#000000, lineColor=#FFFFFF;
PImage cursorImage, UIimage;
int mX=0, mY=0;//mouse coordinates on the grid
PFont myFont;

ArrayList<Player> player;
ArrayList<Enemy> enemy;
ArrayList<BlockedTile> bt;

Console console;
TurnManager tm;
GridButton[][] gb = new GridButton[25][15];

void setup(){
	size(1001, 751,P2D);//size of the window
	cursorImage = loadImage("cursor.png");//sets the cursor image
	cursor(cursorImage,0,0);
	while(!focused){}//waits until the player clisks in the window
	myFont = createFont("pcsenior.ttf", 8);//sets the font
	textFont(myFont);
	
	player = new ArrayList<Player>();
	enemy = new ArrayList<Enemy>();
	bt = new ArrayList<BlockedTile>();
	
	for(int i=0; i<25; i++){
	  for(int j=0; j<15; j++){
		  gb[i][j] = new GridButton(i, j);
	  }
	}
	
	console = new Console(width/2, height-10, 100);
	//make a function to handle player joining
	tm = new TurnManager();
	
	player.add(new Player("Ambrei","doc"));
	enemy.add(new Enemy());
	enemy.add(new Enemy());
	enemy.add(new Enemy());
	enemy.add(new Enemy());
	
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
	console.draw();
	for(Player p : player) p.draw();
	for(int i=0; i<enemy.size(); i++){
		if(enemy.get(i).isDead) enemy.remove(i);
		else enemy.get(i).draw();
	}
}

void keyPressed(){
	if(key=='m')tm.ButtonEvent('m');
	if(key=='a')tm.ButtonEvent('a');
}

void mouseClicked(){
	for(int i=0; i<25; i++){
		for(int j=0; j<15; j++){
			gb[i][j].mouseClicked();
		}
	}	
}
