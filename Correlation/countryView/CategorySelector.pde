class CategorySelector{
  
  DataRead dRead;
  int selectedCode = 1;
  int posx, posy;
  boolean isopen = false;
  public CategorySelector(DataRead dread, int posX, int posY){
    dRead = dread;
    posx = posX;
    posy = posY;
    
  }
  
  public String getSelectedName(){
    return dRead.columns.get(selectedCode);
  }
 
  public int getCode(){
    return selectedCode;
  }
 
  public void Draw(){
    fill( 255 );
    rect(posx, posy, 180, 20);
    fill( 0 );
    textAlign(LEFT);
    fill( 125 );
    triangle(posx + 150, posy+5, posx + 170, posy+5, posx + 160, posy+15);
    fill( 0 );
    text( getSelectedName(), posx, posy + 15 );
    if(isopen){
      fill(255);
      rect(posx, posy+20, 180, 200);
      fill( 0 );
      for(int i = max(1,selectedCode-5); i < max(1,selectedCode-5) + 12; i++){
           text( dRead.getTitle(i), posx, posy + 35+16*(i-max(1,selectedCode-5)) );
      }  
    }
  }
  
  void click(int x, int y){
    //check if inside triangle
    if(x > posx + 150 && x < posx + 170 && y > posy+5 && y< posy+15){
       isopen = !isopen;   
    }
    if(isopen && x > posx && x < posx + 180 && y > posy+20 && y < posy + 220){
       int i = y - posy;
       i = i/16;
       System.out.println("new code = " + (i + (int)max(0,selectedCode-5)) + " i = " + i + " scode = " + selectedCode);
       selectedCode = i + max(0,selectedCode-5);
       System.out.println(getSelectedName());
       isopen = false;
    }    
  }
  
}
