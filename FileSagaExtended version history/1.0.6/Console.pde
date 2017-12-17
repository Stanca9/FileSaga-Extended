class Console{
	
	float xRatio, yRatio;
	int textCol=0, maxWidth;
	private int lineNo=0, maxLineNo;
	String content="";
	
	Console(float xIn, float yIn, int maxWidthIn, int maxLineNoIn){//give it a ratio based on screen size
		xRatio=xIn;
		yRatio=yIn;
		maxWidth = maxWidthIn;
		maxLineNo = maxLineNoIn;
		print("Console started");
	}
	
	void print(String message){
		if(message.length()>maxWidth && maxWidth!=0){
			println("console error: invallid length [" + message.length() + "]");
			return;
		}
		lineNo++;
		if(lineNo>=maxLineNo && maxLineNo!=0){
			int search=0;
			while(content.charAt(search)!='\n') search++;
			content = content.substring(search+1);
			lineNo--;
		}
		content += "\n";
		content += message;

	}
	
	void draw(){
		textFont(font025);
		fill(textCol);
		textAlign(CENTER, BOTTOM);
		text(content, width*xRatio, height*yRatio);
	}
}