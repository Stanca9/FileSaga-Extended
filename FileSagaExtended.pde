import processing.net.*;

int  gridSize=40;//size in pixels of a grid square
color bgColor=#000000, lineColor=#FFFFFF;
PVector position = new PVector(0,-1);
PImage cursorImage, sprite, highlightSprite;//the sprite of the cursor, the player itself, the sprite that gets overlayed over the tiles you can move onto, attack etc
PFont myFont;
String name="gicu";
ArrayList<Player> otherPlayer;
ArrayList<Enemy> enemy;
ArrayList<BlockedTile> blockedTile;
Console console;
char currentAction, cls;
boolean isConnectedToServer=false;

Client myClient;
String dataIn;

void setup(){
	size(1001, 751,P2D);//size of the window
	cursorImage = loadImage("cursor.png");//sets the cursor image
	cursor(cursorImage,0,0);
	while(!focused){}//waits until the player clisks in the window
	myFont = createFont("pcsenior.ttf", 8);//sets the font
	textFont(myFont);
	
	otherPlayer = new ArrayList<Player>();
	enemy = new ArrayList<Enemy>();
	blockedTile = new ArrayList<BlockedTile>();
	
	myClient = new Client(this, "127.0.0.1", 5204);
	for(int i=0; i<name.length(); i++)
		myClient.write(name.charAt(i));
	myClient.write(',');
	myClient.write(cls);
	dataIn = myClient.readStringUntil('\n');
	
	
	//set sprite based on class
	//get y position from server
	//print to console what server you joined
	
	
	console = new Console(width/2, height-10, 100);
	//make a function to handle player joining
	
	//connect to server
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
		if(position.x<=xx){
			while(position.x!=xx){xx--; dist++;}
			if(position.y<=yy){
				while(position.y!=yy){yy--; dist++;}
			}
			else{
				while(position.y!=yy){yy++; dist++;}
			}
		}
		else{
			while(position.x!=xx){xx++; dist++;}
			if(position.y<=yy){
				while(position.y!=yy){yy--; dist++;}
			}
			else{
				while(position.y!=yy){yy++; dist++;}
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
	check = check &&  (xx<=position.x+2 && xx>=position.x-2 && yy<=position.y+2 && yy>=position.y-2);
	check = check && !(xx==position.x   && yy==position.y);
	check = check && !(xx==position.x-2 &&yy!=position.y);
	check = check && !(xx==position.x+2 &&yy!=position.y);
	check = check && !(xx!=position.x   &&yy==position.y-2);
	check = check && !(xx!=position.x   &&yy==position.y+2);	
	return check;
	}

private void drawMove(){//wip
		boolean cangoUp, cangoDown, cangoLeft, cangoRight;
		cangoUp = checkIfSquareEmpty(position.x,position.y-1);
		cangoDown = checkIfSquareEmpty(position.x,position.y+1);
		cangoLeft = checkIfSquareEmpty(position.x-1,position.y);
		cangoRight =checkIfSquareEmpty(position.x+1,position.y);
		if(cangoRight){
			image(highlightSprite, (position.x+1)*40,position.y*40);
			if(checkIfSquareEmpty(position.x+2,position.y))image(highlightSprite, (position.x+2)*40,position.y*40);
		}
		if(cangoDown){
			image(highlightSprite, position.x*40,(position.y+1)*40);
			if(checkIfSquareEmpty(position.x,position.y+2))image(highlightSprite, position.x*40,(position.y+2)*40);
		}
		if(cangoLeft){
			image(highlightSprite, (position.x-1)*40,position.y*40);
			if(checkIfSquareEmpty(position.x-2,position.y))image(highlightSprite, (position.x-2)*40,position.y*40);
		}
		if(cangoUp){
			image(highlightSprite, position.x*40,(position.y-1)*40);
			if(checkIfSquareEmpty(position.x,position.y-2))image(highlightSprite, position.x*40,(position.y-2)*40);
		}
		if(checkIfSquareEmpty(position.x+1,position.y+1)&&(cangoDown || cangoRight))image(highlightSprite, (position.x+1)*40,(position.y+1)*40);
		if(checkIfSquareEmpty(position.x+1,position.y-1)&&(cangoUp || cangoRight))image(highlightSprite, (position.x+1)*40,(position.y-1)*40);
		if(checkIfSquareEmpty(position.x-1,position.y+1)&&(cangoDown || cangoLeft))image(highlightSprite, (position.x-1)*40,(position.y+1)*40);
		if(checkIfSquareEmpty(position.x-1,position.y-1)&&(cangoUp || cangoLeft))image(highlightSprite, (position.x-1)*40,(position.y-1)*40);
	}

void draw(){
	drawBg();
	console.draw();
	image(sprite, position.x*gridSize,position.y*gridSize);//displays this player
	for(Enemy e : enemy) e.draw();//displays each enemy
	for(BlockedTile b : blockedTile) b.draw();
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
				if(checkIfSquareAdjasent(mo.x,mo.y) && checkIfSquareEmpty(mo.x,mo.y)){
					position.set(mo);
					console.print(name + "has moved to square[" + position.x + "," + position.y + "]");
					EndTurn();
				}
				break;
			case 'a': {
				for(Enemy e : enemy){
					if(e.x == mo.x && e.y == mo.y){
						console.print(name + " damaged enemy for " + basicAttackDamage);
						e.Damage(basicAttackDamage);
						EndTurn();
					}
				}
			}
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