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
import java.awt.Polygon;
import java.awt.Point;
import java.awt.geom.Point2D;
import java.awt.Rectangle;

//Limits of the coordinates
float minX = 0;
float maxX = 0;
float minY = 0;
float maxY = 0;

int screenWidth = 1366;
int screenHeight = 768;

int midX = (0 + screenWidth) / 2;
int midY = (0 + screenHeight) / 2;

Map map = new Map();

//Main folder of the project containing all the necessary data to draw the map
//String mainFolder = "D:\\Cloud\\Copy\\Copy\\Projects\\Processing\\WorldMap data\\Map 1";
String mainFolder = "D:/Cours/INF229/WorldMap/Map 1";

//Colors of the countries, modify this to get a more beautiful map :D
color[] countryColors = new color[]{color(255, 0, 136, 255), color(0, 140, 0, 255), color(255, 0, 0, 255),
                                    color(63, 76, 107, 255), color(199, 152, 16, 255), color(128, 0, 0, 255),
                                    color(218, 165, 32, 255), color(0, 255, 255, 255)};
//Color of the seas
color seaColor = color(168, 255, 255, 255);

//Only used for normalizing the borders
boolean[][] screenMark = new boolean[screenWidth][screenHeight];
//Reserved for zooming
int ratio = 100;

//Turn on full-screen mode
boolean sketchFullScreen() {
    return true;
}

void setup() {
    fill(255, 0, 0);
    size(screenWidth, screenHeight);
    initialize();
}

void draw() {
    background(seaColor);    
    map.draw();
}

void initialize()
{
    getMapData();
    getCountryInfo();
    getUsedData("Birth rate(births/1000 population)");
}
