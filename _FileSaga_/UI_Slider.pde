class UIslider {
	
	protected int segments, value;
	protected float x,y,w,h;
	protected String txt;
	
	private boolean mousePressedLastFrame=true;
	
	UIslider(float tempy, int tempSegments, String tempTxt){
		x = width/2;
		y = tempy;
		w = 400;
		h = 40;
		segments = tempSegments;
		txt = tempTxt;
		value = segments;
	}
	
	UIslider(float tempx, float tempy, float tempw, float temph, int tempSegments, String tempTxt){
		x = tempx;
		y = tempy;
		w = tempw;
		h = temph;
		segments = tempSegments;
		txt = tempTxt;
		value = segments;
	}
	
	private void click(){
		if(mouseX<x)value--;
		else value++;
		if(value<0)value=0;
		if(value>segments)value=segments;
	}
	
	private boolean mouseIsHovering(){
		if(mouseY > y-h/2 && mouseY < y+h/2){
			if((mouseX > x-w/2-h && mouseX < x-w/2)||(mouseX > x+w/2 && mouseX < x+w/2+h)){
				return true;
			}
		}
		return false;
	}
	
	void draw(){
		if(mouseIsHovering() && mousePressed && !mousePressedLastFrame) click();
		
		stroke(#FFFFFF);
		fill(0);
		rectMode(CENTER);
		textAlign(CENTER, BOTTOM);
		strokeWeight(4);
		textFont(font1);
		
		rect(x,y,w,h);
		for(int i=1; i< segments; i++){
			line(x-w/2 + (w/segments)*i, y-h/2, x-w/2 + (w/segments)*i, y+h/2);
		}
		fill(#FFFFFF);
		rect(x-w/2-h/2, y, h/2, 2);//the minus
		rect(x+w/2+h/2, y, h/2, 2);//the plus
		rect(x+w/2+h/2, y, 2, h/2);//the plus
		
		for(int i=1; i<=value; i++){
			rect(x-w/segments/2-w/2+i*w/segments,y, w/segments-14, h-14);
		}
		
		text(txt,x,y-h/2 -5);
		mousePressedLastFrame = mousePressed;
	}
}