class Label{
  int axis;//axis=0:yaxis-country    axis=1:xaxis-criteria
  int xspot;
  int yspot;
  int lwidth;
  int lheight;
  int sele;
  String name;
  int num;
  
  public Label(){
    this.sele = 0;
  }
  public Label(int _axis){
    this.axis=_axis;
    this.sele = 0;
  }
  public void setaxis(int _axis){
    this.axis=_axis;
  }
  public void draw(String str, int _num,int xgap){
    this.name=str;
    this.num=_num;
    if(axis==0){//y-axis
      fill(126,192,238);
      noStroke();
      smooth();
      this.xspot=10;
      this.yspot=50+num*20;
      this.lwidth=60;
      this.lheight=19;
      rect(10,50+num*20,60,19,7,0,0,7);
      stroke(255);
      line(69,50+num*20+19,17,50+num*20+19);
      fill(255);
      labelFont1 = loadFont("Dotum-14.vlw");
      //textFont(labelFont1,14);
      text(str,16,50+num*20+14);
    }
    if(axis==1){
      fill(126,192,238);
      noStroke();
      smooth();
      this.xspot=70+num*xgap;
      this.yspot=30;
      this.lwidth=xgap-5;
      this.lheight=20;
      rect(70+num*xgap,30,xgap-5,20,7,7,0,0);
      stroke(255);
      fill(255);
      labelFont1 = loadFont("Dotum-14.vlw");
      //textFont(labelFont1,14);
      text(str,70+num*xgap+5,44);
    }
  }
  
  public void draw(int xgap){
    if(axis==0){//y-axis
      if(this.sele==0){
        fill(126,192,238);
      }
      else if(this.sele==1||this.sele==2){
        fill(180);
      }
      noStroke();
      smooth();
      rect(10,50+num*20,60,19,7,0,0,7);
      this.xspot=10;
      this.yspot=50+num*20;
      this.lwidth=60;
      this.lheight=19;
      stroke(255);
      line(69,50+num*20+19,17,50+num*20+19);
      fill(255);
      labelFont1 = loadFont("Dotum-14.vlw");
      //textFont(labelFont1,14);
      text(name,16,50+num*20+14);
    }
    if(axis==1){
      if(this.sele==0){
        fill(126,192,238);
      }
      else if(this.sele==1||this.sele==2){
        fill(180);
      }
      noStroke();
      smooth();
      rect(70+num*xgap,30,xgap-5,20,7,7,0,0);
      this.xspot=70+num*xgap;
      this.yspot=30;
      this.lwidth=xgap-5;
      this.lheight=20;
      stroke(255);
      fill(255);
      labelFont1 = loadFont("Dotum-14.vlw");
      //textFont(labelFont1,14);
      text(name,70+num*xgap+5,44);
    }
  }
  
  public int getxspot(){
    return this.xspot;
  }
  public int getyspot(){
    return this.yspot;
  }
  public int getlwidth(){
    return this.lwidth;
  }
  public int getlheight(){
    return this.lheight;
  }
  public boolean contains(int x, int y){
    if(x>=this.xspot && x<=(this.xspot+this.lwidth-1)){
      if(y>=this.yspot && y<=(this.yspot+this.lheight-1)){
        return true;
      }
    }
    return false;
  }
  public void setstate(int i){
    this.sele=i;
  }
}
