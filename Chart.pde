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
 *                                class Chart                                   *
 *                                                                              *
 * Chart class is a generic class for creating Charts.                          *
 *                                                                              *
 ********************************************************************************/

class Chart {

 /********************************************************************************
  *                                                                              *
  *                               Class Members                                  *
  *                                                                              *
  ********************************************************************************/
 
  protected int chartHeight;                // The height of the chart in pixels 
  protected int chartWidth;                 // The width of the chart in pixels
  
  protected int chartColor;                 // The color of the lines, bars, or points that will be plotted
  
  protected float[] xValues;                // The x values of the data to be plotted
  protected float[] yValues;                // The y values of the data to be plotted
  
  protected float xMinValue;                // Min value of the x array. (This is used in order to scale the X axis chart automatically)
  protected float xMaxValue;                // Max value of the x array. (This is used in order to scale the X axis chart automatically)
  
  protected float yMinValue;                // Min value of the y array. (This is used in order to scale the Y axis chart automatically)
  protected float yMaxValue;                // Min value of the y array. (This is used in order to scale the Y axis chart automatically)
  
  protected boolean hasXAxis;               // Show the X axis or not
  protected boolean hasYAxis;               // Show the Y axis or not
  
  protected boolean hasXAxisLines;          // Show X axis Lines or not
  protected boolean hasYAxisLines;          // Show Y axis Lines or not
  
  protected boolean hasXLabel;              // Show X axis label or not
  protected boolean hasYLabel;              // Show Y axis label or not
  
  protected boolean hasTitle;               // Show the title of the chart
  
  protected boolean isXAxisInt;             // Is the X axis composed of integer numbers ?
  protected boolean isYAxisInt;             // Is the Y axis composed of integer numbers ?
  
  protected float dataStrokeWeight;         // Weight of stroke of the data to be plotted
  protected int dataStrokeColor;            // Color of stroke of the data to be plotted
  
  protected float xInterval;                // Interval for showing the labels on the X axis
  protected float yInterval;                // Interval for showing the labels on the Y axis
  
  protected String title;                   // Title of the chart
  protected String labelX;                  // Label of the X axis
  protected String labelY;                  // Label of the Y axis
  
  protected PFont chartLabelsFont;          // Font to be used for all the texts used in the chart
  protected int fontColor;                  // Color of the font to be used in all texts 
  
 /********************************************************************************
  *                                                                              *
  *                               Constructors                                   *
  *                                                                              *
  ********************************************************************************/
  
  Chart(int chartWidth, int chartHeight, String labelX, String labelY, String title, String[] xValues, float[] yValues) {
  }
  
  Chart(int chartWidth, int chartHeight, String labelX, String labelY, String title, float[] xValues) {
    this.chartWidth = chartWidth;
    this.chartHeight = chartHeight;
    
    this.labelX = labelX;
    this.labelY = labelY;
    this.title = title;
    
    hasYAxis = true;
    hasXAxis = true;
    hasYLabel = true;
    hasXLabel = true;
    hasTitle = true;
    hasXAxisLines = false;
    hasYAxisLines = false;
    
    this.xValues = xValues;
    
    xMinValue = min(xValues);
    xMaxValue = max(xValues);
    
    dataStrokeWeight = DEFAULT_DATASTROKEWEIGHT;
    dataStrokeColor = DEFAULT_DATASTROKECOLOR;
    
    chartLabelsFont = createFont(DEFAULT_FONT, DEFAULT_FONTSIZE);
    textFont(chartLabelsFont);
    fontColor = COLOR_BLACK;
  }
  
  Chart(int chartWidth, int chartHeight, String labelX, String labelY, String title, float[] xValues, float[] yValues) {
    this(chartWidth, chartHeight, labelX, labelY, title, xValues);
    
    this.yValues = yValues;
    
    yMinValue = min(yValues);
    yMaxValue = max(yValues);
  }
  
 /********************************************************************************
  *                                                                              *
  *                               Functions                                      *
  *                                                                              *
  ********************************************************************************/ 
 
 /*
  * function: drawTitle()
  * 
  * Draws the title of the Chart
  */
  void drawTitle() {
    textSize(DEFAULT_CHART_TITLE_FONT_SIZE);
    textAlign(LEFT, CENTER);
    text(title, 0, -11); // XXX - This has to be done automatically. In future versions.
  }
  
 /*
  * function: drawYLabel()
  * 
  * Draws the label of the Y axis
  */
  void drawYLabel() {
    fill(fontColor);
    textSize(DEFAULT_CHART_LABELS_FONT_SIZE);
    textAlign(CENTER, CENTER);
    text(labelY, -50, chartHeight / 2); // XXX - This has to be done automatically. In future versions.
  }
  
 /*
  * function: drawXLabel()
  * 
  * Draws the label of the X axis
  */
  void drawXLabel() {
    fill(fontColor);
    textSize(DEFAULT_CHART_LABELS_FONT_SIZE);
    textAlign(CENTER, CENTER);
    text(labelX, chartWidth / 2, chartHeight + 20); // XXX - This has to be done automatically. In future versions.
    
  }
  
 /*
  * function: drawYAxis()
  * 
  * Draws the Y axis of the Chart with the appropiate labels
  */
  void drawYAxis() {
    stroke(dataStrokeColor);
    fill(fontColor);
    strokeWeight(1);
    textSize(8);
    textAlign(RIGHT, CENTER);
    
    int pixelsInterval = calculateYMinInterval();
    
    line(0, 0, 0, chartHeight);
    
    for(float i = chartHeight; i > 0; i -= pixelsInterval) {
      if( i % yInterval == 0 ) {
        line(0, i, -5, i);
        if( isYAxisInt ) {
          text((int)map(i, chartHeight, 0, yMinValue, yMaxValue), -10, i);
        }
        else {
          text(map(i, chartHeight, 0, yMinValue, yMaxValue), -10, i);
        }
      }
    }
  }
  
  
 /*
  * function: drawXAxis()
  *
  * Draws the X axis of the Chart with the appropiate labels
  *
  */
  void drawXAxis() {
    stroke(dataStrokeColor);
    fill(fontColor);
    strokeWeight(1);
    textSize(DEFAULT_CHART_LABELS_FONT_SIZE);
    textAlign(CENTER, TOP);
    line(0, chartHeight, chartWidth, chartHeight);
    
    for(int i = 0; i < xValues.length; i++) {
      float xLabelCoord = map(xValues[i], xMinValue, xMaxValue, 0, chartWidth);
      if( i % xInterval == 0 ) {
        line(xLabelCoord, chartHeight, xLabelCoord, chartHeight + 5);
        if( isXAxisInt ) {
          text((int)xValues[i], xLabelCoord, chartHeight + 10);
        }
        else {
          text(xValues[i], xLabelCoord, chartHeight + 10);        
        }
      }
    }
  }
  
 /*
  * function: drawXAxisLines()
  * 
  * Draws lines parallel to the X axis
  */
  void drawXAxisLines() {
    fill(fontColor);
    stroke(224);
    strokeWeight(0.5);
    
    for(int i = 1; i < xValues.length - 1; i++) {
      float xLabelCoord = map(xValues[i], xMinValue, xMaxValue, 0, chartWidth);
      line(xLabelCoord, 0, xLabelCoord, chartHeight - 1);
    }
  }
  
 /*
  * function: drawYAxisLines()
  * 
  * Draws lines parallel to the Y axis
  */
  void drawYAxisLines() {
    fill(fontColor);
    stroke(0);
    strokeWeight(0.5);
    
    int pixelsInterval = calculateYMinInterval();
    
    for(float i = chartHeight; i > 0; i -= pixelsInterval) {
      if( i % yInterval == 0 ) {
        for( int j = 1; j < chartWidth; j+=5 ) {
        //line(1, i, chartWidth, i);
          point(j, i);
        }
          
      }
    }
  }
  
 /*
  * function: drawDara
  * 
  * This function draws the actual data of the Chart. It is implements in the Child classes
  */
  void drawData() {
  }
  
 /*
  * function: calculateXMinInterval()
  * 
  * Calculates in pixels the interval between the labels of the X axis.
  * If the module of the division of the height of the chart by the difference of the
  * max value minus the min value is not equal to zero, means that we have a float number,
  * which is not good (During the adding of the pixels we may lost some and that may lead
  * to a big deviaton of our data). By descending the chartWidth, the function tries to 
  * find the best height in order for the division to be perfect. After that, the height is
  * changed and the chart will be plotted to the new height.
  *
  */
  protected int calculateXMinInterval() {
    float diff = xMaxValue - xMinValue;
    
    while ( chartWidth % diff != 0 ) {
      chartWidth--;
    }
    
    return (int)(chartWidth / diff);
      
  }
  
  
 /*
  * function: calculateYMinInterval()
  * 
  * Calculates in pixels the interval between the labels of the Y axis.
  * If the module of the division of the height of the chart by the difference of the
  * max value minus the min value is not equal to zero, means that we have a float number,
  * which is not good (During the adding of the pixels we may lost some and that may lead
  * to a big deviaton of our data). By descending the chartHeight, the function tries to 
  * find the best height in order for the division to be perfect. After that, the height is
  * changed and the chart will be plotted to the new height.
  *
  */
  private int calculateYMinInterval() {
    float diff = yMaxValue - yMinValue;
    
    while ( chartHeight % diff != 0 ) {
      chartHeight--;
    }
    
    return (int)(chartHeight / diff);
      
  }
  
 /*
  * function: display()
  * 
  * Displays(draws) the chart to the screen.
  */
  public void display() {
    // The order of the drawing IS important. The height and width of the Chart may change by
    // some pixels based on the data that has to be displayed (The Chart may become smaller by
    // some pixels in order to draw the Axes correctly).
    pushMatrix();
      translate(70, 0); // XXX - This has to be automatic. Will be implemented in the next version
      if( hasYAxis ) {
        drawYAxis();
      }
      
      if( hasXAxis ) {
        drawXAxis();
      }
      
      if( hasTitle ) {
        drawTitle();
      }
      
      if( hasXLabel ) {
        drawXLabel();
      }
      
      if( hasYLabel ) {
        drawYLabel();
      }
      
      if( hasXAxisLines ) {
        drawXAxisLines();
      }
      
      if( hasYAxisLines ) {
        drawYAxisLines();
      }
      
      drawData();
    popMatrix();
        
  }
 
/********************************************************************************
 *                                                                              *
 *       Set functions for all the protected and private class members          *
 *                                                                              *
 ********************************************************************************/
  
  public void setXValues(float []xValues) {
    this.xValues = xValues;
  }
  
  public void setYValues(float []yValues) {
    this.yValues = yValues;
  }
  
  public void setHasYAxis(boolean hasYAxis) {
    this.hasYAxis = hasYAxis;
  }
  
  public void setChartColor(int chartColor) {
    this.chartColor = chartColor;
  }
  
  public void setXMinValue(float xMinValue) {
    this.xMinValue = xMinValue;
  }
  
  public void setXMaxValue(float xMaxValue) {
    this.xMaxValue = xMaxValue;
  }
  
} // End of class

