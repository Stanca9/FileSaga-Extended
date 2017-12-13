class SingleplayerScene {
	private PImage actionBar, backgroundImage;
	private Console console;
	private UIbutton nextTurnButton;
	
	SingleplayerScene(){
		console = new Console(0.77, 0.99, 75, 6);
		actionBar = loadImage("action bar.png");
		backgroundImage = loadImage("background2.png");
		nextTurnButton = new UIbutton(245,682,loadImage("next turn button.png"));
	}
	
	void draw(){
		background(0);
		imageMode(CORNER);
		image(backgroundImage,0,0);
		image(actionBar, 0, 531);
		nextTurnButton.draw();
		console.draw();
	}
}