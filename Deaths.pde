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
 *                                class Deaths                                  *
 *                                                                              *
 * Deaths class displays and stores all the deaths in the map.                  *
 *                                                                              *
 ********************************************************************************/
 
class Deaths {
  
 /********************************************************************************
  *                                                                              *
  *                               Class Members                                  *
  *                                                                              *
  ********************************************************************************/
  
  private DataParser fileData;       // Object of type DataParser to have access to the read files.
  private CholeraMap streetMap;      // The map with the streets
  
  private boolean showMalesFemales;  // Show males and females on map ?
  private boolean showAges;          // Show ages on map ?
  
 /********************************************************************************
  *                                                                              *
  *                               Constructors                                   *
  *                                                                              *
  ********************************************************************************/
  
  Deaths(DataParser fileData, CholeraMap streetMap) {
    this.fileData = fileData;
    this.streetMap = streetMap;
    this.showMalesFemales = false;
    this.showAges = false;
    
    //deathMap = new HashMap(fileData.deathsAgeMFlength());
  }
  
 /********************************************************************************
  *                                                                              *
  *                               Functions                                      *
  *                                                                              *
  ********************************************************************************/ 
  
 /*
  * function: display()
  * 
  * Displays the deaths on the map
  */
  public void display() {
    //deathMap.clear();
   
    smooth();
    stroke(COLOR_BLACK);
    strokeWeight(0.5);
    
    for( int i = 0; i < fileData.deathsAgeMFlength(); i++ ) {
      if( fileData.getShowDeath(i) ) {
        
        if( showMalesFemales ) {
          if( fileData.getDeathsMF(i) == 0 ) // male
            fill(DEFAULT_DEATH_MALE_COLOR);
          else // female
            fill(DEFAULT_DEATH_FEMALE_COLOR);
        } // end if
        else if( showAges ) {
          switch( fileData.getDeathsAge(i) ){
            case 0:
              fill(DEFAULT_DEATH_AGE_0_COLOR);
              break;
            case 1:
              fill(DEFAULT_DEATH_AGE_1_COLOR);
              break;
            case 2:
              fill(DEFAULT_DEATH_AGE_2_COLOR);
              break;
            case 3:
              fill(DEFAULT_DEATH_AGE_3_COLOR);
              break;
            case 4:
              fill(DEFAULT_DEATH_AGE_4_COLOR);
              break;
            default:
              fill(DEFAULT_DEATH_AGE_5_COLOR);
              break;
          }
        }
        else {        
          fill(DEFAULT_DEATH_COLOR_R, DEFAULT_DEATH_COLOR_G, DEFAULT_DEATH_COLOR_B);
        }
        
        ellipse(map(fileData.getDeathsXCoord(i), streetMap.Xmin, streetMap.Xmax, streetMap.startingX, streetMap.endingX), 
                map(fileData.getDeathsYCoord(i), streetMap.Ymin, streetMap.Ymax, streetMap.endingY, streetMap.startingY), 
                DEFAULT_CIRLE_RADIUS, 
                DEFAULT_CIRLE_RADIUS);
        
        //deathMap.put((int)map(fileData.getDeathsXCoord(i), streetMap.Xmin, streetMap.Xmax, streetMap.startingX, streetMap.endingX) + ", " + (int)map(fileData.getDeathsYCoord(i), streetMap.Ymin, streetMap.Ymax, streetMap.endingY, streetMap.startingY), i)
      }
    }
  }
  
  
 /*
  * function: toggleDeath(int)
  * 
  * index - the position where te data will be toggled
  *
  * Toggles if a death will be showed or not.
  */
  private void toggleDeath(int index) {
      fileData.setShowDeath( index, !(fileData.getShowDeath(index)) );
  }
  
 /*
  * function: calculatePositionsInShowDeath(int)
  * 
  * index - the position of the array
  *
  * While playing the animation or selecting a date in the date box, each time
  * the user selects a date, one or more deaths are associated with this date.
  * This function finds the number of deaths on that date and the coordinates
  * of those dates and shows them on the map.
  */
  public void calculatePositionsInShowDeath(int index) {
    int indexCounter = 0;
    
    // Count the number of deaths, prior to this death. Number of deaths will be the starting
    // index in the deathsAgeMF file.
    for( int i = 0; i < index; i++ ) {
      indexCounter += (int)fileData.getNumberOfDeaths(i);
    }
    
    // We found the starting index, now toggle the Deaths by starting from the starting index
    // for as many deaths as there are in this index.
    for( int i = indexCounter; i < indexCounter + fileData.getNumberOfDeaths(index); i++ ) {
      //toggleDeath(i);
      fileData.setShowDeath(i, true);
    }
  }
  
 /*
  * function: showDeathsDuringScrolling(int)
  * 
  * index - the position of the array
  *
  * Function called during manual scrolling of the animation control.
  * It shows the appropriate deaths in the map.
  */
  public void showDeathsDuringScrolling(int index) {
    int indexCounter = 0;
    
    // Count the number of deaths, prior to this death. Number of deaths will be the starting
    // index in the deathsAgeMF file.
    for( int i = 0; i < index; i++ ) {
      indexCounter += (int)fileData.getNumberOfDeaths(i);
    }
    
    for( int i = 0; i < indexCounter; i ++ ) {
      fileData.setShowDeath(i, true);
    }
    // We found the starting index, now toggle the Deaths by starting from the starting index
    // for as many deaths as there are in this index.
    for( int i = indexCounter; i < indexCounter + fileData.getNumberOfDeaths(index); i++ ) {
      fileData.setShowDeath(i, true);
    }
    
    for( int i = indexCounter + (int)fileData.getNumberOfDeaths(index); i < fileData.showDeathlength(); i++ ) {
      fileData.setShowDeath(i, false);
    }
  }
  
  /*
  * function: toggleShowMalesFemales()
  *
  * Toggles if the map will show the genders or not.
  */
  public void toggleShowMalesFemales() {
    showMalesFemales = !showMalesFemales;
    showAges = false;
  }
  
  /*
  * function: toggleSh()
  * 
  * Toggles if the map will show the ages or not.
  */
  public void toggleShowAges() {
    showAges = !showAges;
    showMalesFemales = false;
  }
  
 /********************************************************************************
  *                                                                              *
  *       Get functions for all the protected and private class members          *
  *                                                                              *
  ********************************************************************************/
  
  boolean getShowMalesFemales() {
    return showMalesFemales;
  }
  
  boolean getShowAges() {
    return showAges;
  }
}
