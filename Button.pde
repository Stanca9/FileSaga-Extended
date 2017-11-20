class Button {
	
	protected int x,y,w,h;
	protected String function;
	
	Button(int tempx, int tempy, int tempwidth, int tenpheight, String tempfunction){
		x=tempx;
		y=tempy;
		w=tempwidth;
		h=tenpheight;
		function=tempfunction;
	}
	
	void mouseCliked(){		
		console.print("button clicked");
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
	