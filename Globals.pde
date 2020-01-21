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

// Some Colors used
static int COLOR_BLACK                    = 0;
static int COLOR_WHITE                    = 255;
static int COLOR_BLUE                     = #000099;

static int CLEAR_COLOR                    = COLOR_WHITE;
static int DEFAULT_DATES_FONT_COLOR       = COLOR_WHITE;

static String deathDaysFilePath           = "data/deathdays.txt";
static String deathsAgeMFPath             = "data/deaths.age.mf.txt";
static String pumpsPath                   = "data/pumps.txt";
static String streetsPath                 = "data/streets.txt";

// Boxes
static int DEFAULT_LEFT_BOX_WIDTH         = 30;
static int DEFAULT_LEFT_BOX_HEIGHT        = 580;
static int DEFAULT_UPPER_BOX_WIDTH        = 1010;
static int DEFAULT_UPPER_BOX_HEIGHT       = 20;
static int DEFAULT_CHART_BOX_WIDTH        = 400;
static int DEFAULT_CHART_BOX_HEIGHT       = 580;
static int DEFAULT_MAP_WIDTH              = 580;
static int DEFAULT_MAP_HEIGHT             = 580;
static int DEFAULT_BOTTOM_BOX_WIDTH       = 1010;
static int DEFAULT_BOTTOM_BOX_HEIGHT      = 50;
static int DEFAULT_ANIMATION_BOX_WIDTH    = 300;
static int DEFAULT_ANIMATION_BOX_HEIGHT   = 150;
static int DEFAULT_ANIMATION_IMAGE_WIDTH  = 370; 
static int DEFAULT_ANIMATION_IMAGE_HEIGHT = 50;
static int DEFAULT_ANIMATION_BOX_X        = DEFAULT_LEFT_BOX_WIDTH + DEFAULT_MAP_WIDTH + 10; // 10 is the offset
static int DEFAULT_ANIMATION_BOX_Y        = DEFAULT_UPPER_BOX_HEIGHT + DEFAULT_CHART_BOX_HEIGHT - DEFAULT_ANIMATION_IMAGE_HEIGHT;

// Animation Hot Spots
static int DEFAULT_ANIMATION_PLAY_BUTTON_X_START = DEFAULT_LEFT_BOX_WIDTH + DEFAULT_MAP_WIDTH + 13 + 60;
static int DEFAULT_ANIMATION_PLAY_BUTTON_X_END   = DEFAULT_LEFT_BOX_WIDTH + DEFAULT_MAP_WIDTH + 13 + 60 + 30;
static int DEFAULT_ANIMATION_PLAY_BUTTON_Y_START = DEFAULT_ANIMATION_BOX_Y + 10;
static int DEFAULT_ANIMATION_PLAY_BUTTON_Y_END   = DEFAULT_ANIMATION_BOX_Y + 10 + 40;

static int DEFAULT_ANIMATION_BACK_BUTTON_X_START = DEFAULT_LEFT_BOX_WIDTH + DEFAULT_MAP_WIDTH + 13 + 9;
static int DEFAULT_ANIMATION_BACK_BUTTON_X_END   = DEFAULT_LEFT_BOX_WIDTH + DEFAULT_MAP_WIDTH + 13 + 11 + 40;
static int DEFAULT_ANIMATION_BACK_BUTTON_Y_START = DEFAULT_ANIMATION_BOX_Y + 15;
static int DEFAULT_ANIMATION_BACK_BUTTON_Y_END   = DEFAULT_ANIMATION_BOX_Y + 10 + 30;

static int DEFAULT_PROGRESS_ELLIPSE_X_START = 115;
static int DEFAULT_PROGRESS_ELLIPSE_X_END   = 360;
static int DEFAULT_PROGRESS_ELLIPSE_Y       = 35;
static int DEFAULT_PROGRESS_ELLIPSE_RADIUS  = 7;

static int DEFAULT_PROGRESS_ELLIPSE_X_START_HOTSPOT = DEFAULT_LEFT_BOX_WIDTH + DEFAULT_MAP_WIDTH + DEFAULT_PROGRESS_ELLIPSE_X_START + 5;
static int DEFAULT_PROGRESS_ELLIPSE_X_END_HOTSPOT   = DEFAULT_LEFT_BOX_WIDTH + DEFAULT_MAP_WIDTH + DEFAULT_PROGRESS_ELLIPSE_X_START + 14;
static int DEFAULT_PROGRESS_ELLIPSE_Y_START_HOTSPOT = DEFAULT_ANIMATION_BOX_Y + DEFAULT_PROGRESS_ELLIPSE_Y - 6;
static int DEFAULT_PROGRESS_ELLIPSE_Y_END_HOTSPOT   = DEFAULT_ANIMATION_BOX_Y + DEFAULT_PROGRESS_ELLIPSE_Y + 7;

// Used in DrawingArea
static int DEFAULT_MAP_PIXELS_WIDTH       = 580;
static int DEFAULT_CHART_WIDTH            = 320; 
static int DEFAULT_CHART_HEIGHT           = 200;
static int DEFAULT_BACKGROUND_COLOR       = #CCCC9A;
static int DEFAULT_MAP_ZOOM_BOXES_WIDTH   = 20;

// Bottom Box Graphics
static int DEFAULT_BOTTOM_BUTTON1_GRAPHICS_WIDTH    = 153;
static int DEFAULT_BOTTOM_BUTTON2_GRAPHICS_WIDTH    = 397;
static int DEFAULT_BOTTOM_BOX_GRAPHICS_HEIGHT       = 41;
static int DEFAULT_BOTTOM_BOX_GRAPHICS_X_OFFSET     = 10;
static int DEFAULT_BOTTOM_BOX_GRAPHICS_Y_OFFSET     = 5;
static int DEFAULT_BOTTOM_BOX_STROKE_WEIGHT         = 1;
static int DEFAULT_COLOR_SMALL_BOXES_WIDTH          = 10;
static int DEFAULT_BOTTOM_BUTTONS_TEXT              = 6;

// Used in Charts
static int     DEFAULT_DATASTROKEWEIGHT   = 2;
static int     DEFAULT_DATASTROKECOLOR    = 0;
static String  DEFAULT_FONT               = "SansSerif";
static int     DEFAULT_FONTSIZE           = 20;
static int     DEFAULT_BAR_WIDTH          = 4;
static String[]  DEFAULT_HOR_CHART_Y_TAGS   = { "0-10", "11-20", "21-40", "41-60", "61-80", ">80"};
static int     DEFAULT_CHART_TITLE_FONT_SIZE = 12;
static int     DEFAULT_CHART_LABELS_FONT_SIZE = 10;

static int    DEFAULT_MAP_TITLE_FONT_SIZE = 14; 
static String DEFAULT_MAP_TITLE           = "Snow Cholera Map";

static int DEFAULT_FONT_COLOR             = COLOR_BLACK; // Black

static int DEFAULT_MAP_TITLE_COORD_X      = 30;
static int DEFAULT_MAP_TITLE_COORD_Y      = 10;

static int DEFAULT_PANNING_OFFSET         = 3;
static int DEFAULT_ZOOM_OFFSET            = 20;

// DEATHS
static int DEFAULT_DEATH_COLOR_R          = 205;
static int DEFAULT_DEATH_COLOR_G          = 0;
static int DEFAULT_DEATH_COLOR_B          = 0;
static int DEFAULT_DEATH_MALE_COLOR       = #0191C8;
static int DEFAULT_DEATH_FEMALE_COLOR     = #FF0080;
/*
static int DEFAULT_DEATH_AGE_0_COLOR      = #FFFF66;
static int DEFAULT_DEATH_AGE_1_COLOR      = #FFCC00;
static int DEFAULT_DEATH_AGE_2_COLOR      = #FF9900;
static int DEFAULT_DEATH_AGE_3_COLOR      = #FF6600;
static int DEFAULT_DEATH_AGE_4_COLOR      = #FF3300;
static int DEFAULT_DEATH_AGE_5_COLOR      = #FF0000; */

static int DEFAULT_DEATH_AGE_0_COLOR      = COLOR_WHITE;
static int DEFAULT_DEATH_AGE_1_COLOR      = #ffd5e5;
static int DEFAULT_DEATH_AGE_2_COLOR      = #ff80b2;
static int DEFAULT_DEATH_AGE_3_COLOR      = #d40055;
static int DEFAULT_DEATH_AGE_4_COLOR      = #800033;
static int DEFAULT_DEATH_AGE_5_COLOR      = #2b0011;

static int DEFAULT_CIRLE_RADIUS           = 7;

static int DEFAULT_ENABLED_COLOR          = #666666;

// Images used
static String DEFAULT_STREET_NAMES_PATH   = "data/streetNames_smaller.png";

static void initializeArray(float[] arrayInit) {
  for(int i = 0; i < arrayInit.length; i++ ) {
    arrayInit[i] = 0;
  }
}
