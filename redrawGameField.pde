

int starBackYPos = 0;

void redrawGameField() {

  /*  TASK 7
   12. Use a for loop to check each of t h e 100 balls if they are visible or not.
   If ballVisible is true for this perticular ball, draw the ball on the screen. To do this,
   declare the fill color of your chice and draw a round shape using the ballX and ballY coordinates
   of this perticular ball, as well as its Diameter (dsee the varianle declared at the top).
   */
  starBackYPos+=5;
  if (starBackYPos>starsBackTex.height)
    starBackYPos = 0;

  background (invincibleTimer); // display background
  tint(255,130);
  image(starsBackTex, 0, starBackYPos);
  image(starsBackTex, 0, starBackYPos-starsBackTex.height);
  noTint(); 

  imageMode(CENTER);
  
  displayParticles(); // display particles
  
  for (int i=0; i<balls.size (); i++) // display balls
  {
    balls.get(i).display();
  }
  for(int i=0;i<bullets.size();i++) // display bullets
  {
    bullets.get(i).display();
  }

  pushMatrix(); // display ship
  translate(shipX, shipY);
  scale(0.6,0.6);
  rotate(shipVelX/10.0);
  if(invincibleTimer>0) {
    tint(255,(sin(invincibleTimer/5.0)+1)*255);
    invincibleTimer--;
  }
  image(planeTex[curPlaneFrame], 0, 0);
  if(frameCount%5==0) {
    curPlaneFrame++;
    if(curPlaneFrame>=planeTex.length)
      curPlaneFrame = 0;
  }
  popMatrix();
  noTint();
  
  displayLives(); // display lives
  
  displayEffects(); // display effects

  imageMode(CORNER);
}

