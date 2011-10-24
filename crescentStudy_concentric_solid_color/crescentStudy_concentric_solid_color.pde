/*
2011-10-24: Rayhan Hasan
            http://rayhanhasan.com/
            

Written in Processing.
Given to you under the MIT License.

*/

int WIDTH = 800;
int numCrescentsPerSide=3;
int numPixelsPerColumn= WIDTH/numCrescentsPerSide;
int numConcentricCircles=19;

int minBrightness = 10;

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
    
    
    fill(255, 255, 255, 15);
    ellipse(x, y, (numPixelsPerColumn*0.9), (numPixelsPerColumn*0.9) );
    
    for(int k=numConcentricCircles; k>=1;k--) {
      drawCrescentOrbiters(x, y, k*size, (j+i)*10, 0, k*.5);
    }
    
   }
  }
  
}

void drawCrescentOrbiters(int x, int y, int cSize, int startingOffset, int differenceOffset, float speed) {

  int oldMin = (int)(numPixelsPerColumn/numConcentricCircles*.8);
  int oldMax = (int)(numConcentricCircles*(numPixelsPerColumn/numConcentricCircles*.8));
  int rescaledBrightness = rescale(cSize, oldMin, oldMax, minBrightness, 255);
  
  fill(rescaledBrightness,rescaledBrightness+startingOffset,rescaledBrightness+cSize+speed, 255-rescaledBrightness);
  
  drawOrbitingCircle(x, y, cSize+cSize/9, 4, speed, startingOffset);
  
  //fill(0);
  //drawOrbitingCircle(x, y, cSize+2, 2, speed, startingOffset+differenceOffset);
}

void drawOrbitingCircle(int x, int y, int cSize,  int distance, float speed, int offset) {

     ellipse(x+sin(radians(frameCount+offset)*speed)*distance, 
          y+cos(radians(frameCount+offset)*speed)*distance, cSize, cSize);
}


int rescale(int val, int oldMin, int oldMax, int newMin, int newMax) {
  
  if(oldMin == oldMax)
    return (newMin+newMax)/2; //TODO: handle this condition more gracefully
  else if(newMin == newMax)
    return newMin;
    
  if(oldMin > oldMax) {
    int temp = oldMin;
    oldMin = oldMax;
    oldMax = temp;
  }
  
  if(newMin > newMax) {
    int temp = oldMin;
    oldMin = oldMax;
    oldMax = temp;
  }
  
  if(val < oldMin)
   return newMin;
  else if(val > oldMax)
   return newMax;
  
  int oldDifference = oldMax - oldMin;
  int valOldDifference = val-oldMin;
  
  float ratio = (float)valOldDifference / (float)oldDifference;
  
  int newDifference = newMax - newMin;
  float newVal = (newDifference * ratio)+newMin;
  
  return (int)newVal;
}

