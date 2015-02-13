class Star{
  //Criteria[] crisele;
  //Country[] combi.counsele;
  Line[] clines;
  int crinum;
  int counnum;
  float angap;
  color[] col;
  boolean pick = false;
  Spot pickspot = null;
  DataReadCombi datasets = null;
  int clc=0;
  int clct=0;
  //int combi.snum=0;
  int xgapMin=15;
  int ygapMax=300;
  
  
  public Star(){
    datasets = new DataReadCombi();
    findscale();
    setcolor();
  }
  
  void findscale(){
    int i=0;
    for(CountryCombi c: combi.counsele){
      if(c!=null)i++;
    }
    counnum=i;
    i=0;
    for(Criteria s:combi.crisele){
      if(s!=null)i++;
    }
    crinum=i;
    float x=0;
    x=TWO_PI/crinum;
    if(x>combi.angapMin)angap=x;
    else angap=combi.angapMin;
  }
  
  void draw(){
    background(255);
    drawaxis();
    drawline();
    drawmousemovespot();
    search();
    graphchange();
  }
  
  void drawaxis(){
    int i,x,y;
    fill(120);
    stroke(120);
    for(i=0;i<crinum;i++){
      x=xrtoxy(combi.rMax,i*angap);
      y=yrtoxy(combi.rMax,i*angap);
      line(combi.xcentre,combi.ycentre,x,y); 
      triangle(xrtoxy(combi.rMax+7,i*angap),yrtoxy(combi.rMax+7,i*angap),
               xrtoxy(combi.rMax,i*angap-PI/180),yrtoxy(combi.rMax,i*angap-PI/180),
               xrtoxy(combi.rMax,i*angap+PI/180),yrtoxy(combi.rMax,i*angap+PI/180));
      combi.labelFont1 = loadFont("Dotum-12.vlw");
      textFont(combi.labelFont1);
      //textFont(labelFont1,12); 
  
      if(i*angap>=HALF_PI && i*angap<PI){
        translate(xrtoxy(combi.rMax+10,i*angap),yrtoxy(combi.rMax+10,i*angap));
        //ellipse(0,0,2,2);
        translate(xrtoxy((int)textWidth(combi.crisele[i].name),PI-2*combi.angapMin)-combi.xcentre,yrtoxy((int)textWidth(combi.crisele[i].name),PI-2*combi.angapMin)-combi.ycentre);
        //println(xrtoxy((int)textWidth(combi.crisele[i].name),0)+","+yrtoxy((int)textWidth(combi.crisele[i].name),PI-2*angap));
        //ellipse(0,0,2,2);
        rotate(2*combi.angapMin);
        text(combi.crisele[i].name,0,0);
        rotate(-2*combi.angapMin);
        translate(-xrtoxy((int)textWidth(combi.crisele[i].name),PI-2*combi.angapMin)+combi.xcentre,-yrtoxy((int)textWidth(combi.crisele[i].name),PI-2*combi.angapMin)+combi.ycentre);      
        translate(-xrtoxy(combi.rMax+10,i*angap),-yrtoxy(combi.rMax+10,i*angap));
      }
      else if(i*angap>=0 && i*angap<HALF_PI){
        translate(xrtoxy(combi.rMax+10,i*angap),yrtoxy(combi.rMax+10,i*angap));
        rotate(-2*combi.angapMin);
        text(combi.crisele[i].name,0,0);
        rotate(2*combi.angapMin);
        translate(-xrtoxy(combi.rMax+10,i*angap),-yrtoxy(combi.rMax+10,i*angap));
      }
      else if(i*angap>=PI && i*angap<(PI+HALF_PI)){
        translate(xrtoxy(combi.rMax+10,i*angap),yrtoxy(combi.rMax+10,i*angap));
        translate(xrtoxy((int)textWidth(combi.crisele[i].name),PI+2*combi.angapMin)-combi.xcentre,yrtoxy((int)textWidth(combi.crisele[i].name),PI+2*combi.angapMin)-combi.ycentre);
        rotate(-2*combi.angapMin);
        text(combi.crisele[i].name,0,0);
        rotate(2*combi.angapMin);
        translate(-xrtoxy((int)textWidth(combi.crisele[i].name),PI+2*combi.angapMin)+combi.xcentre,-yrtoxy((int)textWidth(combi.crisele[i].name),PI+2*combi.angapMin)+combi.ycentre);      
        translate(-xrtoxy(combi.rMax+10,i*angap),-yrtoxy(combi.rMax+10,i*angap));
      }
      else if(i*angap>=(PI+HALF_PI) && i*angap<2*PI){
        translate(xrtoxy(combi.rMax+10,i*angap),yrtoxy(combi.rMax+10,i*angap));
        rotate(2*combi.angapMin);
        text(combi.crisele[i].name,0,0);
        rotate(-2*combi.angapMin);
        translate(-xrtoxy(combi.rMax+10,i*angap),-yrtoxy(combi.rMax+10,i*angap));
      }
  
    }
  
  }
  
  void setlines(){
    int i,j;
    double lmax=0;
    clines = new Line[counnum];
    for(i=0;i<counnum;i++){
      Line l=new Line(combi.counsele[i].name,crinum,angap);
      //println(combi.counsele[i].name);
      clines[i]=l;
      for(j=0;j<crinum;j++){
        lmax=findmax(combi.crisele[j].name);
        //println("lmax="+lmax);
        clines[i].value[j]=datasets.getData(datasets.getCricode(combi.crisele[j].name),datasets.getCouncode(combi.counsele[i].name));
        
        clines[i].lent[j]=(int)(clines[i].value[j]*0.8/lmax*combi.rMax);
        //println("value="+clines[i].value[j]);
        //println("lent="+clines[i].lent[j]);
        if(clines[i].lent[j]<=0)clines[i].lent[j]=-clines[i].lent[j];
          
      }
      clines[i].setspot();
    }
  }
  
  void setcolor(){
    col = new color[counnum];
    float r,g,b;
    int i;
    r=random(0,255);
    g=random(0,255);
    b=random(0,255);
    col[0]=color(r,g,b);
    for(i=1;i<counnum;i++){
      r=random(0,255);
      g=random(0,255);
      b=random(0,255);
      col[i]=color(r,g,b);
      if(col[i]==col[i-1])i--;
    }
  }
  
  void drawline(){
    setlines();
    int i,j;
    float s;
    String ss;
    for(i=0;i<counnum;i++){
      fill(col[i]);
      stroke(col[i]);
      for(j=0;j<crinum;j++){
        s=(float)clines[i].value[j];
        ss=str(s);
        if(ss.equals("NaN")){
          continue;
        }
        ellipse(clines[i].xspot[j],clines[i].yspot[j],4,4);
        
        if(j!=crinum-1){
          s=(float)clines[i].value[j+1];
          ss=str(s);
          if(ss.equals("NaN")){
          continue;
          }
          else line(clines[i].xspot[j],clines[i].yspot[j],clines[i].xspot[j+1],clines[i].yspot[j+1]);
          
        }
        else{
          s=(float)clines[i].value[0];
          ss=str(s);
          if(ss.equals("NaN")){
          continue;
          }
          else line(clines[i].xspot[j],clines[i].yspot[j],clines[i].xspot[0],clines[i].yspot[0]);
        
        }
      }
      line(10,50+i*15,25,50+i*15);
      text(combi.counsele[i].name,30,50+i*15+5);
    }
    stroke(0);
  }  
  
  void drawmousemovespot(){
    int j;
    float s;
    String ss;
    if(pick==true){
      stroke(0);
      
      for(j=0;j<crinum;j++){
        s=(float)clines[pickspot.councode].value[j];
        ss=str(s);
        if(ss.equals("NaN")){
          continue;
        }
        fill(0);
        ellipse(clines[pickspot.councode].xspot[j],clines[pickspot.councode].yspot[j],4,4);
        strokeWeight(3);
        if(j!=crinum-1){
          s=(float)clines[pickspot.councode].value[j+1];
          ss=str(s);
          if(ss.equals("NaN")){
          continue;
          }
          else line(clines[pickspot.councode].xspot[j],clines[pickspot.councode].yspot[j],clines[pickspot.councode].xspot[j+1],clines[pickspot.councode].yspot[j+1]);
          
        }
        else{
          s=(float)clines[pickspot.councode].value[0];
          ss=str(s);
          if(ss.equals("NaN")){
          continue;
          }
          else line(clines[pickspot.councode].xspot[j],clines[pickspot.councode].yspot[j],clines[pickspot.councode].xspot[0],clines[pickspot.councode].yspot[0]);
        
        }
        
      }
      strokeWeight(1);
      fill(col[pickspot.councode],190);
      noStroke();
      rect(mouseX+12,mouseY-12,120,20,0,0,3,3);
      fill(255);
      text((float)pickspot.value,mouseX+12,mouseY);
      fill(col[pickspot.councode],220);
      rect(mouseX+12,mouseY-32,120,20,0,0,0,0);
      fill(255);
      text(pickspot.cri,mouseX+12,mouseY-20);
      fill(col[pickspot.councode],240);
      rect(mouseX+12,mouseY-52,120,20,3,3,0,0);
      fill(255);
      text(pickspot.name,mouseX+12,mouseY-40);
      fill(200);
      ellipse(pickspot.x,pickspot.y,14,14);
      fill(130);
      ellipse(pickspot.x,pickspot.y,10,10);
      fill(50);
      ellipse(pickspot.x,pickspot.y,6,6);
      
    }
  }
  
  void drawsearchline(int _councode){
    int j;
    float s;
    String ss;
    
      
    for(j=0;j<crinum;j++){
      s=(float)clines[_councode].value[j];
      ss=str(s);
      if(ss.equals("NaN")){
        continue;
      }
      //fill(0);
      ellipse(clines[_councode].xspot[j],clines[_councode].yspot[j],4,4);
      strokeWeight(3);
      if(j!=crinum-1){
        s=(float)clines[_councode].value[j+1];
        ss=str(s);
        if(ss.equals("NaN")){
        continue;
        }
        else line(clines[_councode].xspot[j],clines[_councode].yspot[j],clines[_councode].xspot[j+1],clines[_councode].yspot[j+1]);
        
      }
      else{
        s=(float)clines[_councode].value[0];
        ss=str(s);
        if(ss.equals("NaN")){
        continue;
        }
        else line(clines[_councode].xspot[j],clines[_councode].yspot[j],clines[_councode].xspot[0],clines[_councode].yspot[0]);
      
      }
      
    }
    stroke(0);
    line(10,50+_councode*15,25,50+_councode*15);
    strokeWeight(1);
    text(combi.counsele[_councode].name,30,50+_councode*15+5);  
   
  }
  
  int xrtoxy(int r, float ang){
    int x;
    x=int(combi.xcentre+r*cos(ang));
    return x;
  }
  
  int yrtoxy(int r, float ang){
    int y;
    y=int(combi.ycentre-r*sin(ang));
    return y;
  }
  
  double findmax(String str){
     double max=0;
     double t;
     int i;
     //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!try to use the reflection of JAVA
     //Class cla = Class.forName("com.hhf.reflect.DataFunc");
     //Field[] field = cla.getDeclaredFields();
     for(i=0;i<counnum;i++){
       t=datasets.getData(datasets.getCricode(str),datasets.getCouncode(combi.counsele[i].name));
       if(t<0)t=-t;
       if(t>max){
         max=t;
       }
     }
     return max;
  }
  
  void mouseMoved(){
    int i,j;
    pick=false;
    pickspot=null;
    for(i=0;i<counnum;i++){
      for(j=0;j<crinum;j++){
        if(clines[i].spotcontains(mouseX,mouseY,j)==true){
          //println(mouseX,mouseY,clines[i].spotcontains(mouseX,mouseY,j));
          Spot spot=new Spot(clines[i].xspot[j],clines[i].yspot[j],i,combi.counsele[i].name,clines[i].value[j],combi.crisele[j].name);
          pickspot=spot;
          pick=true;
          //println(i);
        }
      }
    }
    if(((mouseX-940)*(mouseX-940)+(mouseY-520)*(mouseY-520))<3600)clc=1;
    else clc=0;
    if(((mouseX-940)*(mouseX-940)+(mouseY-420)*(mouseY-420))<3600)clct=1;
    else clct=0;
    //println(pick);
  }
  
  /*void keyPressed(){
    int i;
    if(combi.snum==0){
      for(i=0;i<combi.searchname.length;i++){
        combi.searchname[i]=0;
      }
    }
    if(keyCode==BACKSPACE && combi.snum>0)combi.snum--;
    if(keyCode!=BACKSPACE && keyCode!=SHIFT && keyCode!=ENTER){
      combi.searchname[combi.snum]=key;
      println("combi.snum="+combi.snum);
      combi.snum++;
    }
    if(keyCode==ENTER)combi.nametemp = new char[combi.snum];
  }*/
  
  void search(){
    //labelFont1 = loadFont("Dotum-12.vlw");
    int i=0;
    fill(120);
    text("SEARCH:",940,100);
    text("Country's name", 940,130);
    if(keyCode==ENTER){
      for(i=0;i<combi.searchname.length;i++){
        text(combi.searchname[i],940+i*7,160);
        if(i<combi.snum && (combi.snum!=0))combi.nametemp[i]=combi.searchname[i];
      }
      
      String ssname = new String(combi.nametemp);
      println("***"+ssname+"***");
      for(i=0;i<counnum;i++){
        if(ssname.equals(combi.counsele[i].name)){
          drawsearchline(i);
          fill(120);
          text("Find "+ssname+" :)", 940,190);
          break;
        }
      }
      if(i==counnum)text("Cannot find it :(",940,190);
      combi.snum=0;  
    }
    
  }
  
  public void search_name(String ssname)
  {
      int i;
      for(i=0;i<counnum;i++){
        if(ssname.equals(combi.counsele[i].name)){
          drawsearchline(i);
          fill(120);
          text("Find "+ssname+" :)", 940,190);
          break;
        }
      }
      if(i==counnum)text("Cannot find it :(",940,190);
      combi.snum=0;  
  }
  
  
  void graphchange(){
    noStroke();
    fill(126,192,238,100);
    ellipse(940,520,60,60);
    ellipse(940,420,60,60);
    if(clc==0)fill(126,192,238,180);
    else fill(120,180);
    ellipse(940,520,55,55);

    
    if(clct==0)fill(126,192,238,180);
    else fill(120,180);
    ellipse(940,420,55,55);
    stroke(255);
    strokeWeight(3);
    line(925,530,925,510);
    line(925,530,955,530);
    line(935,530,935,505);
    line(945,530,945,515);
    line(955,530,955,520);
    
    line(930,410,950,410);
    line(940,410,940,430);

    strokeWeight(1);
  }
  
  void mouseClicked(){
    if(((mouseX-940)*(mouseX-940)+(mouseY-520)*(mouseY-520))<3600)combi.graphnum=1;
    if(((mouseX-940)*(mouseX-940)+(mouseY-420)*(mouseY-420))<3600)combi.graphnum=0;
  }
  
}
