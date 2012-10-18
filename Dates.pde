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
 *                                class Dates                                   *
 *                                                                              *
 * Dates class creates and displays the date boxes on the left for selecting    *
 * which day to visualize.                                                      *
 *                                                                              *
 ********************************************************************************/
 
class Dates {
  
 /********************************************************************************
  *                                                                              *
  *                               Class Members                                  *
  *                                                                              *
  ********************************************************************************/
  
  private DataParser fileData; // Object of type DataParser to have access to the read files.
  
  private HashMap datesYCoords; // This HashMap stores as key the yCoord and as object the
                                // position in the date file. This mapping is done in order
                                // to find easy (without the use of serial search) on which
                                // date box the user has clicked.
  
 /********************************************************************************
  *                                                                              *
  *                               Constructors                                   *
  *                                                                              *
  ********************************************************************************/
  
  Dates(DataParser fileData) {
    this.fileData = fileData;
    datesYCoords = new HashMap();
  }
  
 /********************************************************************************
  *                                                                              *
  *                               Functions                                      *
  *                                                                              *
  ********************************************************************************/ 
 
 /*
  * function: display()
  * 
  * Draws the boxes with the dates on the left side of the map
  */
  public void display() {
    String[] deathDaysDate = fileData.getDeathDaysDate();
    boolean[] showDate     = fileData.getShowDate();
    
    textAlign(CENTER, BOTTOM);
    stroke(DEFAULT_DATES_FONT_COLOR);
    strokeWeight(0.4);
    textSize(7);
    datesYCoords.clear();
    for( int i = 0; i < deathDaysDate.length; i++ ) {
      float yCoord = map(i, 0, deathDaysDate.length - 1, 30, 600);
      drawDateBox(yCoord, deathDaysDate[i], fileData.showDate[i]);
      
      for( int j = 0; j < 12; j++ ) {
        datesYCoords.put(((int)yCoord - 11 + j), i);
      }
    }
  }
  
 /*
  * function: select()
  * 
  * Returns position in the date file of the selected date (box).
  *
  * Uses the Y coordinate of the mouse to look up in the HashMap if there is
  * any binding on that Y coordinate. If it is, then it returns the position
  * in the dates file.
  */
  public int select() {
    int position;
    
    if( (Integer)datesYCoords.get(mouseY) == null )
      position = -1;
    else {
      position = (Integer)datesYCoords.get(mouseY);
      fileData.showDate[position] = !(fileData.showDate[position]);
    }
    return position;
  }
  
 /*
  * function: display(float, String, boolean)
  * 
  * yCoord     - the yCoord where the box must be drawn
  * dateString - the date that is written inside the box
  * showDate   - if the box is selected or not (if it is, then the background changes)
  * 
  * Draws a single Box containing a date.
  */
  void drawDateBox(float yCoord, String dateString, boolean showDate) {
    if( showDate == true ) {
        fill(DEFAULT_ENABLED_COLOR);
        stroke(COLOR_WHITE);
    }
    else {
        fill(DEFAULT_BACKGROUND_COLOR);
        stroke(COLOR_BLACK);
    }
      
    beginShape();
      vertex(1, yCoord - 11);
      vertex(1, yCoord + 1);
      vertex(29,  yCoord + 1);
      vertex(29,  yCoord - 11);
    endShape(CLOSE);
    
    if( showDate == true ) {
      fill(DEFAULT_DATES_FONT_COLOR);
    }
    else {
      fill(COLOR_BLACK);
    }
    text(dateString, 15, yCoord);
  }
}
