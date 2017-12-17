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
		exitButton =     new UIbutton(width/2, 630, 400, 50, "Quit");
		creditsButton =  new UIbutton(width/2, 560, 400, 50, "Credits");
		settingsButton = new UIbutton(width/2, 490, 400, 50, "Settings");
		mpButton =       new UIbutton(width/2, 420, 400, 50, "Multiplayer");
		spButton =       new UIbutton(width/2, 350, 400, 50, "Singleplayer");
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
		
		if(mousePressed){
			if(exitButton.mouseIsHovering())exit();
			else if(settingsButton.mouseIsHovering())sm.loadScene("settings");
			else if(mpButton.mouseIsHovering())sm.loadScene("multiplayer");
			else if(spButton.mouseIsHovering())sm.loadScene("singleplayer");
			else if(creditsButton.mouseIsHovering())sm.loadScene("credits");
		}
	}
}