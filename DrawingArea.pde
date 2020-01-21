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
 *                                class DrawingArea                             *
 *                                                                              *
 * DrawingArea class displays and draws all the controls of the program.        *
 *                                                                              *
 ********************************************************************************/

 /* @pjs preload="data/animation_play.png, data/animation_pause.png, data/button1_enabled.png, data/button1_disabled.png, data/button2_enabled.png, data/button2_disabled.png"; */
class DrawingArea {
 /********************************************************************************
  *                                                                              *
  *                               Class Members                                  *
  *                                                                              *
  ********************************************************************************/
  
  private CholeraMap streetMap;                                 // The streetMap with the streets
  private Deaths peopleDead;                                    // The peopleDead object with the dead people
  private Dates datesOnMap;                                     // The date boxes
  private DataParser fileData;                                  // The data files
  private TimeLineChart deathsByDateChart;                      // The chart with the number of deaths by date
  private boolean playAnimationB;                               // Is the animation playing ?
  private int animationPosition;                                // The position of the animation while playing
  private float progress_bar_x;                                 // The X coords of the cirlce that plays the animation
  private float progressHotspotXStart, progressHotspotXEnd;     //  The starting and ending Xcoords of the scrolling bar
  private float []deathByChartYValues;                          // Values of the male deaths
  private Grid clusterGrid;                                     // The grid with the clusters
  public HorizontalBarChart deathsByAgeSex;                     // The Bar chart with the deaths by age and sex
  

 /********************************************************************************
  *                                                                              *
  *                               Constructors                                   *
  *                                                                              *
  ********************************************************************************/
  
  DrawingArea(DataParser fileData) {
    this.fileData = fileData;

    streetMap = new CholeraMap(DEFAULT_MAP_PIXELS_WIDTH, fileData.getStreets());
    peopleDead = new Deaths(fileData, streetMap);
    datesOnMap = new Dates(this.fileData);


    deathsByDateChart = new TimeLineChart( DEFAULT_CHART_WIDTH, 
    DEFAULT_CHART_HEIGHT, 
    "Dates of Deaths", 
    "Number\n of deaths", 

    "Number of Deaths per day", 
    fileData.getDeathDaysDate(), 
    fileData.getNumberOfDeaths() );

    // XXX - Fix this to be automatic
    deathsByDateChart.xInterval = 5;
    deathsByDateChart.yInterval = 10;
    deathsByDateChart.isYAxisInt = true;

    deathsByAgeSex = new HorizontalBarChart( DEFAULT_CHART_WIDTH - 10, 
    DEFAULT_CHART_HEIGHT, 
    "Deaths", 
    "Ages", 
    "Deaths by Age and Sex", 
    fileData.getNumberOfDeadAgesFemales());

    deathsByAgeSex.xInterval = 10;
    deathsByAgeSex.yInterval = 10;
    deathsByAgeSex.isYAxisInt = true;      
    deathsByAgeSex.isXAxisInt = true;
    float[] newAgeValues = calculateNewAgeValues(fileData.getNumberOfDeadAgesFemales(), 1); 
    deathsByAgeSex.setXMinValue(min(newAgeValues));
    deathsByAgeSex.setXMaxValue(max(newAgeValues));
    playAnimationB = false;   
    animationPosition = 8 * fileData.deathDayslength();
    progress_bar_x = DEFAULT_PROGRESS_ELLIPSE_X_START;
    progressHotspotXStart = DEFAULT_PROGRESS_ELLIPSE_X_START_HOTSPOT;
    progressHotspotXEnd = DEFAULT_PROGRESS_ELLIPSE_X_END_HOTSPOT;
    deathByChartYValues = new float[fileData.numberOfDeathslength()];
    
    clusterGrid = new Grid(DEFAULT_MAP_PIXELS_WIDTH, fileData, streetMap);

  }

 /********************************************************************************
  *                                                                              *
  *                               Functions                                      *
  *                                                                              *
  ********************************************************************************/
 
 /*
  * function: display()
  * 
  * Displays the whole visualization on the screen.
  * Map, Charts, Date boxes, Buttons, Animation (everything) are drawn within this function.
  */ 
  void display() {
    // Colors for the background of the drawing area
    // That is the area that surrounds the map
    background(CLEAR_COLOR); // Defined in PR1

    // Display the map first, so the boxes can cover it durin pan and zoom
    pushMatrix();
      translate(DEFAULT_LEFT_BOX_WIDTH, DEFAULT_UPPER_BOX_HEIGHT);
      streetMap.display();
      //clusterGrid.display();
  
      // Check for animation
      if( playAnimationB ) 
        playAnimation();
      peopleDead.display();
      showPumpsOnMap();
      drawZoomButtons();
    popMatrix();

    // Draw the surrounding Boxes
    this.drawBoxes();
    this.drawTitle(DEFAULT_MAP_TITLE);

    // Draw the date boxes that are left og the map
    datesOnMap.display();

    // Draw tha charts
    pushMatrix(); // Chart Number of Deaths By Date
      translate(DEFAULT_LEFT_BOX_WIDTH + DEFAULT_MAP_WIDTH, DEFAULT_UPPER_BOX_HEIGHT);
      deathsByDateChart.setYValues(calculateNewYValues(fileData.getNumberOfDeaths()));
      deathsByDateChart.display();
      if(peopleDead.getShowMalesFemales()) {
        pushMatrix();
          translate(70, 0);
          deathsByDateChart.drawData(calculateNewYValues(fileData.getNumberOfDeadMales()), DEFAULT_DEATH_MALE_COLOR);
          deathsByDateChart.drawData(calculateNewYValues(fileData.getNumberOfDeadFemales()), DEFAULT_DEATH_FEMALE_COLOR);
        popMatrix();
      }
      else if(peopleDead.getShowAges()) {
        pushMatrix();
          translate(70, 0);
          deathsByDateChart.drawData(calculateNewYValues(fileData.getNumberOfDeadAges0()), DEFAULT_DEATH_AGE_0_COLOR);
          deathsByDateChart.drawData(calculateNewYValues(fileData.getNumberOfDeadAges1()), DEFAULT_DEATH_AGE_1_COLOR);
          deathsByDateChart.drawData(calculateNewYValues(fileData.getNumberOfDeadAges2()), DEFAULT_DEATH_AGE_2_COLOR);
          deathsByDateChart.drawData(calculateNewYValues(fileData.getNumberOfDeadAges3()), DEFAULT_DEATH_AGE_3_COLOR);
          deathsByDateChart.drawData(calculateNewYValues(fileData.getNumberOfDeadAges4()), DEFAULT_DEATH_AGE_4_COLOR);
          deathsByDateChart.drawData(calculateNewYValues(fileData.getNumberOfDeadAges5()), DEFAULT_DEATH_AGE_5_COLOR);
        popMatrix();
      }
      // Draw the line of that shows when the pump handle was removed
      pushMatrix();
        translate(70, 0);
        drawPumpHandleRemoved();
      popMatrix();
  
      // Draw the chart Number of Deaths by Gender and Age
      pushMatrix();
        translate(-9, DEFAULT_CHART_HEIGHT + 10);
        deathsByAgeSex.setChartColor(DEFAULT_DEATH_FEMALE_COLOR);
        deathsByAgeSex.setHasYAxis(false);
        float[] newAgeValues = calculateNewAgeValues(fileData.getNumberOfDeadAgesFemales(), 1); 
        deathsByAgeSex.setXValues(newAgeValues);
        deathsByAgeSex.display();
        pushMatrix();
          translate(70, 0);
          deathsByAgeSex.drawData(calculateNewAgeValues(fileData.getNumberOfDeadAgesMales(), 0), DEFAULT_DEATH_MALE_COLOR);
          deathsByAgeSex.drawYAxis(DEFAULT_HOR_CHART_Y_TAGS);
        popMatrix();
      popMatrix();
    popMatrix();
    
    // Clustering
    pushMatrix();
      translate(DEFAULT_LEFT_BOX_WIDTH, DEFAULT_UPPER_BOX_HEIGHT);
      clusterGrid.display();
    popMatrix();
    
    // Draw Clustering Box
    drawClusteringBox();
  }

 /*
  * function: drawClusteringBox()
  * Draw the Clustering Enable - Disable.
  */
  private void drawClusteringBox() {
    fill(COLOR_BLACK);
    textSize(10);
    textAlign(LEFT, CENTER);
    pushMatrix();
      translate(DEFAULT_ANIMATION_BOX_X + 5, DEFAULT_ANIMATION_BOX_Y - 50);
      rect(0, 0, 100, 20);
      rect(110, 0, 20, 20);
      rect(140, 0, 20, 20);
      fill(COLOR_WHITE);
      stroke(COLOR_WHITE);
      text("Enable Clustering", 7, 8);
      line(115, 10, 125, 10);
      line(120, 5, 120, 15);
      line(145, 10, 155, 10);
    popMatrix();
  }
  
 /*
  * function: drawPumpHandleRemoved()
  * 
  * Draws a line and a text showing when the pump handle was removed.
  */
  private void drawPumpHandleRemoved() {
    fill(COLOR_BLACK);
    stroke(COLOR_WHITE);
    strokeWeight(0.5);
    float xCoord = map(20, 0, fileData.deathDaysDatelenth(), 5, DEFAULT_CHART_WIDTH);
    line(xCoord, 0, xCoord, deathsByDateChart.chartHeight);
    textSize(9);
    textAlign(LEFT, CENTER);
    text("Pump handle removed", xCoord + 2, 0);
  }

 /*
  * function: calculateNewYValues(float[])
  * 
  * floatArray - The array to be parsed
  *
  * Return a float array - The array with the new values.
  *
  * Given an array floatArray, the function returns a new array with only
  * the number of deaths that have to be shown on the map and the charts.
  * This function is called each time an animation is played, or the user
  * scrolls the animation control, etc. Each time not all the deaths are
  * shown, this function calculates what deaths have to be shown and what not.
  */
  private float[] calculateNewYValues(float[] floatArray) {
    float[] deathByChartYValues;
    deathByChartYValues = new float[fileData.numberOfDeathslength()];
    for( int i = 0; i < fileData.numberOfDeaths.length; i++ ) {
      if( fileData.getShowDate(i) ) {
        deathByChartYValues[i] = floatArray[i];
      }
      else {
        deathByChartYValues[i] = 0;
      }
    }
    return deathByChartYValues;
  }

 /*
  * function: calculateNewAgeValues()
  *
  * Same as calculateNewYValues but this time for genders.
  */
  private float[] calculateNewAgeValues(float[] floatArray, int malesFemales) {
    float[] newArray;
    newArray = new float[6];

    int deadCounter = 0;
    // Initially see how many people dies each day.
    for( int i = 0; i < fileData.getNumberOfDeathslength(); i++ ) {
      if ( fileData.getShowDate(i) ) {
        // For each day, see how many died and seek them in the deathsMF
        for( int j = deadCounter; j < (deadCounter + fileData.getNumberOfDeaths(i)); j++ ) {
          if( fileData.getDeathsMF(j) == malesFemales ) {
            newArray[fileData.getDeathsAge(i)]++;
          }
        }
      }
    }

    return newArray;
  }

 /*
  * function: drawZoomButtons()
  * 
  * Draws the Zoom in and out buttons on the map.
  */
  private void drawZoomButtons() {
    strokeWeight(1);
    // Zoom in
    pushMatrix();
    translate(5, 5);
    drawBox(COLOR_WHITE, COLOR_BLACK, DEFAULT_MAP_ZOOM_BOXES_WIDTH, DEFAULT_MAP_ZOOM_BOXES_WIDTH);
    line(10, 5, 10, 15);
    line(5, 10, 15, 10);
    popMatrix();

    // Zoom out
    pushMatrix();
    translate(5, 30);
    drawBox(COLOR_WHITE, COLOR_BLACK, DEFAULT_MAP_ZOOM_BOXES_WIDTH, DEFAULT_MAP_ZOOM_BOXES_WIDTH);
    line(5, 10, 15, 10);
    popMatrix();
  }

 /*
  * function: drawBoxes()
  * 
  * Draws all the surrounding boxes of the map.
  */
  private void drawBoxes() {

    // Upper box for the Title
    drawBox(DEFAULT_BACKGROUND_COLOR, DEFAULT_BACKGROUND_COLOR, DEFAULT_UPPER_BOX_WIDTH, DEFAULT_UPPER_BOX_HEIGHT);    

    // Left box for the Dates
    pushMatrix();
      translate(0, DEFAULT_UPPER_BOX_HEIGHT);
      drawBox(DEFAULT_BACKGROUND_COLOR, DEFAULT_BACKGROUND_COLOR, DEFAULT_LEFT_BOX_WIDTH, DEFAULT_LEFT_BOX_HEIGHT);    
    popMatrix();

    // Right Box for the charts
    pushMatrix();
      translate(DEFAULT_LEFT_BOX_WIDTH + DEFAULT_MAP_WIDTH, DEFAULT_UPPER_BOX_HEIGHT);
      drawBox(DEFAULT_BACKGROUND_COLOR, DEFAULT_BACKGROUND_COLOR, DEFAULT_CHART_BOX_WIDTH, DEFAULT_CHART_BOX_HEIGHT);
    popMatrix();

    // Bottom Box
    pushMatrix();
      translate(0, DEFAULT_UPPER_BOX_HEIGHT + DEFAULT_LEFT_BOX_HEIGHT);
      drawBox(DEFAULT_BACKGROUND_COLOR, DEFAULT_BACKGROUND_COLOR, DEFAULT_BOTTOM_BOX_WIDTH, DEFAULT_BOTTOM_BOX_HEIGHT);
      drawBottomBoxGraphics();
    popMatrix();

    // Animation Box
    pushMatrix();
      translate(DEFAULT_ANIMATION_BOX_X, DEFAULT_ANIMATION_BOX_Y);
      //drawBox(DEFAULT_BACKGROUND_COLOR, COLOR_BLACK, DEFAULT_ANIMATION_BOX_WIDTH, DEFAULT_ANIMATION_BOX_HEIGHT);
      drawAnimationBox();
    popMatrix();
    
    // Draw the text explaining what the blue rectangle is
    pushMatrix();
      translate(DEFAULT_ANIMATION_BOX_X, DEFAULT_ANIMATION_BOX_Y + 73);
      //drawBox(DEFAULT_BACKGROUND_COLOR, COLOR_BLACK, DEFAULT_ANIMATION_BOX_WIDTH, DEFAULT_ANIMATION_BOX_HEIGHT);
      fill(COLOR_BLUE);
      rect(0, 0, 8, 8);
      textSize(10);
      textAlign(LEFT, CENTER);
      fill(COLOR_BLACK);
      text("The pumps in the map are marked wit a blue rectangle.", 10, 4);
    popMatrix();
  }

 /*
  * function: drawAnimationBox()
  * 
  * Draws the animation control.
  */
  private void drawAnimationBox() {
    PImage animationImage;
    if( playAnimationB ) {
      animationImage = loadImage("data/animation_pause.png");
    }
    else {
      animationImage = loadImage("data/animation_play.png");
    }
    image(animationImage, 0, 0);
    ellipse(progress_bar_x, DEFAULT_PROGRESS_ELLIPSE_Y, DEFAULT_PROGRESS_ELLIPSE_RADIUS, DEFAULT_PROGRESS_ELLIPSE_RADIUS);
  }

 /*
  * function: drawBox()
  * 
  * A more generic function to draw a Box within the window.
  * It is used to draw all the boxes within this application.
  */
  private void drawBox(int fillColor, int strokeColor, int boxWidth, int boxHeight) {
    fill(fillColor);
    stroke(strokeColor);
    beginShape();
    vertex(0, 0);
    vertex(boxWidth, 0);
    vertex(boxWidth, boxHeight);
    vertex(0, boxHeight);
    endShape(CLOSE);
  }

 /*
  * function: drawTitle()
  * 
  * Draws the title of the visualization.
  */
  private void drawTitle(String title) {
    fill(DEFAULT_FONT_COLOR);
    textSize(DEFAULT_MAP_TITLE_FONT_SIZE);
    textAlign(LEFT, CENTER);
    text(title, DEFAULT_MAP_TITLE_COORD_X, DEFAULT_MAP_TITLE_COORD_Y);
  }

 /*
  * function: drawBottomBoxGraphics()
  * 
  * Draws the two buttons for genders and ages.
  */
  private void drawBottomBoxGraphics() {
    PImage button1, button2;
    strokeWeight(DEFAULT_BOTTOM_BOX_STROKE_WEIGHT);

    pushMatrix();
    // First Button - Male / Female
    translate(DEFAULT_LEFT_BOX_WIDTH + DEFAULT_BOTTOM_BOX_GRAPHICS_X_OFFSET, DEFAULT_BOTTOM_BOX_GRAPHICS_Y_OFFSET);
    if( peopleDead.getShowMalesFemales() ) {
      drawBox(DEFAULT_ENABLED_COLOR, COLOR_WHITE, DEFAULT_BOTTOM_BUTTON1_GRAPHICS_WIDTH, DEFAULT_BOTTOM_BOX_GRAPHICS_HEIGHT);
      button1 = loadImage("data/button1_enabled.png");
    }
    else {
      drawBox(DEFAULT_BACKGROUND_COLOR, COLOR_BLACK, DEFAULT_BOTTOM_BUTTON1_GRAPHICS_WIDTH, DEFAULT_BOTTOM_BOX_GRAPHICS_HEIGHT);
      button1 = loadImage("data/button1_disabled.png");
    }
    image(button1, 2, 2);

    // draw the Small boxes with the color + the text
    //pushMatrix();
    //  translate(DEFAULT_BOTTOM_BOX_GRAPHICS_WIDTH / 2, DEFAULT_BOTTOM_BOX_GRAPHICS_HEIGHT / 3);
    //drawBox(DEFAULT_DEATH_MALE_COLOR, COLOR_BLACK, DEFAULT_COLOR_SMALL_BOXES_WIDTH, DEFAULT_COLOR_SMALL_BOXES_WIDTH);
    // popMatrix();


    // End First Button
    pushMatrix();

    // Second Button - Ages
    translate(DEFAULT_BOTTOM_BUTTON1_GRAPHICS_WIDTH + DEFAULT_BOTTOM_BOX_GRAPHICS_X_OFFSET, 0);
    if( peopleDead.getShowAges() ) {
      drawBox(DEFAULT_ENABLED_COLOR, COLOR_WHITE, DEFAULT_BOTTOM_BUTTON2_GRAPHICS_WIDTH, DEFAULT_BOTTOM_BOX_GRAPHICS_HEIGHT);
      button2 = loadImage("data/button2_enabled.png");
    }
    else {
      drawBox(DEFAULT_BACKGROUND_COLOR, COLOR_BLACK, DEFAULT_BOTTOM_BUTTON2_GRAPHICS_WIDTH, DEFAULT_BOTTOM_BOX_GRAPHICS_HEIGHT);
      button2 = loadImage("data/button2_disabled.png");
    }
    image(button2, 2, 2);
    popMatrix();

    // End second Button
    popMatrix();
  }

 /*
  * function: toggleAnimation()
  * 
  * Toggles the value of the class member playAnimationB
  */
  public void toggleAnimation() {
    playAnimationB = !playAnimationB;
  }

 /*
  * function: clearAnimation()
  * 
  * Clears the map and the graphs by restarting the animation.
  */
  public void clearAnimation() {
    // Initially Clear the Map
    for( int i = 0; i < fileData.deathDayslength(); i++ ) {
      fileData.setShowDate(i, false);
    }

    for( int i = 0; i < fileData.deathsAgeMFlength(); i++ ) {
      fileData.setShowDeath(i, false);
    }
    animationPosition = 0;
    progress_bar_x = DEFAULT_PROGRESS_ELLIPSE_X_START;
    progressHotspotXStart = DEFAULT_PROGRESS_ELLIPSE_X_START_HOTSPOT;
    progressHotspotXEnd = DEFAULT_PROGRESS_ELLIPSE_X_END_HOTSPOT;
  }

 /*
  * function: playAnimation()
  * 
  * Plays the animation.
  */
  public void playAnimation() {
    //For each frame rate change, change the values of the tables!
    if( animationPosition == 8 * fileData.deathDayslength() ) {
      clearAnimation();
    } 
    else {
      if( animationPosition % 8 == 0 ) {
        fileData.setShowDate(animationPosition / 8, true);
        peopleDead.calculatePositionsInShowDeath(animationPosition / 8);
        progress_bar_x = map(animationPosition / 8, 0, fileData.deathDayslength(), DEFAULT_PROGRESS_ELLIPSE_X_START, DEFAULT_PROGRESS_ELLIPSE_X_END);
        progressHotspotXStart = DEFAULT_LEFT_BOX_WIDTH + DEFAULT_MAP_WIDTH + progress_bar_x + 5;
        progressHotspotXEnd = DEFAULT_LEFT_BOX_WIDTH + DEFAULT_MAP_WIDTH + progress_bar_x + 14;
      }
      animationPosition++;
    }
  }
  
 /*
  * function: showPumpsOnMap()
  * 
  * Shows the locations of the pumps on the map
  */
  public void showPumpsOnMap() {
    //textAlign(CENTER, CENTER);
    //textSize(20);
    fill(COLOR_BLUE);
    for( int i = 0; i < fileData.getPumpslength(); i++ ) {
      float xCoord = map(fileData.getPumpsXCoord(i), streetMap.Xmin, streetMap.Xmax, streetMap.startingX, streetMap.endingX);
      float yCoord = map(fileData.getPumpsYCoord(i), streetMap.Ymin, streetMap.Ymax, streetMap.endingY, streetMap.startingY);
      //text("P", xCoord, yCoord);
      rect(xCoord - 4, yCoord - 4, 8, 8);
    }
  }
  
 /********************************************************************************
  *                                                                              *
  *                            Mouse Functions                                   *
  *                                                                              *
  ********************************************************************************/
  
 /*
  * function: mouseDragged()
  * 
  * Each time the mouse is dragged, a lots of calculations have to be made.
  * Is the user panning the map, or is he scrolling the animation control ?
  * The function based on the X and Y coords of the map, triggers the appropriate
  * functions and functionalities..
  */
  void mouseDragged() {
    if( ( (mouseX > DEFAULT_LEFT_BOX_WIDTH && mouseX < (DEFAULT_MAP_WIDTH + DEFAULT_LEFT_BOX_WIDTH)) && (mouseY > DEFAULT_UPPER_BOX_HEIGHT && mouseY < DEFAULT_UPPER_BOX_HEIGHT + DEFAULT_MAP_HEIGHT) ) ) {     
      streetMap.pan();
      clusterGrid.calculateNumberOfDeathsInEachGrid();
    }
    else if( (mouseX > DEFAULT_LEFT_BOX_WIDTH + DEFAULT_MAP_WIDTH + DEFAULT_PROGRESS_ELLIPSE_X_START + 10) && (mouseX < DEFAULT_LEFT_BOX_WIDTH + DEFAULT_MAP_WIDTH + DEFAULT_PROGRESS_ELLIPSE_X_END + 3) && // Check to be in the boundaries of the scrolling button
    //  (mouseX > progressHotspotXStart) && (mouseX < progressHotspotXEnd) && 
    ( (mouseY > DEFAULT_PROGRESS_ELLIPSE_Y_START_HOTSPOT) && (mouseY < DEFAULT_PROGRESS_ELLIPSE_Y_END_HOTSPOT) ) ) {
      progress_bar_x = mouseX - DEFAULT_LEFT_BOX_WIDTH - DEFAULT_MAP_WIDTH - 8;
      progressHotspotXStart = mouseX - 10;
      progressHotspotXEnd = mouseX + 10;

      animationPosition = (int)map(mouseX, DEFAULT_LEFT_BOX_WIDTH + DEFAULT_MAP_WIDTH + DEFAULT_PROGRESS_ELLIPSE_X_START + 10, DEFAULT_LEFT_BOX_WIDTH + DEFAULT_MAP_WIDTH + DEFAULT_PROGRESS_ELLIPSE_X_END, 0, fileData.deathDayslength() - 1);
      fileData.showDatesDuringScrolling(animationPosition);
      peopleDead.showDeathsDuringScrolling(animationPosition);
      animationPosition *= 8;
    }
  }
  
 /*
  * function: mouseMoved()
  * 
  * Each time the mouse is moved, a lots of calculations have to be made.
  * What is the mouse pointing at, in order to show a hand or an arrow ?
  * The function based on the X and Y coords of the map, shows either a hand
  * or an arrow. 
  */
  void mouseMoved() {
    // For the Left Box
    if( 
    ( (mouseX < DEFAULT_LEFT_BOX_WIDTH) && (mouseY > DEFAULT_UPPER_BOX_HEIGHT) ) ||
      // For the Bottom_Box_Graphics - BOX 1         
    ( ( (mouseX > DEFAULT_LEFT_BOX_WIDTH + DEFAULT_BOTTOM_BOX_GRAPHICS_X_OFFSET &&
      mouseX < DEFAULT_LEFT_BOX_WIDTH + DEFAULT_BOTTOM_BOX_GRAPHICS_X_OFFSET + DEFAULT_BOTTOM_BUTTON1_GRAPHICS_WIDTH ) ) && 
      ( (mouseY > height - DEFAULT_BOTTOM_BOX_HEIGHT + DEFAULT_BOTTOM_BOX_GRAPHICS_Y_OFFSET) &&
      mouseY < height - DEFAULT_BOTTOM_BOX_GRAPHICS_Y_OFFSET ) ) ||
      // For the Bottom_Box_Graphics - BOX 2         
    ( ( (mouseX > DEFAULT_LEFT_BOX_WIDTH + 2*DEFAULT_BOTTOM_BOX_GRAPHICS_X_OFFSET + DEFAULT_BOTTOM_BUTTON1_GRAPHICS_WIDTH &&
      mouseX < DEFAULT_LEFT_BOX_WIDTH + DEFAULT_MAP_WIDTH - DEFAULT_BOTTOM_BOX_GRAPHICS_X_OFFSET ) ) && 
      ( (mouseY > height - DEFAULT_BOTTOM_BOX_HEIGHT + DEFAULT_BOTTOM_BOX_GRAPHICS_Y_OFFSET) &&
      mouseY < height - DEFAULT_BOTTOM_BOX_GRAPHICS_Y_OFFSET ) ) ||
      // Zoom in Button
    ( ( (mouseX > DEFAULT_LEFT_BOX_WIDTH + 5) && (mouseX < DEFAULT_LEFT_BOX_WIDTH + 5 + DEFAULT_MAP_ZOOM_BOXES_WIDTH) ) &&
      ( (mouseY > DEFAULT_UPPER_BOX_HEIGHT + 5) && (mouseY < DEFAULT_UPPER_BOX_HEIGHT + 5 + DEFAULT_MAP_ZOOM_BOXES_WIDTH) ) ) ||
      // Zoom out Button
    ( ( (mouseX > DEFAULT_LEFT_BOX_WIDTH + 5) && (mouseX < DEFAULT_LEFT_BOX_WIDTH + 5 + DEFAULT_MAP_ZOOM_BOXES_WIDTH) ) &&
      ( (mouseY > DEFAULT_UPPER_BOX_HEIGHT + 10 + DEFAULT_MAP_ZOOM_BOXES_WIDTH) && (mouseY < DEFAULT_UPPER_BOX_HEIGHT + 10 + 2*DEFAULT_MAP_ZOOM_BOXES_WIDTH) ) ) ||
      // Animation play button
    ( ( (mouseX > DEFAULT_ANIMATION_PLAY_BUTTON_X_START) && (mouseX < DEFAULT_ANIMATION_PLAY_BUTTON_X_END) ) &&
      ( (mouseY > DEFAULT_ANIMATION_PLAY_BUTTON_Y_START) && (mouseY < DEFAULT_ANIMATION_PLAY_BUTTON_Y_END) ) )  ||
      // Animation back
    ( ( (mouseX > DEFAULT_ANIMATION_BACK_BUTTON_X_START) && (mouseX < DEFAULT_ANIMATION_BACK_BUTTON_X_END) ) &&
      ( (mouseY > DEFAULT_ANIMATION_BACK_BUTTON_Y_START) && (mouseY < DEFAULT_ANIMATION_BACK_BUTTON_Y_END) ) ) ||

      ( ( (mouseX > progressHotspotXStart) && (mouseX < progressHotspotXEnd) ) &&
      ( (mouseY > DEFAULT_PROGRESS_ELLIPSE_Y_START_HOTSPOT) && (mouseY < DEFAULT_PROGRESS_ELLIPSE_Y_END_HOTSPOT) ) ) || 
      
      ( ( ( mouseX > DEFAULT_ANIMATION_BOX_X + 5) && (mouseX < DEFAULT_ANIMATION_BOX_X + 5 + 100) ) &&
      ( (mouseY > DEFAULT_ANIMATION_BOX_Y - 50) && (mouseY < DEFAULT_ANIMATION_BOX_Y - 50 + 20) ) ) || 
      
      ( ( ( mouseX > DEFAULT_ANIMATION_BOX_X + 5 + 100 + 10) && (mouseX < DEFAULT_ANIMATION_BOX_X + 5 + 100 + 30) ) &&
      ( (mouseY > DEFAULT_ANIMATION_BOX_Y - 50) && (mouseY < DEFAULT_ANIMATION_BOX_Y - 50 + 20) ) ) || 
      
      ( ( ( mouseX > DEFAULT_ANIMATION_BOX_X + 5 + 100 + 30 + 10) && (mouseX < DEFAULT_ANIMATION_BOX_X + 5 + 100 + + 30 + 10 + 20) ) &&
      ( (mouseY > DEFAULT_ANIMATION_BOX_Y - 50) && (mouseY < DEFAULT_ANIMATION_BOX_Y - 50 + 20) ) )
      )
      cursor(HAND);
    else
      cursor(ARROW); 
  }

 /*
  * function: mousePressed()
  * 
  * Each time the mouse is clicked, a lots of calculations have to be made.
  * What is the mouse pointing at, in order to react different ?
  * This function triggers the corresponding functions, based on where the
  * user clicked. 
  */
  void mousePressed() {
    if( (mouseX < DEFAULT_LEFT_BOX_WIDTH) && (mouseY > DEFAULT_UPPER_BOX_HEIGHT) ) {
      int position = datesOnMap.select();
      if( position != -1 )
        peopleDead.calculatePositionsInShowDeath(position);
    }
    else if( ( (mouseX > DEFAULT_LEFT_BOX_WIDTH + DEFAULT_BOTTOM_BOX_GRAPHICS_X_OFFSET &&
      mouseX < DEFAULT_LEFT_BOX_WIDTH + DEFAULT_BOTTOM_BOX_GRAPHICS_X_OFFSET + DEFAULT_BOTTOM_BUTTON1_GRAPHICS_WIDTH ) ) && 
      ( (mouseY > height - DEFAULT_BOTTOM_BOX_HEIGHT + DEFAULT_BOTTOM_BOX_GRAPHICS_Y_OFFSET) &&
      mouseY < height - DEFAULT_BOTTOM_BOX_GRAPHICS_Y_OFFSET ) ) {
      peopleDead.toggleShowMalesFemales();
    }
    else if( ( (mouseX > DEFAULT_LEFT_BOX_WIDTH + 2*DEFAULT_BOTTOM_BOX_GRAPHICS_X_OFFSET + DEFAULT_BOTTOM_BUTTON1_GRAPHICS_WIDTH &&
      mouseX < DEFAULT_LEFT_BOX_WIDTH + DEFAULT_MAP_WIDTH - DEFAULT_BOTTOM_BOX_GRAPHICS_X_OFFSET ) ) && 
      ( (mouseY > height - DEFAULT_BOTTOM_BOX_HEIGHT + DEFAULT_BOTTOM_BOX_GRAPHICS_Y_OFFSET) &&
      mouseY < height - DEFAULT_BOTTOM_BOX_GRAPHICS_Y_OFFSET ) ) {
      peopleDead.toggleShowAges();
    }
    else if( ( (mouseX > DEFAULT_LEFT_BOX_WIDTH + 5) && (mouseX < DEFAULT_LEFT_BOX_WIDTH + 5 + DEFAULT_MAP_ZOOM_BOXES_WIDTH) ) &&
      ( (mouseY > DEFAULT_UPPER_BOX_HEIGHT + 5) && (mouseY < DEFAULT_UPPER_BOX_HEIGHT + 5 + DEFAULT_MAP_ZOOM_BOXES_WIDTH) ) ) { 
      // Zoom in Button
      streetMap.zoomIn();
      clusterGrid.calculateNumberOfDeathsInEachGrid();
    }
    else if( ( (mouseX > DEFAULT_LEFT_BOX_WIDTH + 5) && (mouseX < DEFAULT_LEFT_BOX_WIDTH + 5 + DEFAULT_MAP_ZOOM_BOXES_WIDTH) ) &&
      ( (mouseY > DEFAULT_UPPER_BOX_HEIGHT + 10 + DEFAULT_MAP_ZOOM_BOXES_WIDTH) && (mouseY < DEFAULT_UPPER_BOX_HEIGHT + 10 + 2*DEFAULT_MAP_ZOOM_BOXES_WIDTH) ) ) { 
      // Zoom out Button
      streetMap.zoomOut();
      clusterGrid.calculateNumberOfDeathsInEachGrid();
    }
    else if( ( (mouseX > DEFAULT_ANIMATION_PLAY_BUTTON_X_START) && (mouseX < DEFAULT_ANIMATION_PLAY_BUTTON_X_END) ) &&
      ( (mouseY > DEFAULT_ANIMATION_PLAY_BUTTON_Y_START) && (mouseY < DEFAULT_ANIMATION_PLAY_BUTTON_Y_END) ) ) {
      // Animation play button
      toggleAnimation();
      playAnimation();
    }
    else if( ( (mouseX > DEFAULT_ANIMATION_BACK_BUTTON_X_START) && (mouseX < DEFAULT_ANIMATION_BACK_BUTTON_X_END) ) &&
      ( (mouseY > DEFAULT_ANIMATION_BACK_BUTTON_Y_START) && (mouseY < DEFAULT_ANIMATION_BACK_BUTTON_Y_END) ) ) {
      clearAnimation();
    }
    else if( ( ( mouseX > DEFAULT_ANIMATION_BOX_X + 5) && (mouseX < DEFAULT_ANIMATION_BOX_X + 5 + 100) ) &&
      ( (mouseY > DEFAULT_ANIMATION_BOX_Y - 50) && (mouseY < DEFAULT_ANIMATION_BOX_Y - 50 + 20) ) ) {
        clusterGrid.toggleGridEnabled();
    }
    else if( ( ( mouseX > DEFAULT_ANIMATION_BOX_X + 5 + 100 + 10) && (mouseX < DEFAULT_ANIMATION_BOX_X + 5 + 100 + 30) ) &&
      ( (mouseY > DEFAULT_ANIMATION_BOX_Y - 50) && (mouseY < DEFAULT_ANIMATION_BOX_Y - 50 + 20) ) ) {
        clusterGrid.increaseGridSize();
    }
    else if( ( ( mouseX > DEFAULT_ANIMATION_BOX_X + 5 + 100 + 30 + 10) && (mouseX < DEFAULT_ANIMATION_BOX_X + 5 + 100 + + 30 + 10 + 20) ) &&
      ( (mouseY > DEFAULT_ANIMATION_BOX_Y - 50) && (mouseY < DEFAULT_ANIMATION_BOX_Y - 50 + 20) ) ) {
        clusterGrid.decreaseGridSize();
    }
  }
}

