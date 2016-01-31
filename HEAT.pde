// World Vars
float worldTemp = 30;

// Camera Vars
float camX = height/2;
float camY = width/2;

// Control Vars
ArrayList<Character> keys = new ArrayList<Character>();

//Player Vars
float playerX = 0;
float playerY = 0;
float playerRot = 0;
float playerTemp = 100;
float playerSpeed = 2; // the players top speed not current speed

// Prop Vars
ArrayList<Prop> props = new ArrayList<Prop>();

void setup() {
  size(800, 800);
  
  props.add(new Prop(-50, 50));
  props.add(new Prop(50, -50));
  props.add(new Prop(-50, -50));
  props.add(new Prop(50, 50));
  
}

void draw() {
  background(255);
 // camX = mouseX;
 // camY = mouseY;
  text("x: " + playerX + " y: " + playerY, 10, 10);
  translate(-camX, -camY);
  
  // draw shit
  
  for(Prop p : props) {
    p.draw();
  }
  drawPlayer();
  
  // control shit
  playerMove();
  playerFace();
  cameraControl();
}

void playerFace() {
  PVector mLoc = new PVector(mouseX, mouseY);
  PVector screen = new PVector(width/2, height/2);
  PVector b = PVector.sub(mLoc, screen);
  
  if(b.x == 0) {
    if(b.y > 0) {
      playerRot = PI/2;
    } else {
      playerRot = -PI/2;
    }
  } else {
    float p = 0;
    
    if (b.x < 0) {
      p = PI;
    }
    
    playerRot = (float) Math.atan(b.y / b.x) + p;
  }
}
  
void playerMove() {
  for(char k : keys) {
    switch (k) {
      case 'W':
      case 'w':
        playerY -= playerSpeed;
        break;
      
      case 'S':
      case 's':
        playerY += playerSpeed;
        break;
      
      case 'A':
      case 'a':
        playerX -= playerSpeed;
        break;
      
      case 'D':
      case 'd':
        playerX += playerSpeed;
        break;      
    }
  }
}

void keyPressed() {
  char k = key;
  if(!keys.contains(k)) {
    keys.add(k);
  }
}

void keyReleased() {
  char k = key;
  if(keys.contains(k)) {
    keys.remove( (Character) k);
  }  
}

void cameraControl() {
  camX = playerX + mouseX - width;
  camY = playerY + mouseY - height;
}

void drawPlayer() {
  pushMatrix();
  
  // translate to world location
  translate(playerX, playerY);
  rotate(playerRot);
  
  // color to indicate temp
  fill((playerTemp/ 100) * 255, 0, (100 / playerTemp) * 255);
  
  // draw circle to indicate location
  noStroke();
  ellipse(0, 0, 20, 20);
  
  // draw arrow to indicate direction
  stroke(0);
  line(8, 0, -5, 0);
  line(8, 0, 3, -5);
  line(8, 0, 3, 5);
  
  popMatrix();
  
}

class Prop {
  
  float locX;
  float locY;
  
  Prop(float x, float y) {
    this.locX = x;
    this.locY = y;
  }
  
  void draw() {
    pushMatrix();
    
    translate(locX, locY);
    
    fill(0);
    rect(0, 0, 20, 20);
    
    popMatrix();
  }
}