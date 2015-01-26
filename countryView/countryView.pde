DataRead fulldata;

PVector[] data1 = {
  new PVector(0.1825,0.6675),
  new PVector(0.1825,0.6675),
  new PVector(0.4075,0.7575),
  new PVector(0.3,0.62),
  new PVector(0.445,0.4825),
  new PVector(0.8225,0.1825)
};

PVector[] data2 = {
new PVector(0.2225,0.1825),
new PVector(0.2225,0.1825),
new PVector(0.17,0.34),
new PVector(0.375,0.2175),
new PVector(0.3125,0.6075),
new PVector(0.535,0.415),
new PVector(0.655,0.3775),
new PVector(0.4325,0.31),
new PVector(0.665,0.23),
new PVector(0.7325,0.395),
new PVector(0.6175,0.5975),
new PVector(0.625,0.6025),
new PVector(0.8825,0.7325),
new PVector(0.725,0.7775),
new PVector(0.7975,0.8825),
new PVector(0.885,0.8675)
};

PVector[][] data = new PVector[2][];
color[] dataColors = new color[2];
String[] dataLabels = new String[2];

float blendTimer = 0;  // smoothly blends between the data sets
float startTimer = 30; // how long the blend should last (in frames)
int mode = 0;          // which data set to display
int pmode = 0;         // previous mode

CategorySelector catSelector1, catSelector2;

void setup() {
    size(840, 640);
    fulldata = new DataRead("c:/factbook.csv");
    catSelector1 = new CategorySelector(fulldata, width -200, 20);
    catSelector2 = new CategorySelector(fulldata, width -200, 50);

    smooth();
    data[0] = data1;
    dataColors[0] = color(255,150,5);
    dataLabels[0] = "USA";
    data[1] = data2;
    dataColors[1] = color(5,150,150);
    dataLabels[1] = "UK";
}

void draw() {
  background(255);
  // draw the axes
  int bd = 15;   // border space
  stroke(0);
  fill(0);
  line( bd, height-bd, width-bd - 200, height-bd );  // x-axis
  textAlign(CENTER,TOP);
  text( catSelector1.getSelectedName(), width/2- 200, height-bd );          // ALWAYS label your axes!
  line( bd, bd, bd, height-bd );  // y-axis
  pushMatrix();
    rotate( radians(-90) );
    text( catSelector2.getSelectedName(), -width/2, 0 );
  popMatrix();
  
  // draw the data points
  stroke( 0, map(blendTimer, 0, startTimer, 255, 0) );
  fill( dataColors[ mode ], map(blendTimer, 0, startTimer, 255, 0) );
  
  
  ArrayList<DataPoint> dataplot = fulldata.getData(catSelector1.getCode(), catSelector2.getCode());

  float maxX = fulldata.getMaxX(dataplot);
  float minX = fulldata.getMinX(dataplot);
  float maxY = fulldata.getMaxY(dataplot);
  float minY = fulldata.getMinY(dataplot);
  
  for(DataPoint dp : dataplot){
      float x = (dp.x - minX)/(maxX-minX);
      float y = 1-(dp.y - minY)/(maxY-minY);
      ellipse( x*(width-230) + 15, y*(height-35)+17, 5, 5 );
        
  }
  catSelector2.Draw();
  catSelector1.Draw();
    

}

void mousePressed()
{
  catSelector1.click(mouseX, mouseY);
  catSelector2.click(mouseX, mouseY);
}

