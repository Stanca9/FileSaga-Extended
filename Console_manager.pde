class Console{
	
	int x, y, textCol=#FFFFFF, maxWidth;
	private int lineNo=0;
	String content="";
	
	Console(int xIn, int yIn, int maxIn){
		y=yIn;
		x=xIn;
		maxWidth=maxIn;
	}
	
	void print(String message){
		if(message.length()>maxWidth){
			println("console error: invallid length [" + message.length() + "]");
			return;
		}
		lineNo++;
		if(lineNo>11){
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
		textAlign(CENTER, BOTTOM);
		text(content, x, y);
	}
}