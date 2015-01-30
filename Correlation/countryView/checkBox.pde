class checkBox{
  
  private int x ,y;
  boolean checked;
  String title;
  
  public checkBox(int x, int y, boolean defaultValue, String title){
      this.title = title;
      this.checked = defaultValue;
      this.x = x;
      this.y = y;
  }

  public void draw(){
      if(checked){
          fill(0);
          rect(x,y,15,15);
      }else{
          fill(255);
          rect(x,y,15,15);
          fill(0);
      }
      text(title, x -48 ,y + 12);
  }
  
  public void click(int x, int y){
    if(x>this.x && x<this.x+15 && y>this.y && y<this.y+15)
      checked = !checked;
  }
}
