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
 
 /******************************************************************************
 *                                     PR1                                     *
 *                                                                             *
 * PR1 is the startup file. It contains all the functions that interact with   *
 * the user, the setup() function which is called only at the startup of the   *
 * program and the draw, that is called every time the window must be drawn    *
 * again (either manually by calling the redraw() function, either because of  *
 * the refresh rate of the program.                                            *
 *                                                                             *
 *------------------------------------Variables--------------------------------*
 *                                                                             *
 * area       - object of type DrawingArea. All the drawing of the window is   *
 *              handled with this object.                                      *
 *******************************************************************************/
DrawingArea area;

/*
 * function: setup()
 * 
 * From reference manual (http://processing.org/reference/setup_.html):
 * Called once when the program is started. Used to define initial enviroment properties such 
 * as screen size, background color, loading images, etc. before the draw() begins executing. 
 * Variables declared within setup() are not accessible within other functions, includingdraw(). 
 * There can only be one setup() function for each program and it should not be called again 
 * after it's initial execution.
 *
 * The reference states (http://processing.org/reference/size_.html):
 * The size() function must be the first line in setup().
 * Do not use variables as the parameters to size() command, because it will cause problems 
 * when exporting your sketch. When variables are used, the dimensions of your sketch cannot 
 * be determined during export. Instead, employ numeric values in the size() statement, and 
 * then use the built-in width and height variables inside your program when you need the 
 * dimensions of the display window are needed.
 */
void setup() {
  size(1010, 650); // Explained un function documentation (look up).  
  
  // Create a DataParser to parse the datafiles.
  DataParser fileData = new DataParser();
  
  // Read the various data files, calling the appropriate functions.
  fileData.readDeathdaysFile(deathDaysFilePath);
  fileData.readDeathsAgeMFFile(deathsAgeMFPath);
  fileData.readPumpsFile(pumpsPath);
  fileData.readStreetsFile(streetsPath);
  
  area = new DrawingArea(fileData);
  
  loop();
}

/*
 * function: draw()
 * Draw is called by the program either manually by calling the redraw function, 
 * either because of the refrash rate of the program. Initially it clears the data
 * that are present in the window and then calls the display funtion of the area
 * object to handle the drawing.
 */
void draw() {
  // Clear the window
  background(CLEAR_COLOR);
  area.display();

}

/*
 * function: mousePressed()
 *
 * Called every time a button of the mouse is pressed.
 */
void mousePressed() { 
 area.mousePressed();
}

/*
 * function: mouseMoved()
 *
 * Called every time the mouse is moved.
 */
void mouseMoved() {
  area.mouseMoved();
}

/*
 * function: mouseDragged()
 *
 * Called every time the mouse is dragged. Dragging means moving the mouse
 * while a button is pressed.
 */
void mouseDragged() {
  area.mouseDragged();
}
