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
 *                                class Grid                                    *
 * Class for clustering the deaths into a grid                                  *
 *                                                                              *
 ********************************************************************************/

class Grid {
  
  private int gridSize;                   // The size of each cluster
  private int mapSize;                    // The sizeo of the map 
  private int numberOfGrids;              // How many clusters this grid has
  private DataParser fileData;            // The data files
  private int[] numberOfDeathsInEachGrid; // Number of deaths in each cluster
  private CholeraMap streetMap;           // The map
  private boolean isGridEnabled;          // Boolean to see if grid is enables
  
 /********************************************************************************
  *                                                                              *
  *                               Constructors                                   *
  *                                                                              *
  ********************************************************************************/
  Grid(int mapSize, DataParser fileData, CholeraMap streetMap) {
    this.mapSize = mapSize;
    this.gridSize = 58;
    this.fileData = fileData;
    this.streetMap = streetMap;
    numberOfGrids = mapSize / gridSize;
    numberOfDeathsInEachGrid = new int[numberOfGrids * numberOfGrids];
    calculateNumberOfDeathsInEachGrid();
    isGridEnabled = false;
  }
  
 /*
  * function: setGridSize()
  * 
  * Sets the new size of each cluster.
  */
  public void setGridSize(int newGridSize) {
    gridSize = newGridSize;
    numberOfGrids = mapSize / gridSize;
    numberOfDeathsInEachGrid = new int[numberOfGrids * numberOfGrids];
    calculateNumberOfDeathsInEachGrid();
  }
  
 /*
  * function: increaseGridSize()
  * 
  * Increases the size of each cluster.
  */
  public void increaseGridSize() {
    if( gridSize < 79 ) {
      gridSize += 10;
      numberOfGrids = mapSize / gridSize;
      numberOfDeathsInEachGrid = new int[numberOfGrids * numberOfGrids];
      calculateNumberOfDeathsInEachGrid();
    }
  }
  
 /*
  * function: decreaseGridSize()
  * 
  * Decreases the size of each cluster.
  */
  public void decreaseGridSize() {
    if( gridSize > 37 ) {
      gridSize -= 10;
      numberOfGrids = mapSize / gridSize;
      numberOfDeathsInEachGrid = new int[numberOfGrids * numberOfGrids];
      calculateNumberOfDeathsInEachGrid();
    }
  }
  
 /*
  * function: display()
  * 
  * Draws the grid on to the map.
  */
  public void display() {
    if (isGridEnabled ) {
      strokeWeight(1.0);
      for(int i = 0; i < mapSize; i += gridSize ) {
        line(i, 0, i, mapSize);
        line(0, i, mapSize, i);
      }
      
      fill(COLOR_WHITE);
      //stroke(COLOR_WHITE);
      textSize(10);
      textAlign(CENTER,CENTER);
      for(int i = 0; i < numberOfGrids; i++ ) {
        for( int j = 0; j < numberOfGrids; j++ ) {
          //println(numberOfGrids);
          //println("i: " + i + " j: " + j + " " + (i * numberOfGrids + j));
          fill(COLOR_BLACK);
          ellipse((j + 1) * gridSize - gridSize/2, (i + 1) * gridSize - gridSize/2, 15, 15);
          fill(COLOR_WHITE);
          text(numberOfDeathsInEachGrid[i * numberOfGrids + j], (j + 1) * gridSize - gridSize/2, (i + 1) * gridSize - gridSize/2);
        }
        
      }
    }
  }
  
 /*
  * function: toggleGridEnabled()
  * 
  * Toggles the boolean variable.
  */
  public void toggleGridEnabled() {
    isGridEnabled = !isGridEnabled;
  }
  
 /*
  * function: calculateNumberOfDeathsInEachGrid()
  * 
  * Calculates the number of dead people in each cluster.
  */
  public void calculateNumberOfDeathsInEachGrid() {
    numberOfDeathsInEachGrid = new int[numberOfGrids * numberOfGrids];
    
    for( int i = 0; i < fileData.deathsAgeMFlength(); i++ ) {
      // Actual pixels on the screen
      float xCoord = map(fileData.getDeathsXCoord(i), streetMap.Xmin, streetMap.Xmax, streetMap.startingX, streetMap.endingX); 
      float yCoord = map(fileData.getDeathsYCoord(i), streetMap.Ymin, streetMap.Ymax, streetMap.endingY, streetMap.startingY);

      
      // Convert those to boxes and check not to get out of bounds !
      if ( xCoord > 0 && yCoord > 0 && xCoord < mapSize && yCoord < mapSize) {
        int xGrid = (int)xCoord / gridSize;
        int yGrid = (int)yCoord / gridSize;
        numberOfDeathsInEachGrid[(yGrid) * numberOfGrids + (xGrid)]++;
      }
    }
  }
}
