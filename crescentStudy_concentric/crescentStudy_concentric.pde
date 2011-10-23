int WIDTH = 600;
int numCrescentsPerSide=5;
int numPixelsPerColumn= WIDTH/numCrescentsPerSide;
int numConcentricCircles=19;

void setup () {
  size(WIDTH,WIDTH);
  frameRate(60);
  background(0);
  noStroke();
  smooth();
}

void draw () {
  
  background(0);
  for(int i = 1; i <= numCrescentsPerSide; i++) {
   for(int j = 1; j <= numCrescentsPerSide; j++) {
     
    int x = i*numPixelsPerColumn-numPixelsPerColumn/2;
    int y = j*numPixelsPerColumn-numPixelsPerColumn/2;
    int size = (int)(numPixelsPerColumn/numConcentricCircles*.8);
    
    fill(255);
    int borderSize =(int)(numPixelsPerColumn*0.8);
    ellipse(x, y, borderSize, borderSize);
    
    for(int k=numConcentricCircles; k>=1;k--) {
      drawCrescentOrbiters(x, y, k*size, (j+i)*10, 0, k*1.2);
    }
    
   }
  }
  
}



void drawCrescentOrbiters(int x, int y, int cSize, int startingOffset, int differenceOffset, float speed) {

  fill(255);
  drawOrbitingCircle(x, y, cSize+10, 4, speed, startingOffset);
  
  fill(0);
  drawOrbitingCircle(x, y, cSize+9, 2, speed, startingOffset+differenceOffset);
}

void drawOrbitingCircle(int x, int y, int cSize,  int distance, float speed, int offset) {

     ellipse(x+sin(radians(frameCount+offset)*speed)*distance, 
          y+cos(radians(frameCount+offset)*speed)*distance, cSize, cSize);
}


