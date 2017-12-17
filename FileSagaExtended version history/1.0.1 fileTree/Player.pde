/*
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
*/