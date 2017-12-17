class TurnManager {
	private int playerTurnCtr = 0, enemyTurnCtr=0;
	private boolean isEnemyTurn=false;
	private boolean turnResolved=false;
	
	TurnManager(){
		console.print("Turn manager connected");
		console.print("-Player turns-");
	}
	
	void begin(){
		console.print("It is now "+player[playerTurnCtr].name+"'s turn");
	}
	
	void ButtonEvent(String input){
		if(!isEnemyTurn){
			switch(input){
				case "a1": player[playerTurnCtr].Do("act1"); break;
				case "a2": player[playerTurnCtr].Do("act2"); break;
				case "a3": player[playerTurnCtr].Do("act3"); break;
				case "m":  player[playerTurnCtr].Do("move"); break;
				case "end":EndTurn(); break;
				case "atk":player[playerTurnCtr].Do("atk"); break;
				case "the button that I didn't figgure out yet": break;
				default: println("invallid event [" + input + "]");
			}
		}
	}
	
	void EndTurn(){
		turnResolved=true;
	}
	
	void PassGridClicked(int gx, int gy){
		if(!isEnemyTurn){
			player[playerTurnCtr].PassGridClicked(gx, gy);
		}
	}
	
	void draw(){
		if(turnResolved){
			if(!isEnemyTurn){
				playerTurnCtr++;
				if(playerTurnCtr>=currentPlayersInGame){
					playerTurnCtr=0;
					isEnemyTurn=true;
					console.print("-Enemy turns-");
					turnResolved=false;
					enemy[enemyTurnCtr].StartTurn();
					}
				else console.print("It is now "+player[playerTurnCtr].name+"'s turn");
			}
			else{
				enemyTurnCtr++;
				if(enemyTurnCtr>=currentEnemiesInGame){
					enemyTurnCtr=0;
					isEnemyTurn=false;
					console.print("-Player turns-");
				}
				else
					enemy[enemyTurnCtr].StartTurn();
				turnResolved=false;
				
			}
		}
	}
}