/**
  * Copyright (c) <2009>, <Victor Mateevitsi> www.vmateevitsi.com
  * All rights reserved.
  * 
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
  * 1. Redistributions of source code must retain the above copyright
  *    notice, this list of conditions and the following disclaimer.
  * 2. Redistributions in binary form must reproduce the above copyright
  *    notice, this list of conditions and the following disclaimer in the
  *    documentation and/or other materials provided with the distribution.
  * 3. All advertising materials mentioning features or use of this software
  *    must display the following acknowledgement:
  *    This product includes software developed by the <organization>.
  * 4. Neither the name of the <organization> nor the
  *    names of its contributors may be used to endorse or promote products
  *    derived from this software without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY <COPYRIGHT HOLDER> ''AS IS'' AND ANY
  * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  * DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
  * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  */

/********************************************************************************
 *                                class CholeraMap                              *
 *                                                                              *
 * Class for the map that show the streets on the window.                       *
 *                                                                              *
 ********************************************************************************/

class CholeraMap {
  
 /********************************************************************************
  *                                                                              *
  *                               Class Members                                  *
  *                                                                              *
  ********************************************************************************/
  
  // The following four class members are used to know where exactly the map starts
  // and ends, in order to zoom in/out and pan easily.
  private float startingX; // Starting X coordinate of the map (top left)
  private float startingY; // Starting Y coordinate of the map (top left)
  private float endingX;   // Ending X coordinate of the map   (top right)
  private float endingY;   // Ending Y coordinate of the map   (top right)
  
  private float Ymax, Ymin, Xmax, Xmin; // The X,Y min and max values of the coords that
                                        // are read from the file. These will be used in
                                        // order for the mapping to be correct.
                                        
  private PImage streetNames; // The background image that contains the names of the streets.
  
  private String []dataFile; // String containg the data of the file read (with the deaths)
  
 /********************************************************************************
  *                                                                              *
  *                               Constructors                                   *
  *                                                                              *
  ********************************************************************************/
  
  CholeraMap(int verticeSize, String[] dataFile) {
    Ymax = Xmax = MIN_FLOAT;
    Ymin = Xmin = MAX_FLOAT;
    this.dataFile = dataFile;
    
    this.startingX = this.startingY = 0;
    this.endingX = this.endingY = verticeSize;
    
    initializeMapBoundaries();
    
    // Load only once!
    streetNames = loadImage(DEFAULT_STREET_NAMES_PATH);
  }
  
 /********************************************************************************
  *                                                                              *
  *                               Functions                                      *
  *                                                                              *
  ********************************************************************************/ 
  
 /*
  * function: initializeMapBoundaries()
  * 
  * XXX - This probably should go to DataParser
  * Initially I read the data file once, in order to find the X and Y min and max coordinates.
  * I use that later in order to do the mapping from the read coordinates to the actual screen
  * coordinates.
  */
  private void initializeMapBoundaries() {
    // The line that we are reading from the data file.
    int lineR = 0;
    
    while(lineR < dataFile.length) {
      // Read the first line. The first line has two integers, one Weight and number of Vertices starting from this point.
      float[] dataRead = float(split(dataFile[lineR], "\t" ));
      lineR++; // Advance to next line (the x1 and y1 coordinates)
      
      float numberOfCoordinates = dataRead[1];
      
      dataRead =  float(split(dataFile[lineR], "\t" ));
      lineR++;
      
      Ymin = min(dataRead[1], Ymin);
      Ymax = max(dataRead[1], Ymax);
      Xmin = min(dataRead[0], Xmin);
      Xmax = max(dataRead[0], Xmax);
      
      for(float i = 1; i < numberOfCoordinates; i++) { 
        dataRead =  float(split(dataFile[lineR], "\t" ));   
        Ymin = min(dataRead[1], Ymin);
        Ymax = max(dataRead[1], Ymax);
        Xmin = min(dataRead[0], Xmin);
        Xmax = max(dataRead[0], Xmax);
        lineR++;  // Advance to next line
      }
      endShape(); 
    }
  }
  
  /*
  * function: display()
  * 
  * This function displays (draws) the streets on the window.
  * While reading the file and the coordinates of each road,
  * it maps those coordinates to the actual screen coordinates and
  * does the drawing.
  */
  public void display() {
    fill(255);
    
    image(streetNames, startingX, startingY, endingX - startingX, endingY - startingY);
    
    stroke(0);
    // The line that we are reading from the data file.
    int lineR = 0;
    
    while(lineR < dataFile.length) {
      // Read the first line. The first line has two integers, one Weight and number of Vertices starting from this point.
      float[] dataRead = float(split(dataFile[lineR], "\t" ));
      lineR++; // Advance to next line (the x1 and y1 coordinates)
      
      float numberOfCoordinates = dataRead[1];
    
      dataRead =  float(split(dataFile[lineR], "\t" ));
      lineR++;
      
      smooth();
      stroke(0);
      strokeWeight(2.0);
      
      // Begin Shape
      beginShape();
      
        vertex(map(dataRead[0], Xmin, Xmax, startingX, endingX), map(dataRead[1], Ymin, Ymax, endingY, startingY));
        for(float i = 1; i < numberOfCoordinates; i++) { 
          dataRead =  float(split(dataFile[lineR], "\t" ));
          lineR++;
          vertex(map(dataRead[0], Xmin, Xmax, startingX, endingX), map(dataRead[1], Ymin, Ymax, endingY, startingY));   
        }
      // End Shape
      endShape(); 
    }
  }

 /*
  * function: pan()
  * 
  * This function is called when panning on the map is performed.
  * It calculates in which direction the mouse moves while panning
  * and changes the starting and ending coordinates.
  */
  public void pan() {
    if( (mouseX - pmouseX) > 0) {
      this.startingX += DEFAULT_PANNING_OFFSET;
      this.endingX += DEFAULT_PANNING_OFFSET;
    }
    else if( (mouseX - pmouseX) < 0){
      this.startingX -= DEFAULT_PANNING_OFFSET;
      this.endingX -= DEFAULT_PANNING_OFFSET;
    }
    
    if( (mouseY - pmouseY) > 0) {
      this.startingY += DEFAULT_PANNING_OFFSET;
      this.endingY += DEFAULT_PANNING_OFFSET;
    }
    else if((mouseY - pmouseY) < 0) {
      this.startingY -= DEFAULT_PANNING_OFFSET;
      this.endingY -= DEFAULT_PANNING_OFFSET;
    }
  }
  
 /*
  * function: zoomIn()
  * 
  * This function is called when zoomming in on the map is performed.
  * It just stretches the width and the height of the map, so the user
  * actually sees the map bigger.
  */
  public void zoomIn() {
    this.startingX -= DEFAULT_ZOOM_OFFSET;
    this.endingX += DEFAULT_ZOOM_OFFSET;
    
    this.startingY -= DEFAULT_ZOOM_OFFSET;
    this.endingY += DEFAULT_ZOOM_OFFSET;
  }
  
 /*
  * function: zoomOut()
  * 
  * This function is called when zoomming out on the map is performed.
  * It just schrinks the width and the height of the map, so the user
  * actually sees the map smaller.
  */
  public void zoomOut() {
    if ( endingX - DEFAULT_ZOOM_OFFSET - startingX > 0 ) { // In order to prevent picture flipping !
      this.startingX += DEFAULT_ZOOM_OFFSET;
      this.endingX -= DEFAULT_ZOOM_OFFSET;
      
      this.startingY += DEFAULT_ZOOM_OFFSET;
      this.endingY -= DEFAULT_ZOOM_OFFSET;
    }
  }

 
}
