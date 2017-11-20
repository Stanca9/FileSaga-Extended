class Enemy{
	protected int health=1, x=24, y, type, id;	
	private PImage sprite;
	
	Enemy(int idIn){
		id = idIn;
		
		int r=floor(random(0,14));
		if(currentEnemiesInGame>0){
			while(true){
				boolean found=false;
				for(int i=0; i<currentEnemiesInGame; i++){
					if(r==enemy[i].y){
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
		currentEnemiesInGame++;
		sprite=loadImage("enemy.png");
		//switch of type to set the health
	}
	
	void draw(){
		image(sprite, x*gridSize, y*gridSize);
	}
	
	void Damage(int amount){
		health-=amount;
		if(health<=0){EnemyDie(id);console.print("enemy " + id + " died");}
	}
	
	void StartTurn(){
		console.print("enemy "+id+" moved");
		x--;
		tm.EndTurn();
	}
}