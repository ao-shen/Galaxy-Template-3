//ALEXALEXALEXALEXALEXALEXALEXALEXALEXALEXALEXALEXALEXALEXALEXALEXALEXALEXALEXALEXALEX
//
//   █████╗ ██╗     ███████╗██╗  ██╗    ███████╗██╗  ██╗███████╗███╗   ██╗
//  ██╔══██╗██║     ██╔════╝╚██╗██╔╝    ██╔════╝██║  ██║██╔════╝████╗  ██║
//  ███████║██║     █████╗   ╚███╔╝     ███████╗███████║█████╗  ██╔██╗ ██║
//  ██╔══██║██║     ██╔══╝   ██╔██╗     ╚════██║██╔══██║██╔══╝  ██║╚██╗██║
//  ██║  ██║███████╗███████╗██╔╝ ██╗    ███████║██║  ██║███████╗██║ ╚████║
//  ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝    ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝
//                                                                    
//  DATE: 5/24/2016
//  Galaxy
//  This is a galaxy game where you control a space ship and have to shoot and dodge astroid.
//  You have to try to get as much score as possible. You can also collect Diamonds and trade them for upgrades
//
//SHENSHENSHENSHENSHENSHENSHENSHENSHENSHENSHENSHENSHENSHENSHENSHENSHENSHENSHENSHENSHEN


// ship variables
int shipW = 30; // width of the ship
int shipH = 50; // height of the ship
float shipX = 400; // x coordinate of the ship          
float shipY = 600-shipH; // y coordinate of the ship
float shipVelX = 0; // horizontal velocity of the ship
float shipVelY = 0; // vertical velocity of the ship
float shipSpeed = 5; // speed of the ship

boolean triggerReleased = true; // determines if the shoot key is released            

// how long the screen will shake for from an explosion
int screenShakeTimer = 0;

// an array that holds the key input (ALL THE KEYS)
boolean[] keys = new boolean[256];   
// an array that holds the mouse input (ALL THE MICE)
boolean[] mouses = new boolean[256];  

// textures
PImage starsBackTex; // texture of the scrolling starry background
PImage missileTex; // texture of the missiles
PImage [] planeTex = new PImage[6]; // sprite of the ship
int curPlaneFrame = 0; // current frame for the sprite of the ship
PImage [] asdroidTex = new PImage[5]; // different varieties of the asdroids
PImage [] laserTex = new PImage[6]; // different colours for the lasers
PImage oreTex; // texture of the diamond ore
PImage mineralTex; // texture of the diamond

  /////////////////////////////////////////////
 // Main Program                            //
/////////////////////////////////////////////

void setup() {
  size(800, 600); // sets the size of the window of the game
  background(0); // changes the background to black
  noStroke(); // gets rid of the stroke
  colorMode(HSB); // changes the colour mode to HSB
  textAlign(CENTER); // changing the text align to center
  
  frameRate(50); // changes frame rate to 50
  
  initAnimations(); // setup the animations and sprites
  
  // load textures
  starsBackTex = loadImage("stars.png");
  starsBackTex.resize(width,height);
  missileTex = loadImage("missile.png"); // more textures
  missileTex.resize(20,40);
  for(int i=0;i<laserTex.length;i++){
    laserTex[i] = loadImage("laser/"+i+".png"); // MORE
    laserTex[i].resize(8,24);
  }
  for(int i=0;i<asdroidTex.length;i++){
    asdroidTex[i] = loadImage("asteroids/asteroid"+i+".png"); // EVEN MORE
  }
  for(int i=0;i<planeTex.length;i++){
    planeTex[i] = loadImage("plane/"+i+".png"); // SOOOOO MUUUCCCCCHHHH MOOOOOORRRRRREEEEEEEE
  }
  oreTex = loadImage("minerals/diamond_ore.png");
  oreTex.resize(30,30);
  mineralTex = loadImage("minerals/diamond.png"); // OVER 900000000000000000000000000 TEXTURES
  mineralTex.resize(30,30);
  
  // setup other things
  initSounds(); 
  initLives();
  initParticles();
  initMenu();
}

void draw() {
  
  if(startScreenTimer>0) { // begining of game
    displayStartScreen();
    return; // doesn't need to draw anything else, because it is the start screen
  }
  
  if(lives<=0) { // if the player is dead // the gameover screen
    displayGameoverScreen();
    return; // doesn't need to draw anything else, because the game is over
  }
  
  if(paused) { // if the menu is open
    displayHUD(); // display the menu
    return; // nothing else needs to be drawn
  }
  
  // shake the screen
  if(screenShakeTimer>0) {
    screenShakeTimer-=1;
    translate(random(-2,2),random(-2,2));
  }
  
  redrawGameField(); // draw game field
  
  generateBalls(); // spawn new astroids

  // move the ship with 'A' & 'D' KEYS
  if (keys['D']) {
    shipVelX += 0.6;
  } if (keys['A']) {
    shipVelX -= 0.6;
  }
  shipVelX *= 0.8;
  shipX += shipVelX * shipSpeed;
  shipX = (shipX+width)%width;
  // move the ship with 'S' & 'W' KEYS
  if (keys['S']) {
    shipVelY += 0.6;
  } if (keys['W']) {
    shipVelY -= 0.6;
  }
  shipVelY *= 0.8;
  shipY += shipVelY * shipSpeed;
  shipY = (shipY+height)%height;
  
  // shut bullets with LEFT MOUSE BUTTON
  if (mouses[LEFT] && triggerReleased) {         // triggerReleased is true when the SPACE bar is pressed
    triggerReleased = false;                // then it turns into false to prevent creating more then one bullet 
    laserSound.trigger(); // play the shoot laser sound
    fireBullet();
  } else if (mouses[LEFT]==false) {
    triggerReleased = true;
  }
  
  displayHUD(); // display the menu button
  
  moveBalls(); // move astroids
  moveBullets(); // move bullets
  checkCollision(); // check collision
}


void keyPressed() {
  // move the ship left / right with the arrow keys
  keys[keyCode] = true;
  
  if(key==']') // this is a hack to increase the laser cannon count without spending money
    laserCannonCount++;
  else if(key=='[')
    laserCannonCount--;
  laserCannonCount = constrain(laserCannonCount,1,9001);
}

void keyReleased() {
  keys[keyCode] = false;
  
  if(keyCode==' ') { // when the game is over, pressing space will restart the game
    if(lives<=0) {
      initLives(); // reset lives
      particles.clear(); // delete all particles
      allOfTheEffectsTogether.clear(); // delete basically everything
      sadSound.pause(); // stop the gameover music
    }
  }
}

void mousePressed() {
  mouses[mouseButton] = true;
  clickedHUD(); // tell the menu to check of any buttons are pressed
  if(mouseButton==RIGHT) {
    launchMissile(); // if right clicking, then fire missile
  }
}

void mouseReleased() {
  mouses[mouseButton] = false;
  releasedHUD();
}

