import processing.net.*;

//SERVER SIDE
	
Server myServer;
String output, dataIn;

void setup() {
  size(200, 200);
  // Starts a myServer on port 5204
  myServer = new Server(this, 5204); 
}

void serverEvent(myServer, Client c){
	println("new client connected. ip:" + c.ip())
	while(myServer.available()!=0){}
	dataIn = c.readStringUntil('\n');
	name = dataIn.substring(0,dataIn.indexOf(","));//name is set to whatever is in the data up to the first comma
	dataIn = dataIn.substring(dataIn.indexOf(",")+1);//the name and 1st comma is removed from data
	cls = dataIn.charAt(0);//class is set to whatever is in the 1st charachter in data
	dataIn = dataIn.substring(0,2);//the class and 1st comma is removed from data
}

void draw() {
	
}
	
	
	//TURN MANAGEMENT SIDE
	
private int playerTurnCtr = 0, enemyTurnCtr=0;
private boolean isPlayerTurn=true;
	
TurnManager(){
	console.print("Turn manager connected");
}
	
void begin(){
	console.print("It is now "+player.get(playerTurnCtr).name+"'s turn");
}
	
void ButtonEvent(char input){
	if(isPlayerTurn)
		player.get(playerTurnCtr).Do(input);
}
	
void EndTurn(){
	if(isPlayerTurn){
		player.get(playerTurnCtr).ClearCurrentAction();
		playerTurnCtr++;
		if(playerTurnCtr==player.size()){
			playerTurnCtr=0;
			isPlayerTurn=false;
			console.print("-Enemy turns-");
			enemy.get(enemyTurnCtr).StartTurn();
		}
		else console.print("It is now "+player.get(playerTurnCtr).name+"'s turn");
	}
	else{
		enemyTurnCtr++;
		if(enemyTurnCtr==enemy.size()){
			enemyTurnCtr=0;
			isPlayerTurn=true;
		}
		else
			enemy.get(enemyTurnCtr).StartTurn();
	}
}
