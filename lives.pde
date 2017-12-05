
import java.math.BigInteger;

// stat variables
int invincibleTimer = 0;
int lives;
BigInteger score = new BigInteger("0");
BigInteger highScore = new BigInteger("0");
int minerals = 0;
int timeSinceDead = 0;
float ballSpawnRate = 0.1;

void initLives() { // setup and reset lives and score
  lives = 3;
  invincibleTimer = 0;
  timeSinceDead = 0;
  score = BigInteger.ZERO;
  screenShakeTimer = 0;
}

void changeScore(BigInteger c1) { // increase/decrease score

  score = score.add(c1);
}

boolean mineralChange(int c1) { // increase/decrease diamonds
  if(minerals+c1<0)
    return false;
  minerals += c1;
  
  return true;
}

void isHitByBall() { // excutes when the player collides with ball
  lives--;
  invincibleTimer = 100; 
  shipX = 400;
  shipY = 600-shipH;
  ballSpawnRate = 0.1;
  ballQuickness = 2.0;
  ballBigness = 1.3;
  balls.clear();
  bullets.clear();
  if (lives<=0) { // when play has no lives left, reset everything
    lives = 0;
    timeSinceDead = 0;
    sadSound.rewind();
    sadSound.play();
    if(highScore.compareTo(score)<0) {
      highScore = BigInteger.ZERO;
      highScore = highScore.add(score);
    }
  }
}

boolean displayLives() { // display lives and diamonds
  imageMode(CORNER);
  for (int i=0; i<lives; i++) { // display lives
    pushMatrix();
    translate(width-40-25*i, 10);
    scale(0.3, 0.3);
    image(planeTex[curPlaneFrame], 0, 0);
    popMatrix();
  }
  pushMatrix(); // display diamonds
  translate(10, 10);
  scale(1.2, 1.2);
  image(mineralTex, 0, 0);
  textSize(18);
  fill(150,50,255);
  text(minerals,55,20);
  if(keys['G']) // another hack to cheat in money
    minerals++;
  popMatrix();
  
  imageMode(CENTER);
  

  if (lives<=0) // if player is dead
    return true;
  return false;
}

