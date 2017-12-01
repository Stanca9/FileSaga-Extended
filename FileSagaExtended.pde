PImage cursorImage;
PFont myFont;

SceneManager sm;

void setup(){
	sm = new SceneManager();
	size(1001, 751,P2D);//size of the window
	noSmooth();//turns off anti-aliasing
	cursorImage = loadImage("cursor.png");//sets the cursor imag
	cursor(cursorImage,0,0);
	//cursor(CROSS);
	while(!focused){}//waits until the player is clicked in the window
	myFont = createFont("pcsenior.ttf", 100);//sets the font
	textFont(myFont);
	
	sm.loadScene("menu");//first loads the menu scene
	///We migth wanna change this so some fancy animation then go in the menu
}

void draw(){
	sm.update();//lets the scene manager display
}

class SceneManager {
	private String[] scenes = {"menu", "settings", "singleplayer", "multiplayer"};//list of allowed scenes
	private String currentScene;//string to store teh current scene that is displaying
	
	//all the scene objects
	private MenuScene menu;
	private SingleplayerScene sp;
	private MultiplayerScene mp;
	private SettingsScene settings;
	
	//initialise eache scene object here
	SceneManager(){
		menu = new MenuScene();
		sp = new SingleplayerScene();
		mp = new MultiplayerScene();
		settings = new SettingsScene();
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
	
	void update(){//displays the current scene
		switch(currentScene){
			case "menu": menu.update(); break;
			case "settings": settings.update(); break;
			case "multiplayer": mp.update(); break;
			case "singleplayer": sp.update(); break;
		}
	}
}
