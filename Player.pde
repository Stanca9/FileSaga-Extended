class Player{
	private PImage sprite, currentScreen, highlightSprite;
	private int basicAttackRange=20, basicAttackDamage=1;
	protected int x=0, y=-1, health=22;
	protected String name, extention;
	private char currentAction;
	
	Player(String tempname,String tempextension){//wip
		int r=floor(random(0,14));
		if(player.size()>1){
			while(true){
				boolean found=false;
				for(Player p : player){
					if(r==p.y){
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
		
		name = tempname;
		extention = tempextension;
		
		switch (tempextension){
			case "bat": sprite=loadImage("genericPlayer.png"); break;
			case "doc": sprite=loadImage("doc.png");           break;
			case "txt": sprite=loadImage("genericPlayer.png"); break;
			case "json":sprite=loadImage("genericPlayer.png"); break;
			case "zip": sprite=loadImage("genericPlayer.png"); break;
			case "ico": sprite=loadImage("genericPlayer.png"); break;
			default: println("invallid class [" + tempextension + "]");
		}
		
		highlightSprite = loadImage("highlightSprite.png");
		console.print(tempname + " joined");
	}
	
	public void ClearCurrentAction(){
		currentAction=0;
	}
	
	public void Do(char c){
		currentAction=c;
		console.print(name + " is doing something");
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
		for(Enemy e : enemy)
			if(calculateDistanceToPoint(e.x, e.y)<=basicAttackRange)
				image(highlightSprite, e.x*gridSize, e.y*gridSize);
	}
	
	private boolean checkIfSquareEmpty(int xx, int yy){
		for(Player p : player){
			if(xx == p.x && yy == p.y)return false;
		}
		for(Enemy e : enemy){
			if(xx == e.x && yy == e.y)return false;
		}
		//add here checking trought the ArrayList of blocked grid spaces
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
		tm.EndTurn();
	}
	
	public void PassGridClicked(int gx, int gy){
		switch(currentAction){
			case 'm': if(checkIfSquareAdjasent(gx,gy) && checkIfSquareEmpty(gx,gy))ExecuteMove(gx, gy);
			case 'a': {
				for(Enemy e : enemy){
					if(e.x == gx && e.y == gy){
						console.print(name + " damaged enemy for " + basicAttackDamage);
						e.Damage(basicAttackDamage);
						tm.EndTurn();
					}
				}
			}
		}
	}

	
	void draw(){
		image(sprite, x*gridSize, y*gridSize);
		switch (currentAction){
			case 'm': drawMove(); break;
			case 'a': drawAttack(); break;
		}
	}
}