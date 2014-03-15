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

int[] xs = new int[20];
int[] ys = new int[20];

/* --- INITIALIZATION --- */
void setup() {
  for (int i=0 ; i< xs.length ; i++) {
    xs[i] = ys[i] = 0;
  }
  
  size(sizeX, sizeY);
  smooth();
  background = loadImage(backgroundPath);
  
  image(background, 0, 0, sizeX, sizeY);
}



/* --- MAIN LOOP --- */
void draw() {
//  float angle = 0;
  
  if (    mouseY != ys[0]
      ||  mouseX != xs[0]) {
    
    /* Count delta of move */
    shiftCoords();
    ys[0] = mouseY;
    xs[0] = mouseX;
  }
    
    /* Drawing */
    
    image(background, 0, 0, sizeX, sizeY);
    for (int i=1 ; i < xs.length ; i++) {
//      angle = atan2(ys[i], xs[i]);
      drawSegment(xs[i-1], ys[i-1], xs[i], ys[i]);
    }
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

void drawSegment(int x1, int y1, int x2, int y2) {
  pushMatrix();
  
  // move coords
  
  // draw element
//  ellipse(0, 0, 30, 20);
  stroke(color(0, 0, 0, 160));
  strokeWeight(10);
  line(x1, y1, x2, y2);
  
  popMatrix();
}

void shiftCoords() {
  for (int i = (xs.length - 2) ; i >= 0 ; i--) {
    xs[i+1] = xs[i];
    ys[i+1] = ys[i];
  }
}

