Criteria[] crisele;
Country[] counsele;
int crinum = 0;
int counnum = 0;
PFont labelFont1;
int xgap;
int xgapMin=15;
int ygapMax=300;
Line[] clines;
Line means;
color[] col;
boolean pick = false;
Spot pickspot = null;
char[] searchname;
int snum=0;
char[] nametemp;

DataRead datasets = null;

void setup(){
  size(880,570);
  labelFont1 = loadFont("Dotum-10.vlw");
  //textFont(labelFont1,10);
  datasets = new DataRead();
  counsele = new Country[263];
  
  int i,j;
  for(i=0;i<20;i++){
    Country c = new Country(datasets.counname[i].name,i);
    counsele[i]=c;
  }
  
  crisele = new Criteria[44];
  for(i=0;i<20;i++){
    Criteria cri = new Criteria(datasets.criteria[i].name,i);
    crisele[i]=cri;
  }
  
  searchname = new char[30];
  
  findscale();
  setcolor();
}

void draw(){
  background(255);
  drawaxis();
  drawline();
  drawmousemovespot();
  search();
}

void findscale(){
  int i=0;
  for(Country cc : counsele){
    if(cc!=null)i++;
  }
  counnum = i;
  //println("country="+counnum);
  i=0;
  for(Criteria s : crisele){
    if(s!=null)i++;
  }
  crinum = i;
  //println("criteria="+crinum);
  double x=0;
  x=660*1.0/crinum;
  if(x>xgapMin)xgap=(int)x;
  else xgap=xgapMin;
  //println("xgap="+xgap);
}

void setlines(){
  int i,j;
  double lmax=0;
  double lmin=0;
  double lmean=0;
  clines = new Line[counnum];
  means = new Line("means",crinum);
  for(i=0;i<counnum;i++){
    Line l=new Line(counsele[i].name,crinum);
    //println(counsele[i].name);
    clines[i]=l;
    for(j=0;j<crinum;j++){
      lmax=findmax(crisele[j].name);
      lmin=findmin(crisele[j].name);
      lmean=findmean(crisele[j].name);
      means.value[j]=lmean;
      means.lent[j]=(int)(0.4 *ygapMax);
            
      //println("lmax="+lmax);
      clines[i].value[j]=datasets.getData(datasets.getCricode(crisele[j].name),datasets.getCouncode(counsele[i].name));
      
      if(clines[i].value[j]<lmean)clines[i].lent[j]=(int)((clines[i].value[j]-lmin)*0.4/(lmean-lmin)*ygapMax);
      else clines[i].lent[j]=(int)((clines[i].value[j]-lmean)*0.4/(lmax-lmean)*ygapMax+0.4*ygapMax);
      //clines[i].lent[j]=(int)(clines[i].value[j]*0.8/lmax*ygapMax);
      //println("value="+clines[i].value[j]);
      //println("lent="+clines[i].lent[j]);
      //if(clines[i].lent[j]<=0)clines[i].lent[j]=-clines[i].lent[j];
      //println(crisele[j].name+" mean="+lmean+"min="+lmin+"lmax="+lmax);
      
    }
    clines[i].setspot();
    means.setspot();
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
  rect(50,400-0.2*ygapMax,660,0.2*ygapMax);
  fill(240,128,128,50);
  rect(50,400-0.4*ygapMax,660,0.2*ygapMax);
  fill(126,192,238,50);
  rect(50,400-0.6*ygapMax,660,0.2*ygapMax);
  fill(126,192,238,100);
  rect(50,400-0.8*ygapMax,660,0.2*ygapMax);
  for(i=0;i<crinum;i++){
    stroke(240);
    fill(120);
    if(i!=0)line(50+i*xgap,399,50+i*xgap,80);
    stroke(120);
    translate(51+i*xgap-5,410);
    rotate(QUARTER_PI);
    text(crisele[i].name,0,0);
    rotate(-QUARTER_PI);
    translate(-51-i*xgap+5,-410);
  }
  fill(120);
  text("MIN",15,405);
  text("MAX",15,405-0.8*ygapMax);
  text("Mean",10,405-0.4*ygapMax);
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
  }
  stroke(0);
  fill(120);
  for(j=0;j<crinum;j++){ 
    //if(j!=crinum-1)line(means.xspot[j],means.yspot[j],means.xspot[j+1],means.yspot[j+1]);
    translate(55+j*xgap,400-ygapMax);
    rotate(-QUARTER_PI);
    text(str((float)means.value[j]),0,0);
    rotate(QUARTER_PI);
    translate(-55-j*xgap,-400+ygapMax);
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
     t=datasets.getData(datasets.getCricode(str),datasets.getCouncode(counsele[i].name));
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
     t=datasets.getData(datasets.getCricode(str),datasets.getCouncode(counsele[i].name));
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
   
   for(i=0;i<counnum;i++){
     temp=datasets.getData(datasets.getCricode(str),datasets.getCouncode(counsele[i].name));
     s=(float)temp;
     ss=str(s);
     if(ss.equals("NaN")){
        continue;
        }
     mean=mean+temp;  
   }
   mean=mean/counnum;
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
        Spot spot=new Spot(clines[i].xspot[j],clines[i].yspot[j],datasets.getCouncode(clines[i].name),counsele[i].name,clines[i].value[j],crisele[j].name);
        pickspot=spot;
        pick=true;
        //println(i);
      }
    }
  }
  //println(pick);
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


void drawsearchline(String str){
  int j;
  float s;
  String ss;
  for(j=0;j<crinum;j++){
    s=(float)clines[datasets.getCouncode(str)].value[j];
    ss=str(s);
    if(ss.equals("NaN")){
      continue;
    }
    fill(0);
    ellipse(clines[datasets.getCouncode(str)].xspot[j],clines[datasets.getCouncode(str)].yspot[j],4,4);
    strokeWeight(3);
    if(j!=crinum-1){
      s=(float)clines[datasets.getCouncode(str)].value[j+1];
      ss=str(s);
      if(ss.equals("NaN")){
      continue;
      }
      else line(clines[datasets.getCouncode(str)].xspot[j],clines[datasets.getCouncode(str)].yspot[j],clines[datasets.getCouncode(str)].xspot[j+1],clines[datasets.getCouncode(str)].yspot[j+1]);
      
    }     
    
  }
  strokeWeight(1);
}

/*void keyPressed(){
  if(keyCode==BACKSPACE && snum>0)snum--;
  
}*/

void keyPressed(){
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
}

void search(){
  labelFont1 = loadFont("Dotum-10.vlw");
  int i=0;
  fill(120);
  text("SEARCH:",740,100);
  text("Country's name", 740,130);
  if(keyCode==ENTER){
    for(i=0;i<searchname.length;i++){
      text(searchname[i],740+i*7,160);
      if(i<snum && (snum!=0))nametemp[i]=searchname[i];
    }
    
    String ssname = new String(nametemp);
    println("***"+ssname+"***");
    for(i=0;i<counnum;i++){
      if(ssname.equals(counsele[i].name)){
        drawsearchline(ssname);
        fill(120);
        text("Find "+ssname+" :)", 740,190);
        break;
      }
    }
    if(i==counnum)text("Cannot find it :(",740,190);
    snum=0;  
  }
  
}
