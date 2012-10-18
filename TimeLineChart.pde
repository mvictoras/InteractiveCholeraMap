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
 *                           class TimeLineChart                                *
 *                    Chart - > LineChart -> TimeLineChart                      *
 * TimeLineChart class is class for creating timeline line charts. The main     *
 * difference with the line chart, is that the X axis is composed of dates      *
 * which are of type String and not float.                                      *
 *                                                                              *
 ********************************************************************************/
 
class TimeLineChart extends Chart {
  
 /********************************************************************************
  *                                                                              *
  *                               Class Members                                  *
  *                                                                              *
  ********************************************************************************/
  
  private String[] xDateValues; // The dates of the plotted data.
  private boolean isBarChart;   // If this is true, a bar chart instead of a line chart is plotted.
  
 /********************************************************************************
  *                                                                              *
  *                               Constructors                                   *
  *                                                                              *
  ********************************************************************************/
  
  TimeLineChart(int chartWidth, int chartHeight, String labelX, String labelY, String title, float[] xValues, float[] yValues) {
    super(chartWidth, chartHeight, labelX, labelY, title, xValues, yValues);
  }
  
  // XXX - Have to rewrite this
  TimeLineChart(int chartWidth, int chartHeight, String labelX, String labelY, String title, String[] xValues, float[] yValues) {
    super(chartWidth, chartHeight, labelX, labelY, title, xValues, yValues);
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
    hasYAxisLines = true;
    
    this.xDateValues = xValues;
    
    this.yValues = yValues;
    
    yMinValue = min(yValues);
    yMaxValue = max(yValues);
    
    dataStrokeWeight = DEFAULT_DATASTROKEWEIGHT;
    dataStrokeColor = DEFAULT_DATASTROKECOLOR;
    
    chartLabelsFont = createFont(DEFAULT_FONT, DEFAULT_FONTSIZE);
    textFont(chartLabelsFont);
    
    isBarChart = false;
  }
  
  
 /********************************************************************************
  *                                                                              * 
  *                               Functions                                      *
  *                                                                              *
  ********************************************************************************/
  
 /*
  * function: drawAxis()
  *
  * Overridden function
  * Draws the X axis of the Chart with the appropiate labels
  *
  */
  void drawXAxis() {
    stroke(0);
    fill(0);
    strokeWeight(1);
    textSize(8);
    textAlign(CENTER, CENTER);
    line(0, chartHeight, chartWidth, chartHeight);
    
    for( int i = 0; i < xDateValues.length; i++ ) {
      if( i % xInterval == 0 ) {
        float xCoord = map(i, 0, xDateValues.length, 5, chartWidth);
        line(xCoord, chartHeight, xCoord, chartHeight + 5);
        text(xDateValues[i], xCoord, chartHeight + 10);
      }
    }
  }
  
 /*
  * function: drawXAxisLines()
  *
  * Overridden function 
  * Draws lines parallel to the X axis
  */
  void drawXAxisLines() {
    stroke(224);
    strokeWeight(0.5);
    
    for(int i = 1; i < xDateValues.length - 1; i++) {
      float xLabelCoord = map(i, 0, xDateValues.length, 5, chartWidth);
      line(xLabelCoord, 0, xLabelCoord, chartHeight - 1);
    }
  }
  
 /*
  * function: drawData()
  * 
  * Overridden function.
  * Draws the actual data of the plotted chart.
  */
  void drawData() {
    drawData(this.yValues, dataStrokeColor);
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
  void drawData(float[] yValues, int lineColor) {
    float xCoord, yCoord;
    rectMode(CORNERS);
    
    if( isBarChart ) {
      noStroke();
      fill(chartColor);
      for(int i = 0; i < xDateValues.length; i++) {  
        xCoord = map(i, 0, xDateValues.length, 5, chartWidth);
        yCoord = map(yValues[i], yMinValue, yMaxValue, chartHeight, 0);
        rect(xCoord - DEFAULT_BAR_WIDTH / 2, yCoord, xCoord + DEFAULT_BAR_WIDTH / 2, chartHeight);
      }
    }
    else {
      noFill();
      stroke(lineColor);
      strokeWeight(dataStrokeWeight);
      
      beginShape();
        for(int i = 0; i < xDateValues.length; i++) {  
          xCoord = map(i, 0, xDateValues.length, 5, chartWidth);
          yCoord = map(yValues[i], yMinValue, yMaxValue, chartHeight, 0);
          vertex(xCoord, yCoord);
        }
      endShape();
    }
  }
}
