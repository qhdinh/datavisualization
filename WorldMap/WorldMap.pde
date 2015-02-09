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
//String mainFolder = "D:\\Cloud\\Copy\\Copy\\Projects\\Processing\\WorldMap data\\Map 1";
//String mainFolder = "H:/INF229/projet/datavisualization/Data";
String mainFolder = "D:\\";

color[] countryColors = new color[]{ color(179, 153, 255, 255), color(255, 253, 230, 255),
                                    color(255, 214, 92, 255), color(255, 179, 153, 255), 
                                    color(153, 255, 179, 255),
                                    color(255, 230, 153, 255), color(153, 255, 182, 255)};
//Color of the seas
color seaColor = color(77, 210, 255, 100);
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
}

void initializeMap()
{
    map = new Map();    
    map.getBorderFromFile(mainFolder + "\\original borders.txt", true);
    getCountryInfo();
    WriteToFile();
}

void initialize()
{
    controlP5 = new ControlP5(this);
    initializeCartogramFiles();
    initializeMap();
    initializeButtons();
    initializeCountryList();
    initializeCriteriaList();
}

void mouseMoved()
{
    map.mouseMoved();
}

void mouseClicked()
{
    map.mouseClicked();
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
