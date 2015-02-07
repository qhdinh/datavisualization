/*
|------------------------|
|MAIN FILE OF THE PROJECT|
|------------------------|
*/


import java.beans.PropertyDescriptor;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.BufferedOutputStream;
import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.lang.reflect.Array;
import java.math.*;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.lang.reflect.Array;
import java.text.NumberFormat;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.awt.Polygon;
import java.awt.Point;
import java.awt.geom.Point2D;
import java.awt.Rectangle;

int screenWidth = 1366;
int screenHeight = 768;

int midX = (0 + screenWidth) / 2;
int midY = (0 + screenHeight) / 2;

Map map = null;

//Main folder of the project containing all the necessary data to draw the map
//String mainFolder = "D:\\Cloud\\Copy\\Copy\\Projects\\Processing\\WorldMap data\\Map 1";
//String mainFolder = "H:/INF229/projet/datavisualization/Data";
String mainFolder = "D:\\";

//Colors of the countries, modify this to get a more beautiful map :D
color[] countryColors = new color[]{ color(0, 140, 0, 255), color(255, 0, 160, 255),
                                    color(63, 76, 107, 255), color(199, 152, 16, 255), color(128, 0, 0, 255),
                                    color(218, 165, 32, 255), color(0, 255, 255, 255)};
//Color of the seas
color seaColor = color(168, 255, 255, 255);
color controlsBackgroundColor = color(0, 0, 255, 255);

//Only used for normalizing the borders
boolean[][] screenMark = new boolean[screenWidth][screenHeight];
//Reserved for zooming
int ratio = 100;

String[] countryFields;
List<Button> buttons;

int textHeight = 16;

//Turn on full-screen mode
boolean sketchFullScreen() {
    return true;
}

void setup() {
    PFont labelFont = loadFont("ArialMT-30.vlw");
    textFont(labelFont, textHeight);

    size(screenWidth, screenHeight);
    initialize();
}

void draw() {
    background(controlsBackgroundColor);
    map.draw();
    
    for(Button button: buttons)
        button.draw();
}

void initializeButtons()
{
    buttons = new ArrayList();
    int initX = 5;
    int buttonWidth = 100;
    int initY = 50;
    int buttonHeight = 100; 
    
    for(int i = 1; i < 12; ++i)
    {
        Button newButton = new Button();
        
        int reducedPosition = countryFields[i].indexOf('(');
        if(reducedPosition > 0)
            newButton.caption = countryFields[i].substring(0, reducedPosition);
        else
            newButton.caption = countryFields[i];
        
        newButton.left = initX;
        newButton.top = initY;
        newButton.right = newButton.left + (int)textWidth(newButton.caption) + 20;
        newButton.bottom = newButton.top + textHeight + 20;
        newButton.infoIndex = i;
        
        buttons.add(newButton);
        
        initX += newButton.width();
    }
}

void initialize()
{
    map = new Map();
    map.getBorderFromFile(mainFolder + "\\original borders.txt", true);
    
    getCountryInfo();
    initializeButtons();
    
    
    WriteToFile();
}

void mouseMoved()
{
    map.mouseMoved();
    for(Button button: buttons)
    {
        button.mouseMoved();
    }
}

void mouseClicked()
{
    map.mouseClicked();
    for(Button button: buttons)
    {
        button.mouseClicked();
    }
}
