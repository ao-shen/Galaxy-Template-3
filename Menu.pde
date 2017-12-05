
// textures of the buttons
PImage buttonTex;
PImage buttonPressedTex;

// if the menu button is pressed
boolean menuButtonPressed = false;

// if the game is pause
boolean paused = false;

// the two buy button
Button buyMissile;
Button buyLaser;

// the two variables that the buy buttons buy the increase/decrease
int missileRechargeTime = 100;
int laserCannonCount = 1;

void initMenu() { // setup the menu
  buttonTex = loadImage("button.png"); // load all the images
  buttonTex.resize(140,40);
  buttonPressedTex = loadImage("button_pressed.png");
  buttonPressedTex.resize(140,40);
  
  buyMissile = new Button(50,200,"BUY NOW"); // create all the buttons
  buyLaser = new Button(50,300,"BUY NOW");
}

void clickedHUD() { // excutes when mouse is pressed
  if(mouseX<140&&mouseY>height-40) { // checks if the menu button is pressed
    menuButtonPressed = true;
    paused = !paused;
  }
  if(paused) { // and if the menu is displaying, check if the buy buttons are pressed
    if(buyMissile.isClicked()) {
      if(mineralChange(-(101-missileRechargeTime)))
        missileRechargeTime -= 15;
    }
    if(buyLaser.isClicked()) {
      if(mineralChange(-(int)pow(laserCannonCount,4)))
        laserCannonCount += 1;
    }
  }
}

void releasedHUD() { // update all the button textures
  menuButtonPressed = false;
  buyMissile.pressed = false;
  buyLaser.pressed = false;
}

void displayHUD() { // display the menu
  imageMode(CORNER);
  
  if(paused) // if the menu is open
    displayMenu(); // display it
  
  if(menuButtonPressed) // if a button is pressed display the pressed texture
    image(buttonPressedTex,0,height-40);
  else
    image(buttonTex,0,height-40);
    
  fill(16,100,255);
  textSize(18);
  if(!paused) // display the menu button text
    text("Help/Shop",70,height-15);
  else
    text("Resume",70,height-15);
  
  //imageMode(CORNER);
  
  // displays score
  textSize(11);
  text("SCORE: "+score,width/2,40);
}

void displayMenu() { // if the menu is open, display it
  background(50);
  
  textAlign(LEFT);
  textSize(32);
  
  buyMissile.display(); // display the button and their description
  image(mineralTex, 200, 203);
  text(" X "+((101-missileRechargeTime))+"  Lower the missile recharge time. \nCurrent recharge time: "+missileRechargeTime,235,225);
  buyLaser.display();
  image(mineralTex, 200, 303);
  text(" X "+((int)pow(laserCannonCount,4))+"  Raise the laser cannon count. \nCurrent cannon count: "+laserCannonCount,235,325);
  
  text("HELP",235,420);
  text("Use A,S,D,W to move left, down, right, and up",235,450);
  text("Use left mouse click to fire lasers",235,480);
  text("Use right mouse click to fire missiles",235,510);
  
  textAlign(CENTER);
  
  pushMatrix(); // displaying my precious diamonds
  translate(10, 10);
  scale(1.2, 1.2);
  image(mineralTex, 0, 0);
  textSize(18);
  fill(150,50,255);
  text(minerals,55,20);
  popMatrix();
}

class Button // an object of a button
{
  int x;
  int y;
  boolean pressed;
  
  String title;
  
  Button(int x1,int y1,String str1) { // button!
    x = x1;
    y = y1;
    title = str1;
    pressed = false;
  }
  
  void display() { // display button!
    textAlign(CENTER);
    if(pressed)
      image(buttonPressedTex,x,y);
    else
      image(buttonTex,x,y);
      
    fill(16,100,255);
    textSize(18);
    text(title,x+70,y+25);
    textAlign(LEFT);
  }
  
  boolean isClicked() { // the button has been clicked???????? IDK, find out through this function
    if(mouseX<x+140&&mouseX>x&&mouseY<y+40&&mouseY>y) {
      pressed = true;
      return true;
    }
    return false;
  }
}
