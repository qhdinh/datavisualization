class Mean{
  int crinum = 0;
  int counnum = 0;
  int xgap;
  Line[] clines;
  Line means;
  color[] col;
  boolean pick = false;
  Spot pickspot = null;
  //int snum=0;
  int clc=0;
  int clct=0;
  
  DataReadCombi datasets = null;
  
  public Mean(){
    //size(880,570);
    combi.labelFont1 = loadFont("Dotum-10.vlw");
    textFont(combi.labelFont1);
    //textFont(labelFont1,10);
    datasets = new DataReadCombi();
    
    int i,j;
    
    findscale();
    setcolor();
  }
  
  void draw(){
    background(255);
    drawaxis();
    drawline();
    drawmousemovespot();
    search();
    graphchange();
  }
  
  void findscale(){
    int i=0;
    for(CountryCombi cc : combi.counsele){
      if(cc!=null)i++;
    }
    counnum = i;
    //println("country="+counnum);
    i=0;
    for(Criteria s : combi.crisele){
      if(s!=null)i++;
    }
    crinum = i;
    //println("criteria="+crinum);
    double x=0;
    x=660*1.0/crinum;
    if(x>combi.xgapMinp)xgap=(int)x;
    else xgap=combi.xgapMinp;
    //println("xgap="+xgap);
  }
  
  void setlines(){
    int i,j;
    double lmax=0;
    double lmin=0;
    double lmean=0;
    clines = new Line[counnum];
    means = new Line("means",crinum,0);
    for(i=0;i<counnum;i++){
      Line l=new Line(combi.counsele[i].name,crinum,0);
      //println(counsele[i].name);
      clines[i]=l;
      for(j=0;j<crinum;j++){
        lmax=findmax(combi.crisele[j].name);
        lmin=findmin(combi.crisele[j].name);
        lmean=findmean(combi.crisele[j].name);
        means.value[j]=lmean;
        means.lent[j]=(int)(0.4 *combi.ygapMaxp);
              
        //println("lmax="+lmax);
        clines[i].value[j]=datasets.getData(datasets.getCricode(combi.crisele[j].name),datasets.getCouncode(combi.counsele[i].name));
        
        if(clines[i].value[j]<lmean)clines[i].lent[j]=(int)((clines[i].value[j]-lmin)*0.4/(lmean-lmin)*combi.ygapMaxp);
        else clines[i].lent[j]=(int)((clines[i].value[j]-lmean)*0.4/(lmax-lmean)*combi.ygapMaxp+0.4*combi.ygapMaxp);
        //clines[i].lent[j]=(int)(clines[i].value[j]*0.8/lmax*ygapMax);
        //println("value="+clines[i].value[j]);
        //println("lent="+clines[i].lent[j]);
        //if(clines[i].lent[j]<=0)clines[i].lent[j]=-clines[i].lent[j];
        //println(crisele[j].name+" mean="+lmean+"min="+lmin+"lmax="+lmax);
        
      }
      clines[i].setspotm(xgap);
      means.setspotm(xgap);
    }
  }
  
  
  void drawaxis(){
    fill(120);
    stroke(120);
    line(50,400,710,400);
    line(50,400,50,80);
    triangle(710,397,710,403,715,400);
    triangle(47,80,53,80,50,75);
    int i;
    noStroke();
    fill(240,128,128,100);
    rect(50,400-0.2*combi.ygapMaxp,660,0.2*combi.ygapMaxp);
    fill(240,128,128,50);
    rect(50,400-0.4*combi.ygapMaxp,660,0.2*combi.ygapMaxp);
    fill(126,192,238,50);
    rect(50,400-0.6*combi.ygapMaxp,660,0.2*combi.ygapMaxp);
    fill(126,192,238,100);
    rect(50,400-0.8*combi.ygapMaxp,660,0.2*combi.ygapMaxp);
    for(i=0;i<crinum;i++){
      stroke(240);
      fill(120);
      if(i!=0)line(50+i*xgap,399,50+i*xgap,80);
      stroke(120);
      translate(51+i*xgap-5,410);
      rotate(QUARTER_PI);
      text(combi.crisele[i].name,0,0);
      rotate(-QUARTER_PI);
      translate(-51-i*xgap+5,-410);
    }
    fill(120);
    text("MIN",15,405);
    text("MAX",15,405-0.8*combi.ygapMaxp);
    text("Mean",10,405-0.4*combi.ygapMaxp);
  }
  
  void drawline(){
    int i,j;
    setlines();
    float s;
    String ss;
    for(i=0;i<counnum;i++){
      fill(col[i],150);
      noStroke();
      for(j=0;j<crinum;j++){
        s=(float)clines[i].value[j];
        ss=str(s);
        if(ss.equals("NaN")){
          continue;
        }
        ellipse(clines[i].xspot[j],clines[i].yspot[j],4,4);
        stroke(col[i],150);
        if(j!=crinum-1){
          s=(float)clines[i].value[j+1];
          ss=str(s);
          if(ss.equals("NaN")){
          continue;
          }
          else{
           line(clines[i].xspot[j],clines[i].yspot[j],clines[i].xspot[j+1],clines[i].yspot[j+1]);
          }
        }
        
        
        
      }
      line(740,210+i*15,755,210+i*15);
      text(combi.counsele[i].name,760,210+i*15+5);
    }
    
    stroke(0);
    fill(120);
    for(j=0;j<crinum;j++){ 
      //if(j!=crinum-1)line(means.xspot[j],means.yspot[j],means.xspot[j+1],means.yspot[j+1]);
      translate(55+j*xgap,400-combi.ygapMaxp);
      rotate(-QUARTER_PI);
      text(str((float)means.value[j]),0,0);
      rotate(QUARTER_PI);
      translate(-55-j*xgap,-400+combi.ygapMaxp);
    }
    /*translate(55-xgap,400-ygapMax);
    rotate(-QUARTER_PI);
    text("Mean value",0,0);
    rotate(QUARTER_PI);
    translate(55+xgap,-400+ygapMax);*/
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
  
  double findmin(String str){
     double min=0;
     double t;
     int i;
     //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!try to use the reflection of JAVA
     //Class cla = Class.forName("com.hhf.reflect.DataFunc");
     //Field[] field = cla.getDeclaredFields();
     for(i=0;i<counnum;i++){
       t=datasets.getData(datasets.getCricode(str),datasets.getCouncode(combi.counsele[i].name));
       //if(t<0)t=-t;
       if(t<min){
         min=t;
       }
     }
     return min;
  }
  
  double findmean(String str){
     double mean=0;
     double temp;
     int i;
     //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!try to use the reflection of JAVA
     //Class cla = Class.forName("com.hhf.reflect.DataFunc");
     //Field[] field = cla.getDeclaredFields();
     float s;
     String ss;
     int _counnum= counnum;
     for(i=0;i<counnum;i++){
       temp=datasets.getData(datasets.getCricode(str),datasets.getCouncode(combi.counsele[i].name));
       s=(float)temp;
       ss=str(s);
       if(ss.equals("NaN")){
           _counnum--;
          continue;
          }
          //println(_counnum);
       mean=mean+temp;  
     }
     mean=mean/_counnum;
     return mean;
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
    //println(pick);
    if(((mouseX-950)*(mouseX-950)+(mouseY-520)*(mouseY-520))<3600)clc=1;
    else clc=0;
    if(((mouseX-950)*(mouseX-950)+(mouseY-420)*(mouseY-420))<3600)clct=1;
    else clct=0;
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
      //println(datasets.getCouncode(str));
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
      
    }
    stroke(0);
    line(740,210+_councode*15,755,210+_councode*15);
    strokeWeight(1);
    text(combi.counsele[_councode].name,760,210+_councode*15+5);
  }
  
  /*void keyPressed(){
    if(keyCode==BACKSPACE && snum>0)snum--;
    
  }*/
  
  /*void keyPressed(){
    int i;
    if(snum==0){
      for(i=0;i<searchname.length;i++){
        searchname[i]=0;
      }
    }
    if(keyCode==BACKSPACE && snum>0)snum--;
    if(keyCode!=BACKSPACE && keyCode!=SHIFT && keyCode!=ENTER){
      searchname[snum]=key;
      println("snum="+snum);
      snum++;
    }
    if(keyCode==ENTER)nametemp = new char[snum];
  }*/
  
  void search(){
    combi.labelFont1 = loadFont("Dotum-10.vlw");
    int i=0;
    fill(120);
    text("SEARCH:",740,100);
    text("Country's name", 740,130);
    if(keyCode==ENTER){
      for(i=0;i<combi.searchname.length;i++){
        text(combi.searchname[i],740+i*7,160);
        if(i<combi.snum && (combi.snum!=0))combi.nametemp[i]=combi.searchname[i];
      }
      
      String ssname = new String(combi.nametemp);
      println("***"+ssname+"***");
      for(i=0;i<counnum;i++){
        if(ssname.equals(combi.counsele[i].name)){
          drawsearchline(i);
          fill(120);
          text("Find "+ssname+" :)", 740,190);
          break;
        }
      }
      if(i==counnum)text("Cannot find it :(",740,190);
      combi.snum=0;  
    }
    
  }
  
  void graphchange(){
    noStroke();
    fill(126,192,238,100);
    ellipse(940,520,60,60);
    ellipse(940,420,60,60);
    if(clc==0)fill(126,192,238,180);
    else fill(160);
    ellipse(940,520,55,55);
    
    if(clct==0)fill(126,192,238,180);
    else fill(160);
    ellipse(940,420,55,55);
    stroke(255);
    strokeWeight(3);
    fill(255);
    line(930,410,950,410);
    line(940,410,940,430);
    fill(255,0);
    triangle(930,530,950,530,940,510);
    strokeWeight(1);

  }
  
  void mouseClicked(){
    if(((mouseX-940)*(mouseX-940)+(mouseY-520)*(mouseY-520))<3600)combi.graphnum=2;
    if(((mouseX-940)*(mouseX-940)+(mouseY-420)*(mouseY-420))<3600)combi.graphnum=0;
  }
  
}
