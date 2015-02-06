class graphLabel{
  
  int x,y;
  String[] continents = {"Asia","Africa","Europe","South America","North America","Oceania","Middle East"};
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
      setContinentColor(cName);
      ellipse( x-10, y + 12*i-6, 9, 9 );
      i++;
    }  
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
  
  
}
