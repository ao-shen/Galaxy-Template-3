// bullet variables
int bulletW = 4;                             
int bulletH = 8;                             
float bulletSpeed = 12;
int currentBullet = 0; 

// ONE array for all the bullets here
ArrayList<Bullet> bullets = new ArrayList<Bullet>();

// fires two bullets at an angle away from the ship 
void fireBulletsWithAngle(float angleToFireBulletsIn) {
  for (int i=0; i<2; i++) { // loop through all the laser cannons
    Bullet b1 = new Bullet(shipX, shipY-20); // creates a new bullet object at the ship's location
    float finalAngle = 3*HALF_PI-angleToFireBulletsIn+i*2*angleToFireBulletsIn;
    b1.bulletVelX = shipVelX/8.0+random(-0.05, 0.05)+cos(finalAngle); // slightly random x velocity
    b1.bulletVelY = sin(finalAngle); // move up the screen
    bullets.add(b1); // add it to the array of all the bullets
  }
}

// fires bullets from ship
void fireBullet() {
  int c1 = laserCannonCount; // changes the number of laser cannons the ship has
  float d1 = -0.02;
  if (c1%2==1) {
    Bullet b1 = new Bullet(shipX, shipY-20); // creates a new bullet object at the ship's location
    b1.bulletVelX = shipVelX/8.0+random(-0.05, 0.05); // slightly random x velocity
    b1.bulletVelY = -1; // move up the screen
    bullets.add(b1); // add it to the array of all the bullets
  } else {
    for (int i=0; i<2; i++) { // loop through all the laser cannons
      Bullet b1 = new Bullet( shipX-20+i*40, shipY-20); // creates a new bullet object at the ship's location
      b1.bulletVelX = shipVelX/8.0-d1+i*d1*2+random(-0.05, 0.05); // slightly random x velocity
      b1.bulletVelY = -1; // move up the screen
      bullets.add(b1); // add it to the array of all the bullets
    }
  } 
  if (c1>=3) {
    fireBulletsWithAngle(radians(30));
  }
  if (c1>=5) {
    fireBulletsWithAngle(radians(75));
  }
  if (c1>=7) {
    fireBulletsWithAngle(radians(120));
  }
  if (c1>=9) {
    fireBulletsWithAngle(radians(60));
  }
  if (c1>=11) {
    fireBulletsWithAngle(radians(15));
  }
  if (c1>=13) {
    fireBulletsWithAngle(radians(45));
  }
}

//-------------------------------------------//
// a functions that calculates and returns the distance between two points as a decimal number
int distance (int x1, int y1, int x2, int y2) {
  return round(sqrt(pow((x1 - x2), 2) + pow((y1 - y2), 2)));
}
//-------------------------------------------//
// check for collison between the vidible bullets and visible balls using the distance function
// distance between the current bullet and ball
int dist;
void checkCollision() {
  for (int i=0; i<balls.size (); i++) {
    boolean ballExplode = false;
    for (int j=0; j<bullets.size (); j++)
    {
      if (i>=0 && j>=0) {
        dist = (int)dist(balls.get(i).ballX, balls.get(i).ballY, bullets.get(j).bulletX, bullets.get(j).bulletY);
        if (dist < balls.get(i).ballScale*ballD/2) { // if a astroid is colliding with a bullet
          if (balls.get(i).ore) {
            // if there is ore in the astroid, add it to the player's diamond count
            mineralChange(1);
          }
          // because the score is too big for an integer, a system object called BigInteger is needed to store a very big number
          BigInteger tmp = BigInteger.valueOf((long)balls.get(i).ballScale).multiply((BigInteger.valueOf((long)random(10, 50))).multiply(score.add(BigInteger.valueOf((long)1000)).divide(BigInteger.valueOf((long)1000))));
          changeScore(tmp);
          balls.get(i).ballScale*=0.8;
          if(bullets.get(j).bulletType==1) // if the bullet is a missile, deals extra damage
            balls.get(i).ballScale*=0.3;
            
          bullets.remove(j); // remove the bullet
          j--;
          
          if(balls.get(i).ballScale<0.5) {
            // add an explosion
            allOfTheEffectsTogether.add(new ExplosionEffect((int)random(10), balls.get(i).ballX, balls.get(i).ballY));
            balls.remove(i); // remove ball
            ballExplode = true; 
            i--;
          }
          continue;
        }
      }
    }
    if (ballExplode) // if ball is destroyed, dont check collision with the ship
      continue;
    if (invincibleTimer>0) // if invincible, also dont check
      continue;
    dist = (int)dist(balls.get(i).ballX, balls.get(i).ballY, shipX, shipY);
    if (dist < ballD/2+10) { // checks if astroid is colliding with ship
      // add sound effect to indicate a collision (optional)
      allOfTheEffectsTogether.add(new ExplosionEffect((int)random(10), balls.get(i).ballX, balls.get(i).ballY));
      allOfTheEffectsTogether.add(new ExplosionEffect((int)random(10), shipX, shipY));
      balls.remove(i);
      i--;
      isHitByBall();
    }
  }
}

void moveBullets() // moves all the bullets
{
  for (int i=0; i<bullets.size (); i++)
  {
    if (bullets.get(i).moveBullet())
    {
      bullets.remove(i);
      i--;
    }
  }
}

class Bullet // bullet object to store everything bullet
{
  float bulletVelX;    
  float bulletVelY; 
  float bulletX;
  float bulletY;

  int bulletTint;

  float bulletRotation;
  
  int bulletType; // 0 is laser, 1 is missile

  Bullet(float x1, float y1) // constructor
  {
    generateBullet(x1, y1);
    bulletType = 0;
  }

  // move the bullets
  //-------------------------------------------//
  void generateBullet(float x1, float y1) {

    /*TASK 2
     3. Give initial values (-50) to all the 100 bulletX and bulletY coordinates (use a for loop). 
     Initially all bullets are off screen so give them values -50 for the x and for the y coordinates
     4. Also inside the for loop, give initial value (false) to all the 100 bulltVisible variables. 
     Since the bulltes are not visible until the SPACE key is pressed bulletVisible should be false.
     */
    bulletX = x1;
    bulletY = y1;
    bulletTint = (int)random(6);
  }
  //-------------------------------------------//
  boolean moveBullet() { // move the bullet
    bulletY += bulletVelY * bulletSpeed;
    bulletX += bulletVelX * bulletSpeed;
    if (bulletY<-50||bulletY>height+50||bulletX<-50||bulletX>width+50)
      return true;
    return false;
  }
  void display() // display the bullet
  {
    bulletRotation = atan(bulletVelY/bulletVelX)+HALF_PI; // change the rotation of the bullet to match its direction
    pushMatrix();
    translate(bulletX, bulletY);
    rotate(bulletRotation);
    image(laserTex[bulletTint], 0, 0);
    popMatrix();
  }
}

