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
	