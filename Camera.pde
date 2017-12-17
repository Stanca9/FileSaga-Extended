class Camera{
	protected float x,y,edgeSiz,maxSpeed,keyboardSpeed;
	protected char mode;//'d' for drag mode, 'e' for edge mode, 'k' for keyboard
	Camera(char tempMode){
		mode = tempMode;
		x=0;
		y=0;
		edgeSiz = 30;
		maxSpeed=0.5;
		keyboardSpeed=0.5;
	}

	Camera(char tempMode, float tempx, float tempy){
		mode = tempMode;
		x=tempx;
		y=tempy;
		edgeSiz = 30;
		maxSpeed=0.5;
		keyboardSpeed=4;
	}

	Camera(char tempMode, float tempx, float tempy, float tempEdge, float tempMax, float tempKeyboardSpeed){
		mode = tempMode;
		x=tempx;
		y=tempy;
		edgeSiz = tempEdge;
		maxSpeed=tempMax;
		keyboardSpeed = tempKeyboardSpeed;
	}

	private void edgeFollow(){
		float distanceToEdge;

		if(mouseY<edgeSiz){
			distanceToEdge = mouseY;
			map(distanceToEdge,0,edgeSiz,0,maxSpeed);
			y+=edgeSiz-distanceToEdge;
		}
		else if(height - mouseY < edgeSiz){
			distanceToEdge = height - mouseY;
			map(distanceToEdge,0,edgeSiz,0,maxSpeed);
			y-=edgeSiz-distanceToEdge;
		}

		if(mouseX<edgeSiz){
			distanceToEdge = mouseX;
			map(distanceToEdge,0,edgeSiz,0,maxSpeed);
			x+=edgeSiz-distanceToEdge;
		}
		else if(width - mouseX < edgeSiz){
			distanceToEdge = width - mouseX;
			map(distanceToEdge,0,edgeSiz,0,maxSpeed);
			x-=edgeSiz-distanceToEdge;
		}
	}

	private void keyboardFollow(){
		if(keyPressed)switch(key){
			case 'w': y-=keyboardSpeed; break;
			case 'a': x-=keyboardSpeed; break;
			case 's': y+=keyboardSpeed; break;
			case 'd': x+=keyboardSpeed; break;
		}
	}

	private void mouseFollow(){
		if(mouseButton==RIGHT){
			cursor(MOVE);
			x += mouseX - pmouseX;
			y += mouseY - pmouseY;
		}
		else cursor(ARROW);
	}

	private void move(){
		switch(mode){
			case 'd': mouseFollow(); break;
			case 'e': edgeFollow(); break;
			case 'k': keyboardFollow(); break;
		}
	}

	public void draw(){
		move();
		translate(x,y);
	}
}