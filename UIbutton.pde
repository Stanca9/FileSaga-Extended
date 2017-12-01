class UIbutton {
	//A button on the ui. You can make it do something when you click it.
	
	protected float x,y,w,h,txtSize;
	protected String txt;
	
	UIbutton(float tempx, float tempy, float tempw, float temph, String tempTxt, float tempTxtSize){
		x = tempx;
		y = tempy;
		w = tempw;
		h = temph;
		txt = tempTxt;
		txtSize = tempTxtSize;
	}
	
	UIbutton(float tempx, float tempy, float tempw, float temph){
		x = tempx;
		y = tempy;
		w = tempw;
		h = temph;
	}
	
	public boolean mouseIsHovering(){
		if(mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2) return true;
		return false;
	}
	
	void draw(){
		stroke(#FFFFFF);
		fill(0);
		rectMode(CENTER);
		textAlign(CENTER, CENTER);
		textSize(txtSize);
		if(!mouseIsHovering()){
			rect(x,y,w,h);
			fill(#FFFFFF);
			text(txt,x,y);
		}
		else{
			rect(x,y,w+4,h+4);
			fill(#FFFFFF);
			text(txt,x,y);
		}
	}
}