
// ONE array for all the bullets here
ArrayList<Particle> particles = new ArrayList<Particle>();

void initParticles() { // don't really need to setup the particles
  
}

void displayParticles() { // loops through and display ALLLLLLL THE PARTICLE,      I    S A I D      A L L     O F     T H E M
  for(int i=0;i<particles.size();i++) {
    if(particles.get(i).display()) {
      particles.remove(i);
      i--;
    }
  }
}

class Particle // bunch O' particles
{
  float posX;
  float posY;
  float darkness;
  int color1;
  float rotation;
 
  Particle(float x1, float y1, int c1, float r1) { // boring stuff, constructor
    posX = x1;
    posY = y1;
    darkness = random(200,255);
    color1 = c1;
    rotation = r1;
  }
  
  boolean display() { // display it, the particle of course
    darkness -= 7;
    if(darkness<0)
      return true;
    fill(color1+darkness/7.5,255,255,darkness);
    pushMatrix();
    translate(posX,posY);
    rotate(rotation);
    rect(-darkness/26,-darkness/26,darkness/13,darkness/13);
    popMatrix();
    return false;
  }
}
