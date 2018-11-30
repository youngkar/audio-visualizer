import ddf.minim.*;
import ddf.minim.analysis.*;
import controlP5.*;
 
Minim minim;
AudioPlayer player;
AudioMetaData meta;
BeatDetect beat;
int  r = 500;
float rad = 70;
int playerType;

ControlP5 cp5;

float x;
float y;

void setup()
{
  size(displayWidth, displayHeight, P3D);
  //size(600, 400);
  minim = new Minim(this);
  player = minim.loadFile("summer (1).mp3");
 // player = minim.loadFile("Kodaline - All I Want (with lyrics).mp3");
 // meta = player.getMetaData();
 // beat = new BeatDetect();
  //player.loop();
  //player.play();
  playerType = 1; 
  
  cp5 = new ControlP5(this);
    cp5.addButton("PLAY")
       .setPosition(width/2-25, height*3/4)
       .setSize(50,50);
    cp5.addButton("prev").setPosition(width/2-105,height*3/4).setSize(40,40);
    cp5.addButton("next").setPosition(width/2+65,height*3/4).setSize(40,40);
}

void draw() {
  background(50);
    //x = abs(player.left.get(songPos)*r);
    //println(x);
    //y = abs(player.left.get(songPos)*r);
    //println(y+"\n");
    noStroke();
    switch (playerType) {
      case 0:
      for (int songPos = 0 ; songPos < player.bufferSize() ; songPos++) {
        for(int p = 0; p<width; p+=28)
          {
            fill(100,abs(player.left.get(songPos))*100,abs(player.right.get(songPos))*255);
            float m = random(0,200);
            rect(p,height/2,20,player.left.get(songPos)*m);
          }
      }
        break;
      case 1:
      for (int songPos = 0; songPos < player.bufferSize() ; songPos++) {
        float radius = abs(player.mix.get(songPos));
        float m = random(20,320);
        fill(radius*255, radius*100, radius*180);
        ellipse(songPos+m % width, height/2, radius*100, radius*100);
      }
      break;
      case 2:
      for (int songPos = 0; songPos< player.bufferSize() ; songPos++) {
        float r = abs(player.mix.get(songPos))*500.0;
        fill(100,200,230);
        shapeMode(CENTER);
        ellipse(width/2, height/2, r, r);
        fill(0);
        ellipse(width/2, height/2, r/2, r/2);
        
        if (r > 200) {
          for (int x=0; x<width; x+=100) {
            fill(40,100,10);
            rect(x, height/4, 10, 10);
          }
        }
        if (r > 250) {
          for (int x=0; x<width; x+=300) {
            fill(140,80,80);
            rect(x, height*3/4, 20,20);
          }
        }
        if (r > 300) {
          for (int x=8 ; x<width; x+=350) {
            fill(200,40,200);
            rect(x, height/2, 60,60);
          }
        }
        
      }
      default:
      break;
    }

  fill(255, 40, 10);
  //rectMode(CENTER);
  //box(40, y, 50);
  
  // line(width/2, height/2, width/2, height/2-x);
}

void controlEvent(ControlEvent ce) {
   if(ce.isController()) { 
 
     print("control event from : "+ce.getController().getName());
     println(", value : "+ce.getController().getValue());
   }
}
