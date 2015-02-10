class graphLabel{
  
  int x,y;
  String[] continents = {"Asia","Africa","Europe","South America","North America","Oceania","Middle East"};
  boolean[] isOn = {true,true,true,true,true,true,true};
  
  public graphLabel(int x, int y){
    this.x = x;
    this.y = y;
  }

  void draw(){
    fill(0);
    text("Continents", x-15, y-2);
    int i = 1;
    for(String cName : continents){
      fill(0);
      text(cName,x,y+12*i);
      
      if(isOn[i-1]){
        setContinentColor(cName);
      }else{
        fill(255);
      }
      ellipse( x-10, y + 12*i-6, 9, 9 );
      i++;
    }  
  }
  
  public boolean isPlotOn(int cCode){
      return isOn[cCode];
  }
  
  public int getContinentCode(String codeName){
    int i = 0;
    for(String s:continents){
      if(s.equals(codeName))
        return i;
      i++;
    }
    return -1;
  }
  
  
  
  public void setContinentColor(String name){
      if(name.equals("Asia")){
          fill(255,0,0,200);
      }else if(name.equals("Africa")){
          fill(255,255,0,200);
      }else if(name.equals("Europe")){
          fill(0,0,255,200);
      }else if(name.equals("South America")){
          fill(0,255,0,200);
      }else if(name.equals("North America")){
          fill(255,0,255,200);
      }else if(name.equals("Oceania")){
          fill(100,100,100,200);
      }else if(name.equals("Middle East")){
          fill(0,255,255,200);
      }
  }  
  
  
  public void click(int x, int y){
    int i = 1;
    for(String cName : continents){
      float dx = x - (this.x-10);
      float dy = y - (this.y + 12*i-6);
      float d = sqrt(dx*dx + dy+dy);
      if(d < 5){
          isOn[i-1] = !isOn[i-1]; 
      }
      i++;
    }  
  }
  
}
