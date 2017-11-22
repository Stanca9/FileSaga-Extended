class TurnManager {
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
	
	void PassGridClicked(int gx, int gy){
		if(isPlayerTurn){
			player.get(playerTurnCtr).PassGridClicked(gx, gy);
		}
	}
}