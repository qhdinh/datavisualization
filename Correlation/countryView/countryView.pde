DataRead fulldata;
boolean isLogPlotX = false;
boolean isLogPlotY = false;

String selectedName = "";

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
checkBox cBoxX, cBoxY;
graphLabel continentLabel;
void setup() {
    size(840, 640);
    textSize(11);
    fulldata = new DataRead(sketchPath + "/factbook.csv");
    catSelector1 = new CategorySelector(fulldata, width -200, 20, "X axis");
    catSelector2 = new CategorySelector(fulldata, width -200, 55, "Y axis");
    smooth();
    cBoxX = new checkBox(width - 50, height - 50, false, "Log plot X:");
    cBoxY = new checkBox(width - 50, height - 30, false, "Log plot Y:");
    
    continentLabel = new graphLabel(width-100,height - 250);
}

void draw() {
  background(255);
  isLogPlotX = cBoxX.checked;
  isLogPlotY = cBoxY.checked;
  
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
      int c = continentLabel.getContinentCode(dp.continentName);
      if(!continentLabel.isPlotOn(c))
        continue;
    
      float x = (dp.x - minX)/(maxX-minX);
      float y = 1-(dp.y - minY)/(maxY-minY);
      if(isLogPlotX)
        x = log(dp.x - minX + 1)/log(maxX-minX +1);
      if(isLogPlotY)
        y = 1-log(dp.y - minY + 1)/log(maxY-minY + 1);
      if(dp.name.equals(selectedName)){
        textSize(12);
        fulldata.setContinentColor(dp.continentName);
        ellipse( x*(width-230) + 15, y*(height-35)+17, 13, 13 );
        fill(0);
        text(dp.name, x*(width-230) + 15, y*(height-35)-3);
        fill(220,130,150,150);
        textSize(11);
      }else{
        fulldata.setContinentColor(dp.continentName);
        ellipse( x*(width-230) + 15, y*(height-35)+17, 7, 7 );
      }
  }
  //trace 0 lines
  float x0 = (0 - minX)/(maxX-minX);
  float y0 = (0 - minY)/(maxY-minY);
  catSelector2.Draw();
  catSelector1.Draw();
    
  cBoxX.draw();
  cBoxY.draw();
  continentLabel.draw();
}

void mouseMoved(){
   if(dataplot == null) return;
   float max = 10;
   
   catSelector2.mouseOver(mouseX,mouseY);
   catSelector1.mouseOver(mouseX,mouseY);
   
   DataPoint selectedDP = null;
   for(DataPoint dp : dataplot){
      float x = (dp.x - minX)/(maxX-minX);
      float y = 1-(dp.y - minY)/(maxY-minY);
      if(isLogPlotX)
        x = log(dp.x - minX+1)/log(maxX-minX+1);
      if(isLogPlotY)
        y = 1-log(dp.y - minY+1)/log(maxY-minY+1);
     x = x*(width-230) + 15;
     y = y*(height-35)+17;
     float dist = (float)Math.sqrt((x-mouseX)*(x-mouseX) + (y-mouseY)*(y-mouseY));
     if(dist < max){
         max = dist;
         selectedDP = dp;
     }
  }
  if(max < 3){
    selectedName = selectedDP.name;
  }
}

void mousePressed()
{
  catSelector1.click(mouseX, mouseY);
  catSelector2.click(mouseX, mouseY);
  cBoxX.click(mouseX, mouseY);
  cBoxY.click(mouseX, mouseY);
  continentLabel.click(mouseX, mouseY);
}

