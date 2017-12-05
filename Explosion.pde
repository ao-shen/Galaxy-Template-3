
ArrayList<Effect> allOfTheEffectsTogether = new ArrayList<Effect>(); // an array to store all the explosions

Animation [] explosionAnime = new Animation[10]; // the sprites of all the explosions

void initAnimations()
{
  // loads animations
  explosionAnime[0] = new Animation("explosion/0/frame_", "_delay-0.03s.gif", 0, 23, 80); // loads all the sprites
  explosionAnime[1] = new Animation("explosion/1/frame_", "_delay-0.1s.gif", 0, 16, 80); // of the explosion
  explosionAnime[2] = new Animation("explosion/2/frame_", "_delay-0.1s.gif", 0, 10, 80); 
  explosionAnime[3] = new Animation("explosion/3/frame_", "_delay-0.05s.gif", 0, 25, 80); 
  explosionAnime[4] = new Animation("explosion/4/frame_", "_delay-0.08s.gif", 0, 14, 80); 
  explosionAnime[5] = new Animation("explosion/5/frame_", "_delay-0.04s.gif", 0, 10, 80); 
  explosionAnime[6] = new Animation("explosion/6/frame_", "_delay-0.1s.gif", 0, 14, 80); 
  explosionAnime[7] = new Animation("explosion/7/frame_", "_delay-0.05s.gif", 0, 23, 80); 
  explosionAnime[8] = new Animation("explosion/8/frame_", "_delay-0.06s.gif", 0, 18, 80); 
  explosionAnime[9] = new Animation("explosion/9/frame_", "_delay-0.1s.gif", 0, 8, 80);
}

void displayEffects() { // loops through all the explosion and display them
  for (int i = allOfTheEffectsTogether.size ()-1; i>=0; i--) {
    allOfTheEffectsTogether.get(i).display();
    if (allOfTheEffectsTogether.get(i).isDone()) // if the explosion is over
      allOfTheEffectsTogether.remove(i); // REMOVE IT
  }
}

class Animation // a storage for a gif ( a bunch of pngs), and allows for easy management
{
  PImage [] arrOfImages; // store the images

  float curFrame; // current frame of the sprite

  float size; // size of the sprite

  boolean done; // if the animation is done playing

  int alpha1; // the transparency of the sprite

  int startMillis; // the time in miliseconds when the animation started

  float speed; // the speed which the animation plays

  // constructor
  Animation(String fileName, String fileEnd, int start, int end, float s1)
  {
    size = s1;
    arrOfImages = new PImage[end-start+1];
    for (int i=start; i<=end; i++) // loads all the images for the sprite
    {
      arrOfImages[i-start] = loadImage(fileName + "" + i + fileEnd);
      arrOfImages[i-start].resize((int)s1, (int)s1);
      speed = 1;
    }
    done = false; // setup EVERYTHING
    curFrame = 0;
    alpha1 = 255;
    startMillis = millis();
  }

  void blendAlpha(int a1)
  {
    alpha1 = a1; // changes the transparency of the sprite
  }

  boolean isDoneForFrame(int f1)
  {
    return f1>=arrOfImages.length; // checks if f1 is a frame in this sprite
  }

  boolean isDone()
  {
    return done; // returns if the animation is done displaying all its frames
  }

  void setSpeed(float s1) // sets the speed of the animation
  {
    if (s1 == 0)
    {
      speed = MAX_FLOAT;
      //done = true;
    } else
    {
      speed = s1;
    }
    startMillis = millis();
  }

  void setFrameTo(int f1) // manually set the current frame of the sprite
  {
    curFrame = f1;
    done = false;
  }

  void resetCurFrame() // automatically reset the current frame of the sprite
  {
    curFrame = 0;
    done = false;
    startMillis = millis();
  }

  void displayFrame(float x1, float y1, int f1) // manually display the freaking frame of the sprite
  {
    tint(255, alpha1);
    image(arrOfImages[f1], x1, y1);
    noTint();
  }

  void display(float x1, float y1) // automatically display the sprite
  {
    tint(255, alpha1);
    image(arrOfImages[(int)curFrame], x1, y1);
    noTint();
    if (millis()-startMillis>speed*100)
    {
      startMillis = millis();
      curFrame++;
    }
    if ((int)curFrame>=arrOfImages.length)
    {
      done = true;
      curFrame = curFrame%arrOfImages.length;
      startMillis = millis();
    }
  }
}

class ExplosionEffect extends Effect // object of an explosion effect
{
  float exScale; // size of the explosion
  
  int color1; // the type of the explosion

  ExplosionEffect(int id1, float x1, float y1) // constructor
  {
    super(id1, x1, y1);
    
    explosound[(int)random(6)].trigger();
    exScale = random(0.5, 1);
    color1 = (int)random(6)*42;
  }

  void display() // display the explosion
  {
    //tint(color1,255,255);
    pushMatrix();
    translate(x, y);
    scale(exScale, exScale);
    image(explosionAnime[animeId].arrOfImages[curFrame],0,0);
    if (frameCount%4==0)
      curFrame++;
    if (explosionAnime[animeId].isDoneForFrame(curFrame))
      done = true;
    popMatrix();
  }
}

class Effect // effect is independant and needs not manual display, cuz an array keeps track of them and deletes them once they finish displaying
{
  float x;
  float y;

  int curFrame;

  int animeId;

  boolean done;

  Effect(int id1, float x1, float y1) // is it really an effect?
  {
    animeId = id1;
    x = x1;
    y = y1;
    curFrame = 0;
    done = false;
    screenShakeTimer += 3;
  }

  boolean isDone() // is it really done tho?
  {
    return done;
  }

  void display() // who need to be displayed anyways?
  {
  }
}

