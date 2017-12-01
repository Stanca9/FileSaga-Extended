class SettingsScene {
	/*
	Scene consists of ...
	*/
	UIslider musicVolumeSlider,sfxVolumeSlider;
	UIbutton backButton;
	
	SettingsScene(){
		musicVolumeSlider = new UIslider(height/2, 10, "Music");
		sfxVolumeSlider = new UIslider(height/2+100,10, "SFX");
		backButton = new UIbutton(width/2, height-40, 100, 40, "Back", 25);
	}
	
	void draw(){
		background(0);
		
		fill(#FFFFFF);
		textAlign(CENTER, CENTER);
		textSize(60);
		text("Settings", width/2, 150);
		
		if(mousePressed){
			if(backButton.mouseIsHovering())sm.loadScene("menu");
		}
		
		musicVolumeSlider.draw();
		sfxVolumeSlider.draw();
		backButton.draw();
	}
}