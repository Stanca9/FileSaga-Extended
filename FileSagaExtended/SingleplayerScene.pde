class SingleplayerScene {
	private Camera cam;
	private PImage actionBar, backgroundImage;
	private Console console;
	private UIbutton nextTurnButton;
	
	SingleplayerScene(){
		cam = new Camera('d');
		console = new Console(0.77, 0.99, 75, 6);
		actionBar = loadImage("action bar.png");
		backgroundImage = loadImage("background2.png");
		nextTurnButton = new UIbutton(245,682,loadImage("next turn button.png"));
	}
	
	void draw(){
		cam.draw();
		background(0);
		imageMode(CORNER);
		image(backgroundImage,0,0);
		translate(-1*cam.x,-1*cam.y);//reset translate for the UI
		image(actionBar, 0, 531);
		nextTurnButton.draw();
		console.draw();
	}
}