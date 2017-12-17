import processing.net.*;

Console console;	
Server server;
String output, dataIn;
boolean allowClientsToConnect = true;


ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

void settings(){
	size(400,400);
}

void setup() {//done
	surface.setResizable(true);
	console = new Console(0.5, 1, 100, 19);
	// Starts a server on port 5204
	server = new Server(this, 5204); 
	console.print("Console started!");
	console.print("server ip: "+Server.ip());	
	for(int i=0; i<5; i++)enemies.add(new Enemy());//TEMPORARY adds a few enemies in for testing
}	

void readData(Client c){
	dataIn = c.readString();//reads stream until encounters a newline charachter
	dataIn = dataIn.substring(0, dataIn.indexOf('\n'));//excludes newline charachter
}

void serverEvent(Server s, Client c){//done
	if(allowClientsToConnect){
		byte clientId = byte(players.size());
		players.add(new Player(c.ip()));
		readData(c);
		players.get(clientId).cls = dataIn.charAt(dataIn.indexOf(',')+1);
		players.get(clientId).name = dataIn.substring(0,dataIn.indexOf(','));
		
		//s.write(players.get(clientId).y+'\n');
		s.write("4\n");//sends the client it's y position
		console.print(players.get(clientId).name + " connected as " + players.get(clientId).cls + ' ' + c.ip());//prints the information of the client that has connected
	}
	else{
		console.print("client with ip: " + c.ip() + "has been refused connection");
		server.disconnect(c);
	}
}

void draw() {
	background(0);
	console.draw();
	if(!allowClientsToConnect){
		
	}
}
	
void keyTyped(){
	if(key == '1' && players.size()>0){//if the advance key was pressed start the game
		allowClientsToConnect=false;//stops any more clients from joining an ongoing match
		console.print("Clients are no longer allowed to connect");
		console.print("Game has started");
		beginMatch();
	}
}
	
class Player {//done
	protected String ip;
	public String name;
	public char cls;
	protected byte x, y;
	Player(String tempip){
		ip = tempip;
		
		byte r = byte(floor(random(0,14)));
		if(players.size()>1){
			while(true){
				boolean found=false;
				for(Player p : players){
					if(r==p.y){
						found=true; break;
					}
				}
				if(found){
					r++;
					if(r>15)r=0;
				}
				else break;
			}
		}
		y=r;
	}
}


	//TURN MANAGEMENT SIDE
	
private int playerTurnCtr = 0, enemyTurnCtr=0;
private boolean isPlayerTurn=true;
	
void beginMatch(){
	server.write("all\n");//tells all the players
	server.write("beginmatch\n");//tells all the players to expect the beggining information(player, enemy, and block positions)
	for(Player p : players){
		server.write(p.ip+'\n'+p.name+'\n'+p.x+'\n'+p.y+'\n');
		console.print(p.ip);
		console.print(p.name);
	}
	server.write(255);
	for(Enemy e : enemies){//update this when you change the enemy class(with type)
		server.write(e.x+'\n'+e.y+'\n');
	}
	server.write(255);
	console.print("It is now "+players.get(playerTurnCtr).name+"'s turn");
	PlayerTurn(byte(0));//starts the turn of the first player
}
	
void EndTurn(){
	if(isPlayerTurn){
		playerTurnCtr++;
		if(playerTurnCtr==players.size()){
			playerTurnCtr=0;
			isPlayerTurn=false;
			console.print("-Enemy turns-");
			enemies.get(enemyTurnCtr).StartTurn();
		}
		else console.print("It is now "+players.get(playerTurnCtr).name+"'s turn");
	}
	else{
		enemyTurnCtr++;
		if(enemyTurnCtr==enemies.size()){
			enemyTurnCtr=0;
			isPlayerTurn=true;
		}
		else
			enemies.get(enemyTurnCtr).StartTurn();
	}
}

void Do(String thing){//update with more actions
	switch(thing.charAt(0)){
		case 'm': {
			byte xx = byte(thing.charAt(1)), yy = byte(thing.charAt(2));
			players.get(playerTurnCtr).x = xx;
			players.get(playerTurnCtr).y = yy;
			server.write(players.get(playerTurnCtr).ip + thing);
		}
	}
}

void PlayerTurn(byte playerIdInList){//done
	//sends all the players the message that someone has started their turn
	server.write(players.get(playerIdInList).name+'\n'+"st"+'\n');
	while(server.available()==null){}	//waits for the player to decide to do something
	Client c = server.available();//reads whatever the client has to say
	dataIn = c.readString();
	while(dataIn != "et"){//does the commands it gets from that client until he sends end of turn ("et")
		Do(dataIn);
	}
	EndTurn();//ends the turn
}