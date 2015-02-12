class Line{
  String name;
  int[] xspot;
  int[] yspot;
  double[] value;
  int[] lent;
  int crinum;
  float angap;
  public Line(){
    
      
  }
  
  public Line(String str,int _crinum,float _ang){
    this.name=str;
    this.crinum=_crinum;
    xspot = new int[this.crinum];
    yspot = new int[this.crinum];
    value = new double[this.crinum];
    lent = new int[this.crinum];
    angap = _ang;
  }
  
  void setspot(){
    int i;
    for(i=0;i<this.crinum;i++){
      xspot[i]=xrtoxy(lent[i],i*angap);
      yspot[i]=yrtoxy(lent[i],i*angap);
    }
  }
  
  void setspotm(int xgap){
    int i;
    for(i=0;i<this.crinum;i++){
      xspot[i]=50+i*xgap;
      yspot[i]=400-lent[i];
    }
  }

  public int xrtoxy(int r, float ang){
    int x;
    x=int(xcentre+r*cos(ang));
    return x;
  }
  
  public int yrtoxy(int r, float ang){
    int y;
    y=int(ycentre-r*sin(ang));
    return y;
  }
  
  public boolean spotcontains(int x,int y, int num){
    int temp;
    boolean b=false;
    temp=(x-xspot[num])*(x-xspot[num])+(y-yspot[num])*(y-yspot[num]);
    if(temp<=25)b=true;
    return b;
  }
  
}
