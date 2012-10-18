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
 *                      class HorizontalBarChart                                *
 *                 Chart - > BarChart - > HotizontalBarChart                    *
 * HorizontalBarChart class is class for creating horizontal bar charts.        *
 *                                                                              *
 ********************************************************************************/
 
class HorizontalBarChart extends BarChart {
  
 /********************************************************************************
  *                                                                              *
  *                               Constructors                                   *
  *                                                                              *
  ********************************************************************************/
  HorizontalBarChart(int chartWidth, int chartHeight, String labelX, String labelY, String title, float[] xValues, float[] yValues) {
    super(chartWidth, chartHeight, labelX, labelY, title, xValues, yValues);
  }
  
  HorizontalBarChart(int chartWidth, int chartHeight, String labelX, String labelY, String title, String[] xValues, float[] yValues) {
    super(chartWidth, chartHeight, labelX, labelY, title, xValues, yValues);
  }
  
  HorizontalBarChart(int chartWidth, int chartHeight, String labelX, String labelY, String title, float[] xValues) {
    super(chartWidth, chartHeight, labelX, labelY, title, xValues);
  }
  
 /********************************************************************************
  *                                                                              * 
  *                               Functions                                      *
  *                                                                              *
  ********************************************************************************/
  
 /*
  * function: drawData()
  * 
  * Overridden function.
  * Draws the actual data of the plotted chart.
  */
  void drawData() {
    textSize(9);
    textAlign(CENTER, CENTER);
    rectMode(CORNER);
    noStroke();
    
    for(int i = 0; i < xValues.length; i++) {  
      float xCoord = map(xValues[i], xMinValue, xMaxValue, 0, chartWidth);
      float yCoord = map(i + 1, 0, 6, chartHeight, 0);
      fill(chartColor);
      rect(0, yCoord, xCoord, 2 * DEFAULT_BAR_WIDTH);
      fill(fontColor);
      text((int)xValues[i], xCoord + 13, yCoord + 3);
      //point(xCoord, yCoord);
    }
  }
  
 /*
  * function: drawData(float[], int)
  * 
  * xValues    : The array with the values of the X axis to be plotted
  * chartColor : The color of the plotted data
  *
  * Overloaded function.
  * Draws the actual data of the plotted chart. 
  */
  void drawData(float[] xValues, int chartColor) {
    textSize(9);
    textAlign(CENTER, CENTER);
    rectMode(CORNER);
    noStroke();
    
    for(int i = 0; i < xValues.length; i++) {  
      float xCoord = map(xValues[i], xMinValue, xMaxValue, 0, chartWidth);
      float yCoord = map(i + 1, 0, 6, chartHeight, 0);
      fill(chartColor);
      rect(0, yCoord - 2 * DEFAULT_BAR_WIDTH, xCoord, 2 * DEFAULT_BAR_WIDTH);
      fill(fontColor);
      text((int)xValues[i], xCoord + 13, yCoord - 5);
      //point(xCoord, yCoord);
    }
  }
  
 /*
  * function: drawAxis()
  *
  * Overridden function
  * Draws the X axis of the Chart with the appropiate labels
  *
  */
  void drawXAxis() {
    stroke(dataStrokeColor);
    fill(fontColor);
    strokeWeight(1);
    textSize(10);
    textAlign(CENTER, TOP);
    line(0, chartHeight, chartWidth, chartHeight);
    
    for(int i = 0; i < xMaxValue; i++) {
      float xLabelCoord = map(i, xMinValue, xMaxValue, 0, chartWidth);
      if( i % xInterval == 0 ) {
        line(xLabelCoord, chartHeight, xLabelCoord, chartHeight + 5);
        text(i, xLabelCoord, chartHeight + 10);
      }
    }
  }
  
 /*
  * function: drawXLabel()
  *
  * Overridden function  
  * Draws the label of the X axis
  */
  void drawXLabel() {
    fill(fontColor);
    textSize(10);
    textAlign(CENTER, CENTER);
    text(labelX, chartWidth / 2, chartHeight + 30);
    
  }
  
  /*
  * function: drawYAxis()
  * 
  * Overridden function
  * Draws the Y axis of the Chart with the appropiate labels
  */
  void drawYAxis() {
    stroke(dataStrokeColor);
    fill(chartColor);
    strokeWeight(1);
    textSize(8);
    textAlign(RIGHT, CENTER);
    
    line(0, 0, 0, chartHeight);
    
    for( int i = 0; i < xValues.length; i++ ) {
      float yCoord = map(i, 0, 5, chartHeight, 0);
      
      line(0, yCoord, -5, yCoord);
      text(i, -10, yCoord);
      
    }
  }
  
 /*
  * function: drawTitle()
  *
  * Overridden function 
  * Draws the title of the Chart
  */
  void drawTitle() {
    textSize(12);
    textAlign(LEFT, CENTER);
    text(title, 0, -22);
  }
  
}
