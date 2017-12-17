class Button {
	
	protected int x,y,w,h;
	protected String fun;
	public boolean displayGizmo=false;
	
	Button(int xIn, int yIn, int widthIn, int heightIn, String functionalityIn){
		x=xIn;
		y=yIn;
		w=widthIn;
		h=heightIn;
		fun=functionalityIn;
	}
	
	void mouseCliked(){		
		console.print("button clicked");
	}
	
	void draw(){
		if(displayGizmo){
			fill(#FEAE0F); rect(x*gridSize, y*gridSize, gridSize, gridSize);
		}
	}
}

class GridButton{
	protected int x,y;
	
	GridButton(int xIn, int yIn){
		x=xIn;
		y=yIn;
	}
	
	void mouseClicked(){	
		if(mouseX > x*gridSize && mouseX < x*gridSize+40 && mouseY > y*gridSize && mouseY < y*gridSize+40){
			console.print("grid button clicked [x:"+x+"][y:"+y+"]");
			tm.PassGridClicked(x, y);
		}
	}	
}
	