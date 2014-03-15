int sizeX = 800;
int sizeY = 600;

String backgroundPath = "graphics/background.jpg";
PImage background;
String backgroundPrompt = "Wybierz plik z tłem";

String screenShotLocation = "screens/";
String screenShotFileName = "screen-";
int screenShotCounter = 0;
String screenShotExtension = ".png";

int prevMouseX = 0, prevMouseY = 0;
int segmentLength = 10;

int[] dxs = new int[20];
int[] dys = new int[20];

/* --- INITIALIZATION --- */
void setup() {
  for (int i=0 ; i<dxs.length ; i++) {
    dxs[i] = dys[i] = 0;
  }
  
  size(sizeX, sizeY);
  smooth();
  background = loadImage(backgroundPath);
  
  image(background, 0, 0, sizeX, sizeY);
}



/* --- MAIN LOOP --- */
void draw() {
  float tmpX = 0, tmpY = 0;
  float angle = 0;
  
//  if (    mouseY != prevMouseY
//      ||  mouseX != prevMouseX) {
    
    /* Count delta of move */
    shiftDeltas();
    dys[0] = mouseY - prevMouseY;
    dxs[0] = mouseX - prevMouseX;
//  }
    
    /* Drawing */
    tmpX = mouseX;
    tmpY = mouseY;
    
    image(background, 0, 0, sizeX, sizeY);
    for (int i=0 ; i < dxs.length ; i++) {
      angle = atan2(dys[i], dxs[i]);
      drawSegment((int)tmpX, (int)tmpY, angle);
      tmpX -= cos(angle) * segmentLength;
      tmpY -= sin(angle) * segmentLength;
//      if (i > 0) {
//        dys[i] = dys[i - 1];
//        dxs[i] = dxs[i - 1];
//      }
    }
    
    prevMouseX = mouseX;
    prevMouseY = mouseY;
  //}
}


/* --- EXIT --- */
void exit() {
  super.exit();  
}

/* --- Event handlers --- */
void keyPressed() {
  switch (key) {
    case 'b':
    case 'B':
      chooseBackground();
      break;
      
    case 'p':
    case 'P':
      takeScreenShot();
      break;
  }
}

/* --- Helper functions --- */
void chooseBackground() {
  selectInput(backgroundPrompt, "changeBackground");
}

void changeBackground(File selectedFile) {
  if (selectedFile != null) {
    background = loadImage(selectedFile.getAbsolutePath());
  }
}

void takeScreenShot() {
  saveFrame(screenShotLocation + screenShotFileName + screenShotCounter + screenShotExtension);
  screenShotCounter++;
}

void drawSegment(int x, int y, float angle) {
  pushMatrix();
  
  // move coords
  translate(x, y);
  rotate(angle);
  
  // draw element
  ellipse(0, 0, 30, 20);
//  stroke(color(0, 0, 0, 255));
//  strokeWeight(10);
//  line(0, 0, segmentLength, 0);
  
  popMatrix();
}

void shiftDeltas() {
  for (int i = (dxs.length - 2) ; i >= 0 ; i--) {
    dxs[i+1] = dxs[i];
    dys[i+1] = dys[i];
  }
}

