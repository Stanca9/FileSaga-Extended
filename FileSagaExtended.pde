import processing.net.*;

//constants
String serverIP = "192.168.1.98", name="Gicu";
byte gridSize = 40;//size in pixels of a grid square
color bgColor=#000000, lineColor=#FFFFFF;
char cls='d';

//variables
byte x, y;//positions of the player on the grid
PImage cursorImage, sprite, highlightSprite;//the sprite of the cursor, the player itself, the sprite that gets overlayed over the tiles you can move onto, attack etc
PFont myFont;
ArrayList<Player> otherPlayer;
ArrayList<Enemy> enemy;
Console console;
char currentAction;
boolean isConnectedToServer=false;
Client myClient;
String dataIn;

void readData(){
	while(myClient.available()<2);
	dataIn="";
	while(dataIn.indexOf('\n')==-1){
		dataIn += myClient.readString();//reads stream until encounters a newline charachter
	}
	dataIn = dataIn.substring(0, dataIn.indexOf('\n'));
	println(dataIn);
}

void setup(){
	size(1001, 751,P2D);//size of the window
	cursorImage = loadImage("cursor.png");//sets the cursor image
	cursor(cursorImage,0,0);
	while(!focused){}//waits until the player clisks in the window
	myFont = createFont("pcsenior.ttf", 8);//sets the font
	textFont(myFont);
	
	otherPlayer = new ArrayList<Player>();
	enemy = new ArrayList<Enemy>();
	//blockedTile = new ArrayList<BlockedTile>();
	
	myClient = new Client(this, serverIP, 5204);
	myClient.write(name+','+cls+'\n');//////////////////////////////////
	readData();
	y = byte(dataIn.charAt(0));
	//print to console what server you joined
	
	//switch of class to set the sprite
	sprite = loadImage("doc.png");
	
	
	console = new Console(width/2, height-10, 100, 11);
	//make a function to handle player joining
}

void EndTurn(){
	
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

int calculateDistanceToPoint(int xx, int yy){
		int dist =0;
		if(x<=xx){
			while(x!=xx){xx--; dist++;}
			if(y<=yy){
				while(y!=yy){yy--; dist++;}
			}
			else{
				while(y!=yy){yy++; dist++;}
			}
		}
		else{
			while(x!=xx){xx++; dist++;}
			if(y<=yy){
				while(y!=yy){yy--; dist++;}
			}
			else{
				while(y!=yy){yy++; dist++;}
			}
		}
		return dist;
	}

PVector calculateMouseOnGrid(){//returns the position of the mouse on the grid or -1,-1 if its out of the grid
	for(int i=0; i<25; i++)
		for(int j=0; j<15; j++)
			if(mouseX<i*gridSize && mouseY<j*gridSize)
				return new PVector(i,j);
	return new PVector(-1,-1);
}

boolean checkIfSquareEmpty(int xx, int yy){
	for(Player p : otherPlayer){
		if(xx == p.x && yy == p.y)return false;
	}
	for(Enemy e : enemy){
		if(xx == e.x && yy == e.y)return false;
	}
	//add here checking trought the ArrayList of blocked grid spaces
	return true;
}

boolean checkIfSquareAdjasent(int xx, int yy){//returns true if that square is withing movement range of the player
	if(xx>25||yy>15){
		println("checkIfSquareAdjasent: argument out of range x:"+x+" y:"+y);
		return false;
	}
	boolean check = true;
	check = check &&  (xx<=x+2 && xx>=x-2 && yy<=y+2 && yy>=y-2);
	check = check && !(xx==x   && yy==y);
	check = check && !(xx==x-2 &&yy!=y);
	check = check && !(xx==x+2 &&yy!=y);
	check = check && !(xx!=x   &&yy==y-2);
	check = check && !(xx!=x   &&yy==y+2);	
	return check;
	}

private void drawMove(){//wip
		boolean cangoUp, cangoDown, cangoLeft, cangoRight;
		cangoUp = checkIfSquareEmpty(x,y-1);
		cangoDown = checkIfSquareEmpty(x,y+1);
		cangoLeft = checkIfSquareEmpty(x-1,y);
		cangoRight =checkIfSquareEmpty(x+1,y);
		if(cangoRight){
			image(highlightSprite, (x+1)*40,y*40);
			if(checkIfSquareEmpty(x+2,y))image(highlightSprite, (x+2)*40,y*40);
		}
		if(cangoDown){
			image(highlightSprite, x*40,(y+1)*40);
			if(checkIfSquareEmpty(x,y+2))image(highlightSprite, x*40,(y+2)*40);
		}
		if(cangoLeft){
			image(highlightSprite, (x-1)*40,y*40);
			if(checkIfSquareEmpty(x-2,y))image(highlightSprite, (x-2)*40,y*40);
		}
		if(cangoUp){
			image(highlightSprite, x*40,(y-1)*40);
			if(checkIfSquareEmpty(x,y-2))image(highlightSprite, x*40,(y-2)*40);
		}
		if(checkIfSquareEmpty(x+1,y+1)&&(cangoDown || cangoRight))image(highlightSprite, (x+1)*40,(y+1)*40);
		if(checkIfSquareEmpty(x+1,y-1)&&(cangoUp || cangoRight))image(highlightSprite, (x+1)*40,(y-1)*40);
		if(checkIfSquareEmpty(x-1,y+1)&&(cangoDown || cangoLeft))image(highlightSprite, (x-1)*40,(y+1)*40);
		if(checkIfSquareEmpty(x-1,y-1)&&(cangoUp || cangoLeft))image(highlightSprite, (x-1)*40,(y-1)*40);
	}

void draw(){
	drawBg();
	console.draw();
	image(sprite, x*gridSize,y*gridSize);//displays this player
	String cout; 
	cout = "x=" + char(x) + " y=" + char(y);
	console.print(cout);
	//for(Enemy e : enemy) e.draw();//displays each enemy
	//for(BlockedTile b : blockedTile) b.draw();
}

void mouseClicked(){
	PVector mo = calculateMouseOnGrid();
	if(mo.x != -1){//if the mouse is on the grid
		if(mo.x==x&&mo.y==y){//if if clicked the myPlayer
			currentAction = 'm';
		}
		else
		switch(currentAction){
			case 'm': 
				if(checkIfSquareAdjasent(floor(mo.x),floor(mo.y)) && checkIfSquareEmpty(floor(mo.x),floor(mo.y))){
					x=byte(floor(mo.x)); 
					y=byte(floor(mo.y));
					console.print(name + "has moved to square[" + x + "," + y + "]");
					EndTurn();
				}
				break;
			/*
			case 'a': {
				for(Enemy e : enemy){
					if(e.x == mo.x && e.y == mo.y){
						console.print(name + " damaged enemy for " + basicAttackDamage);
						e.Damage(basicAttackDamage);
						EndTurn();
					}
				}
			}
			*/
		}
	}
}

class Player{
	protected int x,y;
	protected PImage sprite;
	protected String name;
}

class Enemy{
	protected int x,y,health;
	protected PImage sprite;
}