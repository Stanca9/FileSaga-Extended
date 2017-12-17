class Player{
	PImage sprite;
	int x=0, y=0, health;
	color highlightColor = #A0F020;
	int gridSize=40;
	
	private boolean began=false;
	
	void begin(String classString){
		switch (classString){
			case "bat": sprite=loadImage("genericPlayer.png");  health=2; began = true; break;
			case "doc": sprite=loadImage("doc.png");  health=3; began = true; break;
			case "txt": sprite=loadImage("genericPlayer.png");  health=4; began = true; break;
			case "json":sprite=loadImage("genericPlayer.png"); health=4; began = true; break;
			case "zip": sprite=loadImage("genericPlayer.png");  health=5; began = true; break;
			case "ico": sprite=loadImage("genericPlayer.png");  health=2; began = true; break;
			default: println("invallid class [" + classString + "]");
		}
	}
	
	void display(){
		if(!began)return;
		fill(highlightColor); stroke(#FFFFFF);
		image(sprite, x*gridSize, y*gridSize);
	}
}