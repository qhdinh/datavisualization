class CorrelationGraph{
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

  public int X , Y, vwidth, vheight;
  
  public CorrelationGraph(int X, int Y, int vwidth, int vheight){
    this.X = X;
    this.Y = Y;
    this.vwidth = vwidth;
    this.vheight = vheight;
    textSize(11);
    fulldata = new DataRead(sketchPath + "/factbook.csv");
    catSelector1 = new CategorySelector(fulldata, X + vwidth -200, Y + 20, "X axis");
    catSelector2 = new CategorySelector(fulldata, X + vwidth -200, Y + 55, "Y axis");
    smooth();
    cBoxX = new checkBox(X + vwidth - 50, Y + vheight - 50, false, "Log plot X:");
    cBoxY = new checkBox(X + vwidth - 50, Y + vheight - 30, false, "Log plot Y:");
    
    continentLabel = new graphLabel(X + vwidth-100,Y + vheight - 250);
  
  }
  
  public void draw(){
    //background(255);
    isLogPlotX = cBoxX.checked;
    isLogPlotY = cBoxY.checked;
  
    // draw the axes
    int bd = 15;   // border space
    stroke(0);
    fill(0);
    line( X + bd, Y + vheight-bd, X + vwidth-bd - 200, Y + vheight-bd );  // x-axis
    textAlign(CENTER,TOP);
    text( catSelector1.getSelectedName(), X + (X+vwidth)/2- 200, Y + vheight-bd );          
    line( X + bd, Y + bd, X + bd, Y + vheight-bd );  // y-axis
    pushMatrix();
      rotate( radians(-90) );
      text( catSelector2.getSelectedName(), -Y-(vheight/2), X );
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
          ellipse(X + x*(vwidth-230) + 15, Y+ y*(vheight-35)+17, 13, 13 );
          fill(0);
          text(dp.name, X+ x*(vwidth-230) + 15, Y+y*(vheight-35)-3);
          fill(220,130,150,150);
          textSize(11);
        }else{
          fulldata.setContinentColor(dp.continentName);
          ellipse( X + x*(vwidth-230) + 15, Y + y*(vheight-35)+17, 7, 7 );
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
  
  
  public void mouseMoved(int xmouse, int ymouse){
     xmouse = xmouse - X;
     ymouse = ymouse - Y;
     if(dataplot == null) return;
       float max = 10;
       
       catSelector2.mouseOver(xmouse,ymouse);
       catSelector1.mouseOver(xmouse,ymouse);
       
       DataPoint selectedDP = null;
       for(DataPoint dp : dataplot){
          float px = (dp.x - minX)/(maxX-minX);
          float py = 1-(dp.y - minY)/(maxY-minY);
          if(isLogPlotX)
            px = log(dp.x - minX+1)/log(maxX-minX+1);
          if(isLogPlotY)
            py = 1-log(dp.y - minY+1)/log(maxY-minY+1);
         px = px*(vwidth-230) + 15;
         py = py*(vheight-35)+17;
         float dist = (float)Math.sqrt((px-xmouse)*(px-xmouse) + (py-ymouse)*(py-ymouse));
         if(dist < max){
             max = dist;
             selectedDP = dp;
         }
      }
      if(max < 3){
        selectedName = selectedDP.name;
      }
  }
  
  
  public void mousePressed(int x, int y)
  {
    catSelector1.click(x, y);
    catSelector2.click(x, y);
    cBoxX.click(x, y);
    cBoxY.click(x, y);
    continentLabel.click(x, y);
  }

  

}
