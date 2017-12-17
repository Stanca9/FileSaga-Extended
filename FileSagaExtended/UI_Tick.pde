class UItick {	

	protected boolean value;
	protected float x,y;
	protected String txt;
	protected boolean allignLeft;
	
	private int textPixelSize, boxToTextDistance=20;
	private boolean mousePressedLastFrame=true;
	
	UItick(float tempx, int tempy, String tempTxt, int alignMode){
		x = tempx;
		y = tempy;
		txt = tempTxt;
		if(alignMode == CENTER){
			allignLeft = false;
			textPixelSize = tempTxt.length()*20 + 40 + boxToTextDistance;
		}
	}
	
	UItick(float tempx, int tempy, String tempTxt, int alignMode, boolean initialValue){
		x = tempx;
		y = tempy;
		txt = tempTxt;
		if(alignMode == CENTER){
			allignLeft = false;
			textPixelSize = tempTxt.length()*20 + 40 + boxToTextDistance;
		}
		value = initialValue;
	}
	
	UItick(int tempy, String tempTxt, boolean initialValue){
		x = width/2;
		y = tempy;
		txt = tempTxt;
		allignLeft = false;
		textPixelSize = tempTxt.length()*20 + 40 + boxToTextDistance;
		value = initialValue;
	}
	
	UItick(int tempy, String tempTxt){
		x = width/2;
		y = tempy;
		txt = tempTxt;
		allignLeft = false;
		textPixelSize = tempTxt.length()*20 + 40 + boxToTextDistance;
		value = false;
	}
	
	private boolean mouseIsHovering(){
		if(!allignLeft){
			if(mouseY > y-20 && mouseY < y+20 && mouseX > x-textPixelSize/2 && mouseX < x-textPixelSize/2+40){
				return true;
			}
			return false;
		}
		else{
			if(mouseY > y-20 && mouseY < y+20 && mouseX > x-20 && mouseX < x+20){
				return true;
			}
			return false;
		}
	}
	
	void draw(){
		if(mouseIsHovering() && mousePressed && !mousePressedLastFrame) value=!value;
		
		stroke(#FFFFFF);
		fill(0);
		rectMode(CENTER);
		textAlign(LEFT, CENTER);
		strokeWeight(4);
		textFont(font1);
		
		if(allignLeft){
			rect(x,y,40, 40);
			if(value){
				fill(#FFFFFF);
				strokeWeight(0);
				rect(x,y,30,30);
			}
			fill(#FFFFFF);
			text(txt,x+30,y);
		}
		else{
			rect(x-textPixelSize/2+20,y,40, 40);
			if(value){
				fill(#FFFFFF);
				strokeWeight(0);
				rect(x-textPixelSize/2+20,y,30,30);
			}
			fill(#FFFFFF);
			text(txt, x-textPixelSize/2+40 + boxToTextDistance, y);
		}
		mousePressedLastFrame = mousePressed;
	}
}