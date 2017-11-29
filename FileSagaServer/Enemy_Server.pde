class Enemy{
	protected int health=1, x=24, y;
	protected boolean isDead=false;
	private PImage sprite;
	
	Enemy(){
		int r=floor(random(0,14));
		if(enemies.size()>1){
			while(true){
				boolean found=false;
				for(Enemy e : enemies){
					if(r==e.y){
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
		sprite=loadImage("enemy.png");
		//switch of type to set the health
	}
	
	void Damage(int amount){
		health-=amount;
		if(health<=0)isDead=true;
	}
	
	void StartTurn(){
		console.print("enemy moved");
		x--;
		EndTurn();
	}
}