
int timeLastMissileIsFired = 0; // pretty self explanatory

void launchMissile() { // FIRE THE MISSILE
  if(frameCount-timeLastMissileIsFired>missileRechargeTime) {
    timeLastMissileIsFired = frameCount;
    Missile m1 = new Missile(shipX, shipY-20);
    bullets.add(m1);
    for(int i=0;i<-missileRechargeTime/7;i++) {
      m1 = new Missile(shipX, shipY-20);
      bullets.add(m1);
    }
  }
}

class Missile extends Bullet // missile is just another bullet, but fancier
{
  float rotateSpeed;
  float moveSpeed;
  
  int dissapearingTimeLeft;
  
  Missile(float x1, float y1)
  {
    super(x1, y1);
    bulletType = 1;
    bulletVelY = -0.3;
    bulletRotation = PI + (random(PI)-HALF_PI);
    
    rotateSpeed = random(0.05,0.3);
    moveSpeed = random(0.7,1.7);
    dissapearingTimeLeft = (int)random(400,600);
  } 

  // move the missile
  //-------------------------------------------//
  boolean moveBullet() {
    float angle1 = degrees(atan2((mouseY-bulletY),(mouseX-bulletX))-HALF_PI); // FANCY TRIGONOMETRY
    float missileAngle = degrees(bulletRotation);

    if (missileAngle-angle1>180)  // MORE TRIGONOMETRY
      missileAngle -= 360;
    else if (missileAngle-angle1<-180) 
      missileAngle += 360;

    bulletRotation += radians(angle1-missileAngle)*rotateSpeed; // EVEN MORE TRIGONOMETRY
    bulletVelY = sin(bulletRotation+HALF_PI);
    bulletVelX = cos(bulletRotation+HALF_PI);

    bulletY += bulletVelY * bulletSpeed * moveSpeed;
    bulletX += bulletVelX * bulletSpeed * moveSpeed;
    bulletX = (bulletX+width)%width;
    
    dissapearingTimeLeft--;
    
    if (bulletY<-50||dissapearingTimeLeft<=0)
      return true;
    return false;
  }
  
  void display()
  {
    if(frameCount%1==0) {
      particles.add(new Particle(bulletX,bulletY,bulletTint*42,(bulletX+bulletY)/80.0)); // missiles adds particles
    }
    
    dissapearingTimeLeft--;
    pushMatrix();
    translate(bulletX, bulletY);
    rotate(bulletRotation+PI);
    tint(255,dissapearingTimeLeft*4);
    image(missileTex, 0, 0);
    noTint();
    popMatrix();
  }
}

