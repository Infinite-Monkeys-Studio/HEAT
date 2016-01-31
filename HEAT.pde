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

//props
//ArrayList<Prop> props = new ArrayList<Prop>();

void setup() {
  size(800, 800);
}

void draw() {
  background(255);
 // camX = mouseX;
 // camY = mouseY;
  
  translate(-camX, -camY);
  
  // draw shit
  drawPlayer();
  
  
  // control shit
  playerControl();
  cameraControl();
}

void playerControl() {
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