class CreditsScene {
	/*
	Scene consists of ...
	*/
	UIbutton backButton;
	
	CreditsScene(){

		backButton = new UIbutton(width/2, height-40, 120, 50, "Back");
	}
	
	void draw(){
		background(0);
		
		fill(#FFFFFF);
		textAlign(CENTER, CENTER);
		textFont(font2);
		text("Credits", width/2, 150);
		textAlign(CENTER, TOP);
		textFont(font05);
		text("Pishpirel Magiulanu - poking the code\nChilotescu Minciunica - wipping the paintbrush\nNiculitza Frilica - told his mom about the game", width/2, 300);
		if(mousePressed){
			if(backButton.mouseIsHovering())sm.loadScene("menu");
		}
		
		backButton.draw();
	}
}