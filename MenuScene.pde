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
		exitButton = new UIbutton(width/2, 600, 800, 80, "Quit", 30);
		settingsButton = new UIbutton(width/2, 500, 800, 80, "Settings", 30);
		mpButton = new UIbutton(width/2, 400, 800, 80, "Multiplayer", 30);
		spButton = new UIbutton(width/2, 300, 800, 80, "Singleplayer", 30);
	}
	
	void update(){
		background(0);
		
		fill(#FFFFFF);
		textAlign(CENTER, CENTER);
		textSize(40);
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