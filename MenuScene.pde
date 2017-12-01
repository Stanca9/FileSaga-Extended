class MenuScene {
	/*
	Scene consists of a title and four buttons.
		one to start a singeplayer game
		one to start a multiplayer game
		one to show the settings
		one to quit the game
	*/
	UIbutton exitButton, settingsButton, mpButton, spButton;
	
	MenuScene(){
		exitButton =     new UIbutton(width/2, 600, 400, 80, "Quit", 50);
		settingsButton = new UIbutton(width/2, 500, 400, 80, "Settings", 50);
		mpButton =       new UIbutton(width/2, 400, 400, 80, "Multiplayer", 50);
		spButton =       new UIbutton(width/2, 300, 400, 80, "Singleplayer", 50);
	}
	
	void draw(){
		background(0);
		
		fill(#FFFFFF);
		textAlign(CENTER, CENTER);
		textSize(70);
		text("File Saga Extended v0.1", width/2, 150);
		
		exitButton.draw();
		settingsButton.draw();
		mpButton.draw();
		spButton.draw();
		
		if(mousePressed){
			if(exitButton.mouseIsHovering())exit();
			else if(settingsButton.mouseIsHovering())sm.loadScene("settings");
			else if(mpButton.mouseIsHovering())sm.loadScene("multiplayer");
			else if(spButton.mouseIsHovering())sm.loadScene("singleplayer");
		}
	}
}