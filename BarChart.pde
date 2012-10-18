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
 *                                class BarChart                                *
 *                              Chart - > BarChart                              *
 * BarChart class is a generic class for creating bar charts.                   *
 *                                                                              *
 ********************************************************************************/

class BarChart extends Chart {

  /********************************************************************************
   *                                                                              *
   *                               Constructors                                   *
   *                                                                              *
   ********************************************************************************/
  
  BarChart(int chartWidth, int chartHeight, String labelX, String labelY, String title, float[] xValues, float[] yValues) {
    super(chartWidth, chartHeight, labelX, labelY, title, xValues, yValues);
  }
  
  BarChart(int chartWidth, int chartHeight, String labelX, String labelY, String title, String[] xValues, float[] yValues) {
    super(chartWidth, chartHeight, labelX, labelY, title, xValues, yValues);
  }
  
  BarChart(int chartWidth, int chartHeight, String labelX, String labelY, String title, float[] xValues) {
    super(chartWidth, chartHeight, labelX, labelY, title, xValues);
  }
  
  
 /********************************************************************************
  *                                                                              * 
  *                               Functions                                      *
  *                                                                              *
  ********************************************************************************/
   
  /*
   * function: drawYAxis()
   * 
   * Overridden function.
   * Draws the Y axis of the Chart with the appropiate labels
   */
  public void drawYAxis(String[] yStringValues) {
    stroke(dataStrokeColor);
    fill(fontColor);
    strokeWeight(1);
    textSize(8);
    textAlign(RIGHT, CENTER);
    
    line(0, 0, 0, chartHeight);
    
    for( int i = 0; i < xValues.length; i++ ) {
      float yCoord = map(i + 1, 0, 6, chartHeight, 0);
      
      line(0, yCoord, -5, yCoord);
      text(yStringValues[i], -10, yCoord);
      
    }
  }
}
