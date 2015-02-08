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

java.util.Map CartogramName = new HashMap();

boolean clicked = false;

//Turn on full-screen mode
boolean sketchFullScreen() {
    return true;
}

void setup() {
    PFont labelFont = loadFont("ArialMT-30.vlw");
    textFont(labelFont, textHeight);

    size(screenWidth, screenHeight);
    initialize();
    
    CartogramName.put("Area", "Area");
    CartogramName.put("Birth rate(births/1000 population)", "");
    CartogramName.put("Current account balance", "");
    CartogramName.put("Death rate(deaths/1000 population)", "");
    CartogramName.put("Debt - external", "Debt");
    CartogramName.put("Electricity - consumption(kWh)", "");
    CartogramName.put("Electricity - production(kWh)", "");
    CartogramName.put("Exports", "");
    CartogramName.put("GDP", "");
    CartogramName.put("GDP - per capita", "");
    CartogramName.put("GDP - real growth rate(%)", "");
    CartogramName.put("HIV/AIDS - adult prevalence rate(%)", "");
    CartogramName.put("HIV/AIDS - deaths", "");
    CartogramName.put("HIV/AIDS - people living with HIV/AIDS", "");
    CartogramName.put("Highways(km)", "");
    CartogramName.put("Imports", "");
    CartogramName.put("Industrial production growth rate(%)", "");
    CartogramName.put("Infant mortality rate(deaths/1000 live births)", "");
    CartogramName.put("Inflation rate (consumer prices)(%)", "");
    CartogramName.put("Internet hosts", "");
    CartogramName.put("Internet users", "");
    CartogramName.put("Investment (gross fixed)(% of GDP)", "");
    CartogramName.put("Labor force", "");
    CartogramName.put("Life expectancy at birth(years)", "");
    CartogramName.put("Military expenditures - dollar figure", "");
    CartogramName.put("Military expenditures - percent of GDP(%)", "");
    CartogramName.put("Natural gas - consumption(cu m)", "");
    CartogramName.put("Natural gas - exports(cu m)", "");
    CartogramName.put("Natural gas - imports(cu m)", "");
    CartogramName.put("Natural gas - production(cu m)", "");
    CartogramName.put("Natural gas - proved reserves(cu m)", "");
    CartogramName.put("Oil - consumption(bbl/day)", "");
    CartogramName.put("Oil - exports(bbl/day)", "");
    CartogramName.put("Oil - imports(bbl/day)", "");
    CartogramName.put("Oil - production(bbl/day)", "");
    CartogramName.put("Oil - proved reserves(bbl)", "");
    CartogramName.put("Population", "");
    CartogramName.put("Public debt(% of GDP)", "");
    CartogramName.put("Railways(km)", "");
    CartogramName.put("Reserves of foreign exchange & gold", "");
    CartogramName.put("Telephones - main lines in use", "");
    CartogramName.put("Telephones - mobile cellular", "");
    CartogramName.put("Total fertility rate(children born/woman)", "");
    CartogramName.put("Unemployment rate(%)", "");
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
    if(!clicked)
    {
        clicked = true;
        map.mouseClicked();
        for(Button button: buttons)
        {
            button.mouseClicked();
        }
    }
}

void mouseReleased()
{
    clicked = false;
}
