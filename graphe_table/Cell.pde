class Cell{
  int numy;
  int numx;
  int xspot;
  int yspot;
  int cwidth;
  int cheight;
  int sele;
  String cri;
  double value;
  String name;
  
  public Cell(){
    this.sele=0;
  }
  public Cell(int _numy, int _numx){
    this.numy=_numy;
    this.numx=_numx;
    this.findpos();
    this.sele=0;
  }
  public void findpos(){
    this.xspot=71+numx*xgap;
    this.yspot=70+numy*ygap;
    this.cwidth=xgap;
    this.cheight=ygap;
  }
  public void setcont(String _cri, double _val, String _name){
    this.cri=_cri;
    this.value=_val;
    this.name=_name;
  }
  public boolean contains(int x, int y){
    if(x>=this.xspot && x<=(this.xspot+this.cwidth-1)){
      if(y>=this.yspot && y<=(this.yspot+this.cheight-1)){
        return true;
      }
    }
    return false;
  }
  public void setstate(int i){
    this.sele=i;
  }
  
  public void draw(){
    noStroke();
    fill(150,50);
    rect(this.xspot,this.yspot,this.cwidth-1,this.cheight);
  }
  
  public void showvalue(){
    float s;
    s=(float)(this.value);
    String ss=str(s);
    if(ss.equals("NaN")){
      ss="no Value";
    }
    noStroke();
    fill(255);
    rect(this.xspot,this.yspot,this.cwidth-1,this.cheight);
    if(this.value>=0)fill(80);
    else fill(240,128,128);
    labelFont1 = loadFont("Dotum-12.vlw");
    textFont(labelFont1,12);
    text(ss,this.xspot,this.yspot+15);
  }
}
