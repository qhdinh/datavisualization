DataRead fulldata;
boolean isLogPlot = false;

float blendTimer = 0;  // smoothly blends between the data sets
float startTimer = 30; // how long the blend should last (in frames)
int mode = 0;          // which data set to display
int pmode = 0;         // previous mode
float maxX;
float minX;
float maxY;
float minY;
ArrayList<DataPoint> dataplot;

CategorySelector catSelector1, catSelector2;

void setup() {
    size(840, 640);
    fulldata = new DataRead("c:/factbook.csv");
    catSelector1 = new CategorySelector(fulldata, width -200, 20);
    catSelector2 = new CategorySelector(fulldata, width -200, 50);

    smooth();
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
  
  
  dataplot = fulldata.getData(catSelector1.getCode(), catSelector2.getCode());

  maxX = fulldata.getMaxX(dataplot);
  minX = fulldata.getMinX(dataplot);
  maxY = fulldata.getMaxY(dataplot);
  minY = fulldata.getMinY(dataplot);
  
  fill(220,130,150,150);
  for(DataPoint dp : dataplot){
      float x = (dp.x - minX)/(maxX-minX);
      float y = 1-(dp.y - minY)/(maxY-minY);
      if(isLogPlot){
        x = log(x);
        y = log(y);
      }
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

