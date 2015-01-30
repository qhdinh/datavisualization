class CategorySelector{
  
  DataRead dRead;
  int selectedCode = 1;
  int posx, posy;
  int mouseOverPos = -1;
  boolean isopen = false;
  String title;
  
  public CategorySelector(DataRead dread, int posX, int posY, String Title){
    dRead = dread;
    posx = posX;
    posy = posY;
    title = Title;
  }
  
  public String getSelectedName(){
    return dRead.columns.get(selectedCode);
  }
 
  public int getCode(){
    return selectedCode;
  }
  
  public void mouseOver(int x, int y){
      if(isopen && x > posx && x < posx + 180 && y > posy+20 && y < posy + 220 ){
          mouseOverPos = (y - (posy+20))/16;
          if(mouseOverPos>11) mouseOverPos = 11; 
      }else{
          mouseOverPos = -1;
      }
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
    text( title, posx, posy -1 );
    
    if(isopen){
      fill(255);
      rect(posx, posy+20, 180, 200);
      fill( 0 );
      if(mouseOverPos >= 0){
          fill(255,0,0,100);
          rect(posx, posy+20 + mouseOverPos*16 , 180, 20);
          fill(0);    
      }
      for(int i = max(1,selectedCode-5); i < min(max(1,selectedCode-5) + 12,dRead.getNCategories()); i++){
           text( dRead.getTitle(i), posx, posy + 35+16*(i-max(1,selectedCode-5)) );
      }  
    }
  }
  
  void click(int x, int y){
    //check if inside triangle
    if(x > posx + 150 && x < posx + 170 && y > posy+5 && y< posy+15){
       isopen = !isopen;
    //if the click is inside the selection box   
    }else if(isopen && x > posx && x < posx + 180 && y > posy+20 && y < posy + 220){
       int i = y - (posy+20);
       i = i/16;
       if(i>11) i = 11;
       
       
       //System.out.println("new code = " + (i + (int)max(0,selectedCode-5)) + " i = " + i + " scode = " + selectedCode);
       selectedCode = min(i + max(1,selectedCode-5),dRead.getNCategories());
       System.out.println(getSelectedName());
       isopen = false;
    }else if(isopen){
       isopen = false;
    }
  }
  
}
