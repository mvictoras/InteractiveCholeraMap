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
 *                                class DataParser                              *
 *                                                                              *
 * Class for reading the data files and doing calculations on these.            *
 *                                                                              *
 ********************************************************************************/
class DataParser {
  
 /********************************************************************************
  *                                                                              *
  *                               Class Members                                  *
  *                                                                              *
  ********************************************************************************/
   // Deathdays.txt
  private String[] deathDaysDate;
  private float[] numberOfDeaths;
  
  private boolean[] showDate;
  
  // streets.txt
  private String[] streets;
  
  // deathsAgeMF.txt
  private float[] deathsXCoord;
  private float[] deathsYCoord;
  private int[] deathsAge; // Can make this enum
  private int[] deathsMF;
  private boolean[] showDeath;
  private float[] numberOfDeadMales;
  private float[] numberOfDeadFemales;
  
  // By gender
  private float[] numberOfDeadAgesMales;
  private float[] numberOfDeadAgesFemales;
  
  private float[] numberOfDeadAges0;
  private float[] numberOfDeadAges1;
  private float[] numberOfDeadAges2;
  private float[] numberOfDeadAges3;
  private float[] numberOfDeadAges4;
  private float[] numberOfDeadAges5;
  
  // Pumps.txt
  private float[] pumpsXCoord, pumpsYCoord;
  
 /********************************************************************************
  *                                                                              *
  *                               Constructors                                   *
  *                                                                              *
  ********************************************************************************/
  DataParser() {
  }
  
 /********************************************************************************
  *                                                                              *
  *                               Functions                                      *
  *                                                                              *
  ********************************************************************************/ 
  
 /********************************************************************************
  *                                                                              *
  *                          Reading from data files                             *
  *                                                                              *
  ********************************************************************************/
  
 /*
  * function: readPumpsFile(String)
  * 
  * filename - The name of the data file to be read
  *
  * Reads the file with the coordinates of the pumps locations.
  */
  public void readPumpsFile(String filename) {
    String[] pumps = loadStrings(filename);
    
    pumpsXCoord = new float[pumps.length];
    pumpsYCoord = new float[pumps.length];
    
    for( int i = 0; i < pumps.length; i++ ) {
      String[] dataRead = split(pumps[i], "\t" );
      pumpsXCoord[i] = float(dataRead[0]);
      pumpsYCoord[i] = float(dataRead[1]);
    }
  }
  
 /*
  * function: readDeathdaysFile(String)
  * 
  * filename - The name of the data file to be read
  *
  * Reads the file with the dates and number of deaths per day.
  */
  public void readDeathdaysFile(String filename) {
    String[] deathDays = loadStrings(filename);
    
    deathDaysDate = new String[deathDays.length];
    numberOfDeaths = new float[deathDays.length];
    showDate = new boolean[deathDays.length];
    
    for( int i = 0; i < deathDays.length; i++ ) {
      String[] dataRead = split(deathDays[i], "\t" );
      
      deathDaysDate[i]  = dataRead[0];
      numberOfDeaths[i] = float(dataRead[1]);
      showDate[i]       = true;
    }
    
    numberOfDeadMales = new float[deathDaysDate.length];        // The size of the array will be the number of the days 
    numberOfDeadFemales = new float[deathDaysDate.length];
    numberOfDeadAgesMales = new float[6];
    numberOfDeadAgesFemales = new float[6];
    
    numberOfDeadAges0 = new float[deathDaysDate.length];
    numberOfDeadAges1 = new float[deathDaysDate.length];
    numberOfDeadAges2 = new float[deathDaysDate.length];
    numberOfDeadAges3 = new float[deathDaysDate.length];
    numberOfDeadAges4 = new float[deathDaysDate.length];
    numberOfDeadAges5 = new float[deathDaysDate.length];
 
    
    initializeArray(numberOfDeadMales);
    initializeArray(numberOfDeadFemales);
    initializeArray(numberOfDeadAgesMales);
    initializeArray(numberOfDeadAgesFemales);
    initializeArray(numberOfDeadAges0);
    initializeArray(numberOfDeadAges1);
    initializeArray(numberOfDeadAges2);
    initializeArray(numberOfDeadAges3);
    initializeArray(numberOfDeadAges4);
    initializeArray(numberOfDeadAges5);
  }
  
 /*
  * function: readDeathsAgeMFFile(String)
  * 
  * filename - The name of the data file to be read
  *
  * Reads the file with the deaths Ages, Gender and coordinates.
  */
  public void readDeathsAgeMFFile(String filename) {
    String[] deathsAgeMF = loadStrings(filename);
    
    deathsXCoord = new float[deathsAgeMF.length];
    deathsYCoord = new float[deathsAgeMF.length];
    deathsAge    = new int[deathsAgeMF.length];
    deathsMF     = new int[deathsAgeMF.length];
    showDeath    = new boolean[deathsAgeMF.length];
    
    for( int i =0; i < deathsAgeMF.length; i++ ) {
      String[] dataRead = split(deathsAgeMF[i], "\t" );
      
      deathsXCoord[i] = float(dataRead[0]);
      deathsYCoord[i] = float(dataRead[1]);
      deathsAge[i]    = int(dataRead[2]);
      deathsMF[i]     = int(dataRead[3]);
      showDeath[i]    = true;
    }
    
    calulcateNumberOfDeadbyGendersAndAge();
  }
  
 /*
  * function: readStreetsFile(String)
  * 
  * filename - The name of the data file to be read
  *
  * XXX - Does not reads any filename. The file is readen in CholeraMap.
  */
  public void readStreetsFile(String filename) {
    this.streets = loadStrings(filename);
  }
  
 /********************************************************************************/
 
 /*
  * function: calulcateNumberOfDeadbyGendersAndAge()
  *
  * Calculates the number of deaths by Gender and by Sex.
  */
  private void calulcateNumberOfDeadbyGendersAndAge() {
    int deadCounter = 0;
    // Initially see how many people dies each day.
    for( int i = 0; i < numberOfDeaths.length; i++ ) {
      // For each day, see how many died and seek them in the deathsMF
      for( int j = deadCounter; j < (deadCounter + numberOfDeaths[i]); j++ ) {
        if( deathsMF[j] == 0 ) {
          numberOfDeadMales[i]++;
          numberOfDeadAgesMales[deathsAge[i]]++;
        }
        else {
          numberOfDeadFemales[i]++;
          numberOfDeadAgesFemales[deathsAge[i]]++;
        }
        switch(deathsAge[i]) {
          case 0:
            numberOfDeadAges0[i]++;
            break;
          case 1:
            numberOfDeadAges1[i]++;
            break;
          case 2:
            numberOfDeadAges2[i]++;
            break;
          case 3:
            numberOfDeadAges3[i]++;
            break;
          case 4:
            numberOfDeadAges4[i]++;
            break;
          default:
            numberOfDeadAges5[i]++;
            break;
        }
      
      }
      deadCounter += numberOfDeaths[i];
    }
  }
  
 /*
  * function: showDatesDuringScrolling(int)
  *
  * index - The index of the array
  *
  * This function initializes to true all the data before index in the showDate array
  * and to false all the data after the index. I do that, because during scrolling, I have
  * to be sure that everything left of the scrollbar is showed on the map and everything 
  * on the right is hidden.
  */
  public void showDatesDuringScrolling(int index) {
    for( int i = 0; i <= index; i++ ) {
      showDate[i] = true;
    }
    
    for( int i = index + 1; i < showDate.length; i++ ) {
      showDate[i] = false;
    }
  }
  
  
 /********************************************************************************
  *                                                                              *
  *       Length functions for all the protected and private class members       *
  *                                                                              *
  ********************************************************************************/
  
  public int deathsAgeMFlength() {
    return deathsXCoord.length;
  }
  
  public int deathDayslength() {
    return deathDaysDate.length;
  }
  
  public int showDeathlength() {
    return showDeath.length;
  }
  
  public int numberOfDeathslength() {
    return numberOfDeaths.length;
  }
  
  public int deathDaysDatelenth() {
    return deathDaysDate.length;
  }
  
 /********************************************************************************
  *                                                                              *
  *       Set functions for all the protected and private class members          *
  *                                                                              *
  ********************************************************************************/
  
  public void setShowDeath(int position, boolean newValue) {
    showDeath[position] = newValue;
  }
  
  public void setShowDate(int position, boolean newValue) {
    showDate[position] = newValue;
  }
  
 /********************************************************************************
  *                                                                              *
  *       Get functions for all the protected and private class members          *
  *                                                                              *
  ********************************************************************************/
  
  public boolean getShowDate(int position) {
    return showDate[position];
  }
  
  public String[] getDeathDaysDate() {
    return deathDaysDate;
  }
  
  public float[] getNumberOfDeaths() {
    return numberOfDeaths;
  }
  
  public boolean[] getShowDate() {
    return showDate;
  }
  
  public String[] getStreets() {
    return streets;
  }
  
  public float[] getDeathsAge() {
    float[] deathsAgeF;
    deathsAgeF = new float[deathsAge.length];
    
    for( int i = 0; i < deathsAge.length; i++ )
      deathsAgeF[i] = deathsAge[i];
    return deathsAgeF;
  }
  
  public boolean getShowDeath(int position) {
    return showDeath[position];
  }
  
  public float getDeathsXCoord(int index) {
    return deathsXCoord[index];
  }
  
  public float getDeathsYCoord(int index) {
    return deathsYCoord[index];
  }
  
  public int getDeathsAge(int index) {
    return deathsAge[index];
  }
  
  public int getDeathsMF(int index) {
    return deathsMF[index];
  }
  
  public float getNumberOfDeaths(int index) {
    return numberOfDeaths[index];
  }
  
  public float[] getDeathsByAge() {
    float[] deathsByAge = new float[6];
    
    for( int i = 0; i < numberOfDeaths.length; i++ ) {
      deathsByAge[deathsAge[i]] += numberOfDeaths[i];
    }
    
    return deathsByAge;  
  }
  
  public float[] getNumberOfDeadMales() {
    return numberOfDeadMales;
  }
  
  public float[] getNumberOfDeadFemales() {
    return numberOfDeadFemales;
  }
  public float[] getNumberOfDeadAges0() {
    return numberOfDeadAges0;
  }
  
  public float[] getNumberOfDeadAges1() {
    return numberOfDeadAges1;
  }
  
  public float[] getNumberOfDeadAges2() {
    return numberOfDeadAges2;
  }
  
  public float[] getNumberOfDeadAges3() {
    return numberOfDeadAges3;
  }
  
  public float[] getNumberOfDeadAges4() {
    return numberOfDeadAges4;
  }
  
  public float[] getNumberOfDeadAges5() {
    return numberOfDeadAges5;
  }
  
  public float[] getNumberOfDeadAgesMales() {
    return numberOfDeadAgesMales;
  }
  
  public float[] getNumberOfDeadAgesFemales() {
    return numberOfDeadAgesFemales;
  }
  
  public int getNumberOfDeathslength() {
    return numberOfDeaths.length;
  }
  
    public int getPumpslength() {
    return pumpsXCoord.length;
  }
  
  public float getPumpsXCoord(int index) {
    return pumpsXCoord[index];
  }
  
  public float getPumpsYCoord(int index) {
    return pumpsYCoord[index];
  }
  
} // End of class
