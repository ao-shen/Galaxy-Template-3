
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim; // more stuff

AudioSample laserSound;
AudioSample [] explosound = new AudioSample[6]; // a lot of sounds and shit

AudioPlayer sadSound; // gameover music
AudioPlayer backSound; // normal music
AudioPlayer introSound; // intro music

void initSounds() { // gotta setup all the setup 
  minim = new Minim(this); // setup this
  
  laserSound = minim.loadSample("laser.mp3"); // setup that
  sadSound = minim.loadFile("sad.mp3");
  backSound = minim.loadFile("back.mp3"); // loading some sounds
  introSound = minim.loadFile("intro.mp3"); // 2 maybe 3 music files
  introSound.play();
  
  for(int i=0;i<explosound.length;i++) { // setup some of those
    explosound[i] = minim.loadSample("explosound/"+i+".mp3");
  }
}
