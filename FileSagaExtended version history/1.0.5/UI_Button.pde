class UIbutton {
	//A button on the ui. You can make it do something when you click it.
	
	protected boolean isClicked;
	private boolean mousePressedLastFrame=true;
	
	protected float x,y,w,h;
	protected String txt;
	private PImage sprite, highlightedSprite;
	private boolean spriteMode;
	
	float textOffset = 2;//modify to raise the text inside the button box
	
	UIbutton(float tempx, float tempy, float tempw, float temph, String tempTxt){
		x = tempx;
		y = tempy;
		w = tempw;
		h = temph;
		txt = tempTxt;
		spriteMode = false;
	}
	
	UIbutton(float tempx, float tempy, float tempw, float temph){
		x = tempx;
		y = tempy;
		w = tempw;
		h = temph;
		spriteMode = false;
	}
	
	UIbutton(float tempx, float tempy, PImage tempSprite){
		x = tempx;
		y = tempy;
		sprite = tempSprite;
		highlightedSprite = sprite;
		spriteMode = true;
	}
	
	UIbutton(float tempx, float tempy, PImage tempSprite, PImage tempHighlightedSprite){
		x = tempx;
		y = tempy;
		sprite = tempSprite;
		highlightedSprite = tempHighlightedSprite;
		spriteMode = true;
	}
	
	public boolean mouseIsHovering(){
		if(spriteMode){//if the button is a image button
			if(mouseX > x-sprite.width/2 && mouseX < x+sprite.width/2 && mouseY > y-sprite.height/2 && mouseY < y+sprite.height/2){
				return true;
			}
			return false;
		}
		else{//if the button is a text button
			if(mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2) return true;
			return false;
		}
	}
	
	void draw(){
		if(mouseIsHovering() && mousePressed && !mousePressedLastFrame) isClicked=true;
		else isClicked=false;
		
		if(spriteMode){//if the button is a image button
			imageMode(CENTER);
			if(mouseIsHovering()){
				image(highlightedSprite,x,y);
			}
			else{
				image(sprite,x,y);
			}
		}
		else{//if the button is a text button
			stroke(#FFFFFF);
			fill(0);
			rectMode(CENTER);
			textAlign(CENTER, CENTER);
			strokeWeight(4);
			textFont(font075);
			
			map(textOffset, 0, 80, 0, h);
			
			if(!mouseIsHovering()){
				rect(x,y,w,h);
				fill(#FFFFFF);
				text(txt,x,y-textOffset);
			}
			else{
				rect(x,y,w+4,h+4);
				fill(#FFFFFF);
				text(txt,x,y-textOffset);
			}
		}
		
		mousePressedLastFrame = mousePressed;
	}

}