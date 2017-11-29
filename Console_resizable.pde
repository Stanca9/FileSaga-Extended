class Console{
	
	float xRatio, yRatio;
	int textCol=#FFFFFF, maxWidth;
	private int lineNo=0, maxLineNo;
	String content="";
	
	Console(float xIn, float yIn, int maxWidthIn, int maxLineNoIn){
		xRatio=xIn;
		yRatio=yIn;
		maxWidth = maxWidthIn;
		maxLineNo = maxLineNoIn;
	}
	
	void print(String message){
		if(message.length()>maxWidth){
			println("console error: invallid length [" + message.length() + "]");
			return;
		}
		lineNo++;
		if(lineNo>maxLineNo){
			int search=0;
			while(content.charAt(search)!='\n') search++;
			content = content.substring(search+1);
			lineNo--;
		}
		content += "\n";
		content += message;

	}
	
	void draw(){
		fill(textCol);
		textSize(12);
		textAlign(CENTER, BOTTOM);
		text(content, width*xRatio, height*yRatio);
	}
}