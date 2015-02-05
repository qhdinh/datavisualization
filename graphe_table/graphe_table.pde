
Criteria[] crisele;
Country[] counsele;
int crinum = 0;
int counnum = 0;
PFont labelFont1;
int xlent = 380;
int ylent = 400;
int xgapMin = 75;
int xgap ;
int ygap = 20;
Label[] ylabel; 
Label[] xlabel;
Cell[] cells;
Label mousemovelabel=null;
Label lastlabel=null;
Label clikclabel=null;
Cell mousemovecell=null;
Cell lastcell = null;
int oney;
int onex;
Label mouseclicklabel=null;
Label mouseclickcell=null;
int uselog = 0;
int nupdown = 0;
int nleftright = 0;
DataRead datasets = null;


void setup(){
  size(500,500);
  //background(255);
  datasets = new DataRead();
  counsele = new Country[263];
  ///////////////////////////////////initialisation manually
  /*Country c1 = new Country("Albania", 0);
  Country c2 = new Country("Argentina", 1);
  Country c3 = new Country("Belgium", 2);
  Country c4 = new Country("Brazil",3);
  Country c5 = new Country("China",4);
  Country c6 = new Country("France",5);
  Country c7 = new Country("Vietnam",6);*/
  int i,j;
  for(i=0;i<263;i++){
    Country c = new Country(datasets.counname[i].name,i);
    counsele[i]=c;
  }
   
  /*counsele[0]= c1;
  counsele[1]= c2;
  counsele[2]= c3;
  counsele[3]= c4;
  counsele[4]= c5;
  counsele[5]= c6;
  counsele[6]= c7;*/
  
  
  
  //println(counsele[0].name);
  if(counsele[1]==null)println("1=null");
  crisele = new Criteria[44];
  ////////////////////////////////////initialisation manually
  Criteria cr1 = new Criteria("Population",0);
  Criteria cr2 = new Criteria("Area(sq km)",0);
  Criteria cr3 = new Criteria("Birth rate(births/1000 population)",1);
  Criteria cr4 = new Criteria("Death rate(deaths/1000 population)",3);
  Criteria cr5 = new Criteria("Current account balance",36);
  
  for(i=0;i<44;i++){
    Criteria cri = new Criteria(datasets.criteria[i].name,i);
    crisele[i]=cri;
  }
  
  /*crisele[0]=cr1;
  crisele[1]=cr2;
  crisele[2]=cr3;
  crisele[3]=cr4;
  crisele[4]=cr5;*/
  
}

void draw(){
  background(255);
  //xkeyscroller();
  //ykeyscroller();
  drawxlabel();
  drawylabel();
  drawcell();
  drawlines();
  //translate(-xgap*nleftright,-ygap*nupdown);
  //mymask();
  //if(keyCode==UP || keyCode==DOWN)updownmask();
  //if(keyCode==LEFT || keyCode==RIGHT)lrmask();
  //mymask();
  drawmousemovelabel();
  mymask();
  drawaxis();
  drawmousemovecell();
  //println(datasets.getData(0,2)+","+datasets.getCricode("Area(sq km)")+","+datasets.getCouncode("Albania")+"Aou...");
  //println(datasets.getData(datasets.getCricode("Area(sq km)"),datasets.getCouncode("Albania")));
  //println("crinum="+crinum);
  //println("nupdown="+nupdown);
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
  x=xlent*1.0/crinum;
  if(x>xgapMin)xgap=(int)x;
  else xgap=xgapMin;
  //println("xgap="+xgap);
}

void drawaxis(){
  //translate(-20*nleftright,-ygap*nupdown);
  labelFont1 = loadFont("Dotum-20.vlw");
  textFont(labelFont1,18);
  fill(30,144,255);
  text("General View", 180,20);
  findscale();
  fill(120);
  stroke(120);
  line(70,50,450,50);
  triangle(450,47,450,53,457,50);
  line(70,50,70,450);// no consider the scroller first
  triangle(67,450,73,450,70,457);
  int i;
  for(i=0;i<crinum;i++){
    stroke(120);
    line(70+i*xgap,50,70+i*xgap,450);
  }
}

void drawylabel(){
  int i,j,ylabelnum;
  if(counnum>-nupdown+19)ylabelnum=-nupdown+19;
  else ylabelnum=counnum;
  ylabel = new Label[ylabelnum+1];
  Label ylabelcoun = new Label(0);
  ylabel[0]=ylabelcoun;
  ylabel[0].draw("country",0);
  for(i=-nupdown;i<ylabelnum;i++){
    Label ylabeltemp = new Label(0);
    ylabel[i+1]=ylabeltemp;
    ylabel[i+1].draw(counsele[i].name,i+1+nupdown);
  }
    
}

void drawxlabel(){
  int i,j,xlabelnum;
  if(crinum>-nleftright+5)xlabelnum=-nleftright+5;
  else xlabelnum=crinum;
  xlabel = new Label[xlabelnum];
  for(i=-nleftright;i<xlabelnum;i++){
    Label xlabeltemp = new Label(1);
    xlabel[i]=xlabeltemp;
    xlabel[i].draw(crisele[i].name,i+nleftright);
    //stroke(120);
    //line(70+i*xgap,50,70+i*xgap,450);
  }
    


}

void drawmousemovelabel(){
  int i,j,ylabelnum,xlabelnum;
  if(mousemovelabel!=null){
    mousemovelabel.draw();
    if(mousemovelabel.axis==1){
      if(counnum>-nupdown+19)ylabelnum=-nupdown+19;
      else ylabelnum=counnum;
      if(crinum>-nleftright+5)xlabelnum=-nleftright+5;
      else xlabelnum=crinum;
      for(i=-nleftright;i<xlabelnum;i++){
        if(xlabel[i].name==mousemovelabel.name){
          for(j=-nupdown;j<ylabelnum;j++){
            cells[(i+nleftright)*(ylabelnum+nupdown)+(j+nupdown)].draw();
          }
        } 
      }
    }
  }
  if(mousemovelabel!=null){
    mousemovelabel.draw();
    if(mousemovelabel.axis==0){
      if(counnum+1>1-nupdown+19)ylabelnum=1-nupdown+19;
      else ylabelnum=counnum+1;
      if(crinum>-nleftright+5)xlabelnum=-nleftright+5;
      else xlabelnum=crinum;
      for(j=1-nupdown;j<ylabelnum;j++){
        if(ylabel[j].name==mousemovelabel.name){
          for(i=-nleftright;i<xlabelnum;i++){
            cells[(i+nleftright)*(ylabelnum+nupdown-1)+(j-1+nupdown)].draw();
          }
        } 
      }
    }
  }
  
}

void drawmousemovecell(){
  int i,j;
  if(mousemovecell!=null && mousemovecell.contains(mouseX,mouseY)==true){
    float s;
    s=(float)(mousemovecell.value);
    mousemovecell.draw();
    if(mousemovecell.value>=0){
      fill(126,192,238);
    }
    else{
      fill(240,128,128);
    }
    noStroke();
    textFont(labelFont1,14);
    String ss=str(s);
    if(ss.equals("NaN")){
      ss="no Value";
    }
    rect(mouseX,mouseY-15,textWidth(ss),ygap,3,3,3,3);
    //text(mousemovecell.name,mouseX,mouseY);
    fill(255);
    
    text(ss,mouseX,mouseY);
    //println(mousemovecell.value);
    
  }

}

void drawcell(){
  int i,j,ylabelnum,xlabelnum;
  if(counnum>-nupdown+19)ylabelnum=-nupdown+19;
  else ylabelnum=counnum;
  if(crinum>-nleftright+5)xlabelnum=-nleftright+5;
  else xlabelnum=crinum;
  cells = new Cell[(ylabelnum+nupdown)*(xlabelnum+nleftright)];
  for(i=-nleftright;i<xlabelnum;i++){
    for(j=-nupdown;j<ylabelnum;j++){
      Cell cell = new Cell(j+nupdown,i+nleftright);
      cells[(i+nleftright)*(ylabelnum+nupdown)+(j+nupdown)]=cell;
    }
  }  
}

void drawlines(){
   
   int i,j,ylabelnum,xlabelnum;
   int llent=0;
   double lmax=0;
   double t;
   if(counnum>-nupdown+19)ylabelnum=-nupdown+19;
   else ylabelnum=counnum;
   if(crinum>-nleftright+5)xlabelnum=-nleftright+5;
   else xlabelnum=crinum;
   //cells = new Cell[counnum*crinum];
   for(i=-nleftright;i<xlabelnum;i++){
     lmax=findmax(crisele[i].name);
     //println(crisele[i].name+"="+lmax);
     for(j=-nupdown;j<ylabelnum;j++){
        Cell cell = new Cell(j+nupdown,i+nleftright);
        cell.setcont(crisele[i].name,datasets.getData(datasets.getCricode(crisele[i].name),datasets.getCouncode(counsele[j].name)),counsele[j].name);
        t=datasets.getData(datasets.getCricode(crisele[i].name),datasets.getCouncode(counsele[j].name));
        if(uselog==0)llent=(int)(t*0.8/lmax*xgap);
        else if(uselog==1){
          //t=t*100;
          //lmax=lmax*100;//!!!!!!!!!!!!!!!!!!!deform!!!!!!!!!!!!
          if(t<0){
            llent=(int)(-log((float)-t)*0.8/log((float)lmax)*xgap);
          }
          else if(t>0)llent=(int)(log((float)t)*0.8/log((float)lmax)*xgap);
          else llent=0;
        }
        
        cells[(i+nleftright)*(ylabelnum+nupdown)+(j+nupdown)]=cell;
        noStroke();
        if(llent<0){
          llent = - llent;
          fill(240,128,128);
        }
        else fill(120);
        rect(71+(i+nleftright)*xgap,78+(j+nupdown)*ygap,llent,3);
     }
   }
   
  if(mouseclicklabel!=null){
    if(mouseclicklabel.axis==0){
      if(counnum+1>1-nupdown+19)ylabelnum=1-nupdown+19;
      else ylabelnum=counnum+1;
      if(crinum>-nleftright+5)xlabelnum=-nleftright+5;
      else xlabelnum=crinum;
      for(j=1-nupdown;j<ylabelnum;j++){
        if(ylabel[j].name==mouseclicklabel.name){
          for(i=-nleftright;i<xlabelnum;i++){
            cells[(i+nleftright)*(ylabelnum+nupdown-1)+(j-1+nupdown)].showvalue();
          }
        } 
      }
    }
    if(mouseclicklabel.axis==1){
      if(counnum>-nupdown+19)ylabelnum=-nupdown+19;
      else ylabelnum=counnum;
      if(crinum>-nleftright+5)xlabelnum=-nleftright+5;
      else xlabelnum=crinum;
      for(i=-nleftright;i<xlabelnum;i++){
        if(xlabel[i].name==mouseclicklabel.name){
          for(j=-nupdown;j<ylabelnum;j++){
            cells[(i+nleftright)*(ylabelnum+nupdown)+(j+nupdown)].showvalue();
          }
        } 
      }
    }
  }   
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

//////////////////////mouse interactive///////////////
void mouseMoved(){
   //try in the labels
   mousemovelabel=null;
   int i,j,ylabelnum,xlabelnum;
   //ylabel;
   if(mouseX>=0 && mouseX<450 && mouseY>=0 && mouseY<450){
     if(counnum>-nupdown+20)ylabelnum=-nupdown+20;
     else ylabelnum=counnum;
     for(i=-nupdown+1;i<ylabelnum;i++){
       if(ylabel[i].contains(mouseX,mouseY)==true){
         if(ylabel[i].sele==0){
           ylabel[i].setstate(1);
         }
         mousemovelabel= ylabel[i];
         mousemovecell=null;
       }
       else if(ylabel[i].sele==1){
         ylabel[i].setstate(0);
         mousemovecell=null;
       }
     }
     //xlabel
     if(crinum>-nleftright+5)xlabelnum=-nleftright+5;
     else xlabelnum=crinum;
     for(i=-nleftright;i<xlabelnum;i++){
       if(xlabel[i].contains(mouseX,mouseY)==true){
         if(xlabel[i].sele==0){
           xlabel[i].setstate(1);
         }
         mousemovelabel= xlabel[i];
         mousemovecell=null;
       }
       else if(xlabel[i].sele==1){
         xlabel[i].setstate(0);
         mousemovelabel=null;
       }
     }
  
     //cell
    if(counnum>-nupdown+19)ylabelnum=-nupdown+19;
    else ylabelnum=counnum;
    for(i=-nleftright;i<xlabelnum;i++)
      for(j=-nupdown;j<ylabelnum;j++){
        if(cells[(i+nleftright)*(ylabelnum+nupdown)+(j+nupdown)].contains(mouseX,mouseY)==true){
          if(cells[(i+nleftright)*(ylabelnum+nupdown)+(j+nupdown)].sele==0){
            mousemovecell= cells[(i+nleftright)*(ylabelnum+nupdown)+(j+nupdown)];
            mousemovelabel=null;
            cells[(i+nleftright)*(ylabelnum+nupdown)+(j+nupdown)].setstate(1);  
          }
  
        }
        else if(cells[(i+nleftright)*(ylabelnum+nupdown)+(j+nupdown)].sele==1){
          cells[(i+nleftright)*(ylabelnum+nupdown)+(j+nupdown)].setstate(0); 
          mousemovecell=null;
        }
     } 
  
     //if(l!=null && l!=lastlabel)println("I choose a label:"+l.name);
     //else if(c!=null && l!=lastlabel)println("I choose a cell:"+c.name+","+c.cri);
    // else if(l==null&&l!=lastlabel)println("nothing I choose"); 
     /*if(lastlabel==null){
       //if(mousemovelabel!=null)println(mousemovelabel.name+","+mousemovelabel.sele);
     }
     else if(mousemovelabel!=null){//i don't know why can't compare the objet directly in fact it should compare the name!
       if(mousemovelabel.name!=lastlabel.name){
         //println(mousemovelabel.name+","+mousemovelabel.sele);
         //if(lastlabel!=null)println("lastlabel="+lastlabel.name);
         //if(mousemovelabel==lastlabel)println("the same");
         //text(mousemovelabel.name,10,300);
       }
     }
     //lastcell=c;
     if(lastcell==null){
       //if(mousemovecell!=null)println("I choose a cell:"+mousemovecell.name+","+mousemovecell.cri);
     }
     else if(mousemovecell!=null){
         if(mousemovecell.name!=lastcell.name ){
           //println("I choose a cell:"+mousemovecell.name+","+mousemovecell.cri+mousemovecell.sele);
           //if(lastcell!=null)println("lastcell:"+lastcell.name+","+lastcell.cri);
           //text("I choose a cell:"+mousemovecell.name+","+mousemovecell.cri,mouseX,mouseY);
         }
     }*/
     lastlabel=mousemovelabel;
     lastcell=mousemovecell;
     //redraw();
   }
}

void mouseClicked(){
  int i,j,ylabelnum,xlabelnum;
  if(counnum>-nupdown+20)ylabelnum=-nupdown+20;
  else ylabelnum=counnum;
   //ylabel;
   for(i=-nupdown+1;i<ylabelnum;i++){
     if(ylabel[i].contains(mouseX,mouseY)==true){
       if(ylabel[i].sele==1){
         ylabel[i].setstate(2);
       }
       mouseclicklabel= ylabel[i];
       mouseclickcell=null;
     }
     else if(ylabel[i].sele==2){
       ylabel[i].setstate(1);
       mouseclickcell=null;
     }
   }
   //xlabel
   if(crinum>-nleftright+5)xlabelnum=-nleftright+5;
   else xlabelnum=crinum;
   for(i=-nleftright;i<xlabelnum;i++){
     if(xlabel[i].contains(mouseX,mouseY)==true){
       if(xlabel[i].sele==1){
         xlabel[i].setstate(2);
       }
       mouseclicklabel= xlabel[i];
       mouseclickcell=null;
     }
     else if(xlabel[i].sele==2){
       xlabel[i].setstate(1);
       mouseclicklabel=null;
     }
   }
   if(ylabel[0].contains(mouseX,mouseY)==true){
     mouseclicklabel= ylabel[0];
   }
   //cell

   //if(l!=null && l!=lastlabel)println("I choose a label:"+l.name);
   //else if(c!=null && l!=lastlabel)println("I choose a cell:"+c.name+","+c.cri);
  // else if(l==null&&l!=lastlabel)println("nothing I choose"); 

  
}

void keyPressed(){
  if(keyPressed){
    if(key=='l'){
      if(uselog==0)uselog=1;
      else if(uselog==1)uselog=0;
    }
    if(keyCode==UP){
      if(nupdown<0)nupdown++;
    }
    if(keyCode==DOWN){
      if(-nupdown<counnum)nupdown--;
    }
    if(keyCode==LEFT){
      if(nleftright<0)nleftright++;
    }
    if(keyCode==RIGHT){
      if(-nleftright<crinum)nleftright--;
    }
    if(key=='q'){
      nupdown=0;
      nleftright=0;
    }
  }
}

void ykeyscroller(){
  if(keyCode==UP || keyCode==DOWN){
    translate(0,ygap*nupdown);
  }
}

void xkeyscroller(){
  if(keyCode==LEFT || keyCode==RIGHT){
    translate(xgap*nleftright,0);
  } 
}

void updownmask(){
  //translate(-20*nleftright,-ygap*nupdown);
  fill(255);
  noStroke();
  //rect(0,450,500,50);
  rect(0,0,500,70);
  ylabel[0].draw(); 
  drawxlabel();
}
void lrmask(){
  fill(255);
  noStroke();
  rect(0,0,70,500);
  //rect(450,0,70,500);
  drawylabel();
}
void mymask(){
  fill(255);
  noStroke();
  //rect(0,450,500,50);
  fill(126,192,238);
  text("Note: Press the key UP,DOWN,LEFT and RIGHT to change view",10,470);
  text("           Press key l to change into log ",10,485);
  //fill(255);
  //rect(450,0,70,500);
}

