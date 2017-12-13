class MenuScene {
	/*
	Scene consists of a title and four buttons.
		one to start a singeplayer game
		one to start a multiplayer game
		one to show the settings
		one to quit the game
	*/
	PImage title;
	UIbutton exitButton, settingsButton, mpButton, spButton, creditsButton;
	
	MenuScene(){
		title = loadImage("FileSagaLogo.png");
		exitButton =     new UIbutton(width/2, 540+35, 320, 42, "Quit");
		creditsButton =  new UIbutton(width/2, 480+35, 320, 42, "Credits");
		settingsButton = new UIbutton(width/2, 420+35, 320, 42, "Settings");
		mpButton =       new UIbutton(width/2, 360+35, 320, 42, "Multiplayer");
		spButton =       new UIbutton(width/2, 300+35, 320, 42, "Singleplayer");
	}
	
	void draw(){
		background(0);
		
		imageMode(CENTER);
		image(title, width/2, 150);
		
		//fill(#FFFFFF);
		//textAlign(CENTER, CENTER);
		//textSize(70);
		//text("File Saga Extended v0.1", width/2, 150);
		
		exitButton.draw();
		settingsButton.draw();
		mpButton.draw();
		spButton.draw();
		creditsButton.draw();
	
		if      (exitButton.isClicked)     exit();
		else if (settingsButton.isClicked) sm.loadScene("settings");
		else if (mpButton.isClicked)       sm.loadScene("multiplayer");
		else if (spButton.isClicked)       sm.loadScene("singleplayer");
		else if (creditsButton.isClicked)  sm.loadScene("credits");

	}
}