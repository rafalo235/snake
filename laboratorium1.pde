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
int segmentLength = 4;

float[] xs = new float[50];
float[] ys = new float[50];

/* --- INITIALIZATION --- */
void setup() {
//  for (int i=0 ; i< xs.length ; i++) {
//    xs[i] = 0;
//    ys[i] = 0;
//  }
  size(sizeX, sizeY);
  smooth();
  background = loadImage(backgroundPath);
  image(background, 0, 0, sizeX, sizeY);
}



/* --- MAIN LOOP --- */
void draw() {
  float angle = 0, segmentWidth;
  int redGreen, i;
    
  /* Get actual coords */
  ys[0] = mouseY;
  xs[0] = mouseX;
    
  /* Drawing */
  image(background, 0, 0, sizeX, sizeY);
  for (i = 0 ; i < (xs.length - 1) ; i++) {
    angle = atan2(ys[i] - ys[i+1], xs[i] - xs[i+1]);
    xs[i+1] = xs[i] - cos(angle) * segmentLength;
    ys[i+1] = ys[i] - sin(angle) * segmentLength;
  }
  
  for (i = (xs.length - 2) ; i >= 0 ; i --) {
    angle = atan2(ys[i] - ys[i+1], xs[i] - xs[i+1]);
    segmentWidth = 10 - ((float)i / (float)xs.length) * ((float)i / (float)xs.length) * ((float)i / (float)xs.length) * 10;
    redGreen = 204 - (int) ((float)i / (float)xs.length * 153);
    drawSegment(xs[i], ys[i], angle, color(redGreen, redGreen, 0 ), segmentWidth);
  }
  drawEyes(xs[0], ys[0], angle);
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

void drawSegment(float x, float y, float angle, color c, float segmentWidth) {
  pushMatrix();
  
  // move coords
  translate(x, y);
  rotate(angle);
  
  // draw element
  fill(c);
  noStroke();
  ellipse(0, 0, 15, segmentWidth);
  
  popMatrix();
}

void drawEyes(float x, float y, float angle) {
  pushMatrix();
  
  translate(x, y);
  rotate(angle);
  
  stroke(color(0,0,0));
  strokeWeight(3);
  point(-1, 2);
  point(-1, -2);
  
  popMatrix();
}

