PImage cursorImage;
String fontPath = "lunchds.ttf";
PFont font025, font05, font075, font1, font2;

SceneManager sm;

void setup(){
	sm = new SceneManager();
	size(1010, 630,P2D);//size of the window
	noSmooth();//turns off anti-aliasing
	cursorImage = loadImage("cursor.png");//sets the cursor imag
	cursor(cursorImage,0,0);
	//cursor(CROSS);
	while(!focused){}//waits until the player is clicked in the window
	font025 = createFont(fontPath, 10);
	font05 = createFont(fontPath, 20);
	font075 = createFont(fontPath, 30);
	font1 = createFont(fontPath, 40);
	font2 = createFont(fontPath, 80);
	
	sm.loadScene("menu");//first loads the menu scene
	///We migth wanna change this so some fancy animation then go in the menu
}

void draw(){
	sm.draw();//lets the scene manager display
}

class SceneManager {
	private String[] scenes = {"menu", "settings", "singleplayer", "multiplayer", "credits"};//list of allowed scenes
	private String currentScene;//string to store teh current scene that is displaying
	
	//all the scene objects
	private MenuScene menu;
	private SingleplayerScene sp;
	private MultiplayerScene mp;
	private SettingsScene settings;
	private CreditsScene credits;
	
	//initialise eache scene object here
	SceneManager(){
		menu = new MenuScene();
		sp = new SingleplayerScene();
		mp = new MultiplayerScene();
		settings = new SettingsScene();
		credits = new CreditsScene();
	}
	
	void loadScene(String sceneToLoad){//changes the current scene
		boolean found = false;
		for(String s : scenes){//searches if the scene you tried to load is in the list of allowed scenes
			if(s == sceneToLoad){
				currentScene = sceneToLoad;
				found = true;
				break;
			}
		}
		if(!found){//if the scene you tried to load is not in the list of allowed scenes it thrws an error
			println("ERROR SceneManager: failed to load scene");
		}	
	}
	
	void draw(){//displays the current scene
		switch(currentScene){
			case "menu": menu.draw(); break;
			case "settings": settings.draw(); break;
			case "multiplayer": mp.draw(); break;
			case "singleplayer": sp.draw(); break;
			case "credits": credits.draw(); break;
		}
	}
}