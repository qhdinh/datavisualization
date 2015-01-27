

String[] crisele;
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


void setup(){
  size(500,500);
  //background(255);
  counsele = new Country[263];
  ///////////////////////////////////initialisation manually
  Country c1 = new Country("Albania", 3563112, 28748,15.08,5.12,-504000000);
  Country c2 = new Country("Argentina", 39537943, 2766890,16.90,7.56,5473000000.0);
  Country c3 = new Country("Belgium", 10364388, 30528,10.48,10.22,11400000000.0);
  Country c4 = new Country("Brazil",186112794,8511965,16.83,6.15,8000000000.0);
  Country c5 = new Country("China",1306313812,9596960,13.14,6.94,30320000000.0);
  Country c6 = new Country("France",60656178,547030,12.15,9.08,-305000000.0);
  Country c7 = new Country("Vietnam",83535576,329560,17.07,6.20,-2061000000.0);
  
  counsele[0]= c1;
  counsele[1]= c2;
  counsele[2]= c3;
  counsele[3]= c4;
  counsele[4]= c5;
  counsele[5]= c6;
  counsele[6]= c7;
  
  /*counsele[7]= c1;
  counsele[8]= c2;
  counsele[9]= c3;
  counsele[10]= c4;
  counsele[11]= c5;
  counsele[12]= c6;
  counsele[13]= c7;
  counsele[14]= c1;
  counsele[15]= c2;
  counsele[16]= c3;
  counsele[17]= c4;
  counsele[18]= c5;
  counsele[19]= c6;
  counsele[20]= c7;
  counsele[21]= c1;
  counsele[22]= c2;
  counsele[23]= c3;
  counsele[24]= c4;
  counsele[25]= c5;
  counsele[26]= c6;
  counsele[27]= c7;*/
  
  //println(counsele[0].name);
  if(counsele[1]==null)println("1=null");
  crisele = new String[45];
  ////////////////////////////////////initialisation manually
  crisele[0]="population";
  crisele[1]="area";
  crisele[2]="birthrate";
  crisele[3]="deathrate";
  crisele[4]="current_account_balance";
  
}

void draw(){
  background(255);
  //xkeyscroller();
  //ykeyscroller();
  drawxlabel();
  drawylabel();
  drawcell();
  drawlines();
  drawmousemove();
  //translate(-xgap*nleftright,-ygap*nupdown);
  //mymask();
  if(keyCode==UP || keyCode==DOWN)updownmask();
  if(keyCode==LEFT || keyCode==RIGHT)lrmask();
  mymask();
  drawaxis();
}

void findscale(){
  int i=0;
  for(Country cc : counsele){
    if(cc!=null)i++;
  }
  counnum = i;
  //println("country="+counnum);
  i=0;
  for(String s : crisele){
    if(s!=null)i++;
  }
  crinum = i;
  //println("criteria="+crinum);
  double x=0;
  x=xlent*1.0/crinum;
  if(x>xgapMin)xgap=(int)x;
  else xgap=xgapMin;
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
  ylabel = new Label[counnum+1];
  Label ylabelcoun = new Label(0);
  ylabel[0]=ylabelcoun;
  ylabel[0].draw("country",0);
  int i,j;
  for(i=-nupdown;i<counnum;i++){
    Label ylabeltemp = new Label(0);
    ylabel[i+1]=ylabeltemp;
    ylabel[i+1].draw(counsele[i].name,i+1+nupdown);
  }
    
}

void drawxlabel(){
  int i,j;
  xlabel = new Label[crinum];
  for(i=-nleftright;i<crinum;i++){
    Label xlabeltemp = new Label(1);
    xlabel[i]=xlabeltemp;
    xlabel[i].draw(crisele[i],i+nleftright);
    //stroke(120);
    //line(70+i*xgap,50,70+i*xgap,450);
  }
    


}

void drawmousemove(){
  int i,j;
  if(mousemovelabel!=null){
    mousemovelabel.draw();
    if(mousemovelabel.axis==1){
      for(i=-nleftright;i<crinum;i++){
        if(xlabel[i].name==mousemovelabel.name){
          for(j=-nupdown;j<counnum;j++){
            cells[i*counnum+j].draw();
          }
        } 
      }
    }
  }
  if(mousemovelabel!=null){
    mousemovelabel.draw();
    if(mousemovelabel.axis==0){
      for(j=1-nupdown;j<counnum+1;j++){
        if(ylabel[j].name==mousemovelabel.name){
          for(i=-nleftright;i<crinum;i++){
            cells[i*counnum+j-1].draw();
          }
        } 
      }
    }
  }

}

void drawcell(){
  int i,j;
  cells = new Cell[counnum*crinum];
  for(i=-nleftright;i<crinum;i++){
    for(j=-nupdown;j<counnum;j++){
      Cell cell = new Cell(j+nupdown,i+nleftright);
      cells[i*counnum+j]=cell;
    }
  }  
}

void drawlines(){
   
   int i,j;
   int llent=0;
   double lmax=0;
   //cells = new Cell[counnum*crinum];
   for(i=-nleftright;i<crinum;i++){
     for(j=-nupdown;j<counnum;j++){
        Cell cell = new Cell(j+nupdown,i+nleftright);
        if(crisele[i]=="population"){
          lmax=findmax("population");
          //println(lmax);
          if(uselog==0)llent = (int)(counsele[j].population*0.8/lmax*xgap);
          else if(uselog==1)llent = (int)(log((float)counsele[j].population)*0.8/log((float)lmax)*xgap);
          cell.setcont(crisele[i],counsele[j].population,counsele[j].name);
        }
        if(crisele[i]=="area"){
          lmax=findmax("area");
          if(uselog==0)llent = (int)(counsele[j].area*0.8/lmax*xgap);
          else if(uselog==1)llent = (int)(log((float)counsele[j].area)*0.8/log((float)lmax)*xgap);
          cell.setcont(crisele[i],counsele[j].area,counsele[j].name);
        }
        if(crisele[i]=="birthrate"){
          lmax=findmax("birthrate");
          if(uselog==0)llent = (int)(counsele[j].birthrate*0.8/lmax*xgap);
          else if(uselog==1)llent = (int)(log((float)counsele[j].birthrate)*0.8/log((float)lmax)*xgap);
          cell.setcont(crisele[i],counsele[j].birthrate,counsele[j].name);
        }
        if(crisele[i]=="deathrate"){
          lmax=findmax("deathrate");
          if(uselog==0)llent = (int)(counsele[j].deathrate*0.8/lmax*xgap);
          else if(uselog==1)llent = (int)(log((float)counsele[j].deathrate)*0.8/log((float)lmax)*xgap);
          cell.setcont(crisele[i],counsele[j].deathrate,counsele[j].name);
        }
        if(crisele[i]=="current_account_balance"){
          lmax=findmax("current_account_balance");
          if(uselog==0)llent = (int)(counsele[j].current_account_balance*0.8/lmax*xgap);
          else if(uselog==1){
            if(counsele[j].current_account_balance<0){
              llent = (int)(-log((float)-counsele[j].current_account_balance)*0.8/log((float)lmax)*xgap);
            }
            else llent = (int)(log((float)counsele[j].current_account_balance)*0.8/log((float)lmax)*xgap);
          }
          cell.setcont(crisele[i],counsele[j].current_account_balance,counsele[j].name);
        }
        cells[i*counnum+j]=cell;
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
      for(j=1-nupdown;j<counnum+1;j++){
        if(ylabel[j].name==mouseclicklabel.name){
          for(i=-nleftright;i<crinum;i++){
            cells[i*counnum+j-1].showvalue();
          }
        } 
      }
    }
    if(mouseclicklabel.axis==1){
      for(i=-nleftright;i<crinum;i++){
        if(xlabel[i].name==mouseclicklabel.name){
          for(j=-nupdown;j<counnum;j++){
            cells[i*counnum+j].showvalue();
          }
        } 
      }
    }
  }
  if(mousemovecell!=null){
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
      rect(mouseX,mouseY-15,xgap+40,ygap,3,3,3,3);
      //text(mousemovecell.name,mouseX,mouseY);
      fill(255);
      text(s,mouseX,mouseY);
      //println(mousemovecell.value);
    
  }
  
   
}

double findmax(String str){
   double max=0;
   int i;
   //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!try to use the reflection of JAVA
   //Class cla = Class.forName("com.hhf.reflect.DataFunc");
   //Field[] field = cla.getDeclaredFields();
   if(str=="population"){
     for(i=0;i<counnum;i++){
       if(counsele[i].population>max){
         max=counsele[i].population;
       }
     }
   }
   if(str=="area"){
     for(i=0;i<counnum;i++){
       if(counsele[i].area>max){
         max=counsele[i].area;
       }
     }
   }
   if(str=="birthrate"){
     for(i=0;i<counnum;i++){
       if(counsele[i].birthrate>max){
         max=counsele[i].birthrate;
       }
     }
   }
   if(str=="deathrate"){
     for(i=0;i<counnum;i++){
       if(counsele[i].deathrate>max){
         max=counsele[i].deathrate;
       }
     }
   }
   if(str=="current_account_balance"){
     for(i=0;i<counnum;i++){
       if(counsele[i].current_account_balance>max){
         max=counsele[i].current_account_balance;
       }
     }
   }
   return max;
}

//////////////////////mouse interactive///////////////
void mouseMoved(){
   //try in the labels
   int i,j;
   //ylabel;
   for(i=-nupdown+1;i<counnum+1;i++){
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
   for(i=-nleftright;i<crinum;i++){
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
  for(i=-nleftright;i<crinum;i++)
    for(j=-nupdown;j<counnum;j++){
      if(cells[i*counnum+j].contains(mouseX,mouseY)==true){
        if(cells[i*counnum+j].sele==0){
          mousemovecell= cells[i*counnum+j];
          mousemovelabel=null;
          cells[i*counnum+j].setstate(1);  
        }

      }
      else if(cells[i*counnum+j].sele==1){
        cells[i*counnum+j].setstate(0); 
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

void mouseClicked(){
  int i,j;
   //ylabel;
   for(i=-nupdown+1;i<counnum+1;i++){
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
   for(i=-nleftright;i<crinum;i++){
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
      nupdown--;
    }
    if(keyCode==LEFT){
      if(nleftright<0)nleftright++;
    }
    if(keyCode==RIGHT){
      nleftright--;
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
  rect(0,450,500,50);
  fill(126,192,238);
  text("Note: Press the key UP,DOWN,LEFT and RIGHT to change view",10,470);
  text("           Press key l to change into log ",10,485);
  fill(255);
  rect(450,0,70,500);
}

