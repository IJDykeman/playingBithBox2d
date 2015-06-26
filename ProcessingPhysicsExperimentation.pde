// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2011
// Box2DProcessing example

// Basic example of falling rectangles

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

// A reference to our box2d world
Box2DProcessing box2d;

// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;
// A list for all of our rectangles
ArrayList<Lollipop> pops;
ArrayList<Planet> planets;
Lollipop player;

float mouseWheelValue = 0;

boolean thrusting = false;
boolean clockwiseTurning = false;
boolean counterClockwiseTurning = false;
boolean stopping = false;

void setup() {
  size(1640,900);
  smooth();
  
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this,20);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, 0);

  // Create ArrayLists	
  pops = new ArrayList<Lollipop>();
  planets = new ArrayList<Planet>();
  boundaries = new ArrayList<Boundary>();

  // Add a bunch of fixed boundaries
  //boundaries.add(new Boundary(width/4,height-5,width/2-50,10,0));
  //boundaries.add(new Boundary(3*width/4,height-50,width/2-50,10,0));
  
 // boundaries.add(new Boundary(width/2,5,width,10,PI));
  //boundaries.add(new Boundary(width/2,height-5,width,10,PI));
 // boundaries.add(new Boundary(width-5,height/2,10,height,0));
 // boundaries.add(new Boundary(5,height/2,10,height,0));
  player = new Lollipop(500,500);
    pops.add(player);

}

void draw() {  
  pushMatrix();
  
  translate(-player.getPixelLocation().x, -player.getPixelLocation().y);
  
  translate(width/2, height/2);
  scale((sin(frameCount/20.0) +2)+.2);
  //scale(3);
  
  //translate(player.getLocation().x,player.getLocation().y);
  println(mouseWheelValue);
  background(0);
  if(thrusting){
    player.thrust();
  }
  if(clockwiseTurning){
    player.applyTorque(-3);
  }
  if(counterClockwiseTurning){
    player.applyTorque(3);
  }  
  if(!clockwiseTurning && !counterClockwiseTurning){
    player.stopRotation(7);
  }
  if(stopping){
    player.stopTranslation();
  }  
  // We must always step through time!
  box2d.step();

  // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }

  // Display all the people
  for (Lollipop p: pops) {
    p.display();
  }

  for (Planet p: planets) {
    p.display();
  }
  
  popMatrix();
}

void mousePressed() {
  Vec2 mouseLoc = mouseLocationInWorldSpace();
  //Lollipop p = new Lollipop(mouseLoc.x,mouseLoc.y);
  //pops.add(p);
  Planet planet = new Planet(mouseLoc.x,mouseLoc.y);
  planets.add(planet);
}

void keyPressed(){
  if(key == 'W' || key == 'w'){
    thrusting = true;
  }
  if(key == 'A' || key == 'a'){
    counterClockwiseTurning = true;

  }
  if(key == 'D' || key == 'd'){
    clockwiseTurning = true;
  }
  if(key == 'Q' || key == 'q'){
    stopping = true;
  }
}

void keyReleased(){
  if(key == 'W' || key == 'w'){
    thrusting = false;
  }
  if(key == 'A' || key == 'a'){
    counterClockwiseTurning = false;
  }
  if(key == 'D' || key == 'd'){
    clockwiseTurning = false;
  }
  if(key == 'Q' || key == 'q'){
    stopping = false;
  }
}

void mouseWheel(MouseEvent event) {
  mouseWheelValue += event.getCount();
}

Vec2 mouseLocationInWorldSpace(){
  return new Vec2 (mouseX+player.getPixelLocation().x-width/2,mouseY + player.getPixelLocation().y-height/2);
}

