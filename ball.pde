

// ball variables
int ballD = 50;         
float ballQuickness = 2.0;
float ballSpeedChangable = 1.5;
float ballBigness = 1.3;

// ONE array for all the balls here
ArrayList<Ball> balls = new ArrayList<Ball>();

void generateBalls() { // every frame, there is a probability that an astroid will spawn
  ballSpawnRate+=0.003;
  ballQuickness+=0.0005;
  ballBigness+=0.0003;
  float r = random(10);
  if (r<ballSpawnRate)
    balls.add(new Ball());
}

void moveBalls()
{
  for (int i=0; i<balls.size (); i++)
  {
    if (balls.get(i).moveBalls())
    {
      balls.remove(i);
      i--;
    }
  }
}

class Ball // an object to store the ball info, because 13 separate arrays are just too much
{
  float ballX;
  float ballY;
  float ballVelX;
  float ballVelY;
  float ballScale;
  int ballTexId;

  float ballRotation;
  float ballRotationVel;
  
  boolean ore; // if the ball contains diamond ore

  Ball() // setup the ball
  {
    generateBall();
  }

  // move the Balls
  void generateBall() {
    /*TASK 6
     10. Give initial values (random number from 0 to the width of the screen ) to all the 100 bulletX (use a for loop).
     10. Also inside the for loop, give initial values (random number from 0 to the (-8) times the height of the screen )
     to all the 100 bulletY. 
     NOT: Initially all bullets are off screen, that's why their Y coordinates are negative. 
     The 100 balls are spread over 8 screens to give about 12 balls per screen, otherwise their concentration is too high
     and the space ship will be hit contantly.
     11. Also inside the for loop, give initial value (true) to all the 100 ballVisible variables. 
     Since the balls are visible until hit by a bullet ballVisible should be true at the beginning.
     */
    ballX = int(random(width));
    ballY = -50;
    ballVelX = random(-0.2,0.2);
    ballVelY = random(1.7,3);
    ballTexId = (int)random(5);
    ballScale = random(0.3, ballBigness);
    ballRotation = random(0, TWO_PI);
    ballRotationVel = random(-0.04,0.04);
    if(random(10)<2)
      ore = true;
  }
  boolean moveBalls() {
    /*  TASK 8
     13. Use a for loop to move the balls down (use the speed of the ball)
     14. Check if the ball has reached the bottum of the screen and if so  
     return it in the starting possition 7 screens above : (-7) * height 
     */
    ballX += ballVelX * ballQuickness * ballSpeedChangable;
    ballY += ballVelY * ballQuickness * ballSpeedChangable;
    ballRotation += ballRotationVel;
    if (ballY >= height+ballD) {
      return true;
    }
    return false;
  }
  void display()
  {
    pushMatrix();
    translate(ballX, ballY);
    scale(ballScale, ballScale);
    rotate(ballRotation);
    image(asdroidTex[ballTexId], 0, 0);
    if(ore)
      image(oreTex, 0, 0);
    popMatrix();
  }
}

