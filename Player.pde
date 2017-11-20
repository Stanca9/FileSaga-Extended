class Player{
	private PImage sprite, currentScreen, highlightSprite;
	private int basicAttackRange=20, basicAttackDamage=1;
	protected int x=0, y=-1, health=22;
	protected String name, extention;
	public String currentAction="";
	
	Player(String nameIn,String classString){//wip
		int r=floor(random(0,14));
		if(currentPlayersInGame>0){
			while(true){
				boolean found=false;
				for(int i=0; i<currentPlayersInGame; i++){
					if(r==player[i].y){
						found=true; break;
					}
				}
				if(found){
					r++;
					if(r>15)r=0;
				}
				else break;
			}
		}
		y=r;
		currentPlayersInGame++;
		
		name = nameIn;
		extention = classString;
		
		switch (classString){
			case "bat": sprite=loadImage("genericPlayer.png"); break;
			case "doc": sprite=loadImage("doc.png");           break;
			case "txt": sprite=loadImage("genericPlayer.png"); break;
			case "json":sprite=loadImage("genericPlayer.png"); break;
			case "zip": sprite=loadImage("genericPlayer.png"); break;
			case "ico": sprite=loadImage("genericPlayer.png"); break;
			default: println("invallid class [" + classString + "]");
		}
		highlightSprite = loadImage("highlightSprite.png");
		
		console.print(nameIn + " joined");
	}
	
	public void Do(String s){
		currentAction=s;
		switch (currentAction){
			case "move": console.print(name+" is moving");
			case "atk": console.print(name+" is attacking");
		}
	}
	
	private int calculateDistanceToPoint(int xx, int yy){
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
	
	private void drawA1(){//wip
		console.print("did action 1");
	}
	
	private void drawA2(){//wip
		console.print("did action 2");
	}
	
	private void drawA3(){//wip
		console.print("did action 3");
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
		
	private void drawAttack(){//wip
		for(int i=0; i<currentEnemiesInGame; i++)
			if(calculateDistanceToPoint(enemy[0].x, enemy[0].y)<=basicAttackRange)
				image(highlightSprite, enemy[i].x*gridSize, enemy[i].y*gridSize);
	}
	
	private boolean checkIfSquareEmpty(int xx, int yy){
		for(int i=0; i<currentPlayersInGame; i++){
			if(xx == player[i].x && yy == player[i].y)return false;
		}
		for(int i=0; i<currentEnemiesInGame; i++){
			if(xx == enemy[i].x && yy == enemy[i].y)return false;
		}
		//add here checking trought the list/ array of blocked grid spaces
		return true;
	}
	
	private boolean checkIfSquareAdjasent(int xx, int yy){//returns true if that square is withing movement range of the player
		if(xx>25||yy>15){
			println("checkIfSquareAdjasent: argument out of range x:"+x+" y:"+y);
			return false;
		}
		boolean check = true;
		check = check && (xx<=x+2 && xx>=x-2 && yy<=y+2 && yy>=y-2);
		check = check && !(xx==x && yy==y);
		check = check && !(xx==x-2&&yy!=y);
		check = check && !(xx==x+2&&yy!=y);
		check = check && !(xx!=x&&yy==y-2);
		check = check && !(xx!=x&&yy==y+2);	
		return check;
	}

	private void ExecuteMove(int sx, int sy){
		x=sx;
		y=sy;
		console.print(name + "has moved to square[" + x + "," + y + "]");
		currentAction="";
		tm.EndTurn();
	}
	
	public void PassGridClicked(int gx, int gy){
		switch(currentAction){
			case "move": if(checkIfSquareAdjasent(gx,gy) && checkIfSquareEmpty(gx,gy))ExecuteMove(gx, gy);
			case "atk": {
				for(int i=0; i<currentEnemiesInGame; i++){
					if(enemy[i].x == gx && enemy[i].y == gy){
						console.print(name + "damaged enemy[" + i + "] for " + basicAttackDamage);
						enemy[i].Damage(basicAttackDamage);
					}
				}
			}
		}
	}

	
	void draw(){
		image(sprite, x*gridSize, y*gridSize);
		switch (currentAction){
			case "move": drawMove(); break;
			case "atk": drawAttack(); break;
		}
	}
}