class SingleplayerScene {
	private byte gridSize = 40;
	private PImage actionBar;
	private Console console;
	
	SingleplayerScene(){
		console = new Console(0.77, 0.99, 75, 6);
		actionBar = loadImage("action bar.png");
	}
	
	void drawBg(){//draws the background grid
	  background(0);
	  strokeWeight(1);
	  rectMode(CORNER);
	  fill(0); stroke(#FFFFFF);
	  for(int i=0; i<25; i++){
		  for(int j=0; j<15; j++){
			rect(i*gridSize, j*gridSize, gridSize, gridSize);
		  }
		}
	}
	
	void draw(){
		drawBg();
		imageMode(CORNER);
		image(actionBar, 0, 601);
		console.draw();
	}
}