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
import controlP5.*;

int screenWidth = 1366;
int screenHeight = 768;

int midX = (0 + screenWidth) / 2;
int midY = (0 + screenHeight) / 2;

//Main folder of the project containing all the necessary data to draw the map
String mainFolder = "data";

//color[] countryColors = new color[]{ color(105, 211, 105), color(50, 195, 50, 255),
//                                    color(20, 135, 20, 255),color(0, 155, 40, 255), 
//                                     //color(48, 128, 20,255),
//                                     color(0,175,0, 255)//
//                                   };

color[] countryColors = new color[]{ color(135,195,105, 255), color(212, 232, 160, 255),
                                    color(105, 211, 105,255),color(0, 155, 40, 255),//color(99, 177, 80, 255),// 
                                     //color(48, 128, 20,255),
                                     color(253, 253, 190, 255)//
                                   };

//color[] countryColors = new color[]{ color(135, 195, 105), color(212, 232, 160, 255),
//                                    color(0,175,0, 255), color(99, 177, 80, 255),
//                                     //color(48, 128, 20,255),
//                                     //
//                                     color(253, 253, 190, 255)
//                                   };
                                   
                                    
//Color of the seas
//color seaColor = color(170, 225, 230, 255);
color seaColor = color(194, 223, 255, 255);//color(77, 210, 255, 100);
color controlsBackgroundColor = color(255, 255, 255, 255);

//Only used for normalizing the borders
boolean[][] screenMark = new boolean[screenWidth][screenHeight];
//Reserved for zooming
int ratio = 100;

String[] countryFields;

List<String> chosenCountryNames = new ArrayList();
List<String> chosenCriteria = new ArrayList();

int textHeight = 16;

ControlP5 controlP5;

Map map = null;
CorrelationGraph correlationGraph;
Combi combi;

boolean firstCorrelationButtonCall = true;
boolean firstCombiButtonCall = true;

//Turn on full-screen mode
boolean sketchFullScreen() {
    return true;
}

static final int MODE_CARTOGRAM = 0;
static final int MODE_CORRELATION = 1;
static final int MODE_COMBI = 2;

int usedMode = MODE_CARTOGRAM;

void setup() {
    PFont labelFont = loadFont("ArialMT-30.vlw");
    textFont(labelFont, textHeight);    
    size(screenWidth, screenHeight);

    initialize();
    
}

void draw() {
    background(controlsBackgroundColor);
    switch(usedMode)
    {
        case MODE_CARTOGRAM:
            map.draw();
            break;
        case MODE_CORRELATION:
            correlationGraph.draw();
            break;
        case MODE_COMBI:
            combi.draw();
            break;
    }
}

void initializeMap()
{
    map = new Map();    
    map.getBorderFromFile(sketchPath(mainFolder + "\\Cartograms\\Area.txt"), true);
    getCountryInfo();
    WriteToFile();
}

void initialize()
{
    controlP5 = new ControlP5(this);
    correlationGraph = new CorrelationGraph(10,10,1000,600);
    combi = new Combi();
    
    initializeCartogramFiles();
    initializeMap();
    initializeButtons();
    initializeCountryList();
    initializeCriteriaList();
}

void mouseMoved()
{
    switch(usedMode)
    {
        case MODE_CARTOGRAM:
            map.mouseMoved();
            break;
        case MODE_CORRELATION:
            correlationGraph.mouseMoved(mouseX, mouseY);
            break;
        case MODE_COMBI:
            combi.mouseMoved();
            break;
    }
}

void mouseClicked()
{
    switch(usedMode)
    {
        case MODE_CARTOGRAM:
            map.mouseClicked();
            break;
        case MODE_CORRELATION:
            correlationGraph.mousePressed(mouseX, mouseY);
            break;
        case MODE_COMBI:
            combi.mouseClicked();
            break;
    }
}

void keyPressed(){
    if(usedMode == MODE_COMBI)
        combi.keyPressed();
}

void controlEvent(ControlEvent event) {
    
    if(event.isGroup()){
        if(event.name().equals("countryList")){
            countryListControlEvent(event);
        }
        else if(event.name().equals("chosenCountryList")){
            chosenCountryListControlEvent(event);
        }
        else if(event.name().equals("criteriaList")){
            criteriaListControlEvent(event);
        }
        else if(event.name().equals("chosenCriteriaList")){
            chosenCriteriaListControlEvent(event);
        }
    }
}

void updateListOfChosenCountriesAndCriteria()
{
    chosenCountryNames.clear();
    chosenCriteria.clear();
    
    if(chosenCountryList != null)
    {
        System.out.println("chosenCountryList" + chosenCountryList.getListBoxItems().length);
        String[][] countryNames = chosenCountryList.getListBoxItems();
        for(int i = 0; i < countryNames.length; ++i)
            chosenCountryNames.add(countryNames[i][0]);
    }
    
    if(chosenCriteriaList != null)
    {
        System.out.println("chosenCriteriaList" + chosenCriteriaList.getListBoxItems().length);
        String[][] criteriaNames = chosenCriteriaList.getListBoxItems();
        for(int i = 0; i < criteriaNames.length; ++i)
            chosenCriteria.add(criteriaNames[i][0]);
    }
}
