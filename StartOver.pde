

// start screen timer
int startScreenTimer = 600;
int tmpX=0, tmpY=0;
void displayStartScreen() {
  startScreenTimer--;
  tmpX += random(-2, 2);
  tmpY += random(-2, 2);
  translate(tmpX, tmpY);
  // draws a half transparent background for fading effect
  fill(noise(startScreenTimer)*255, 30);
  rect(0, 0, width, height);
  fill(0, 255, 100);
  textSize(37);
  int textDuration = 70; 
  tmpX += random(-2, 2);
  tmpY += random(-2, 2);
  translate(tmpX, tmpY);
  if (startScreenTimer<8*textDuration)
    text("Galaxy", width/2, height/2-100);
  tmpX += random(-2, 2);
  tmpY += random(-2, 2);
  translate(tmpX, tmpY);
  if (startScreenTimer<6*textDuration)
    text("A Game by Alex Shen", width/2, height/2);
  tmpX += random(-2, 2);
  tmpY += random(-2, 2);
  translate(tmpX, tmpY);
  if (startScreenTimer<4*textDuration)
    text("Powered By Processing", width/2, height/2+150);
  tmpX += random(-2, 2);
  tmpY += random(-2, 2);
  translate(tmpX, tmpY);
  fill(0, constrain(255-startScreenTimer, 0, 500));
  rect(0, 0, width, height);
  if(startScreenTimer<=0) {
    introSound.close();
    backSound.loop();
  }
}


void displayGameoverScreen() {
  timeSinceDead++;
  // draws a half transparent background for fading effect
  fill(255, 5); 
  rect(0, 0, width, height);
  fill(0);
  textSize(47);
  int textDuration = 120; // every 120 frames the text changes in the gameover screen
  if (timeSinceDead<textDuration)
    text("U DIED", width/2, height/2);
  else if (timeSinceDead<textDuration*2)
    text("GG", width/2, height/2);
  else if (timeSinceDead<textDuration*3)
    text("dat wus a gr8 game m9", width/2, height/2);
  else if (timeSinceDead<textDuration*4)
    text("butt u need 2 get better nxt tim", width/2, height/2);
  else if (timeSinceDead<textDuration*5)
    text("still u were kill", width/2, height/2);
  else if (timeSinceDead<textDuration*6)
    text("R .   I .   P .", width/2, height/2);
  else {
    textSize(37);
    text("hit dat space bar if u dare to get ReKt again", width/2, height/2);
  }

  // display the score and highscore
  textSize(11);
  text("Score: "+score, width/2, height-110);    
  text("Highscore: "+highScore, width/2, height-90);  

  // and other texts
  textSize(12);
  text("press SPACE to skip", width/2, height-10);
}

