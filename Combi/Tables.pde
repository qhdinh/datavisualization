class Tables{
  int crinum = 0;
  int counnum = 0;
  int xlent = 780;
  int ylent = 400;
  int xgap ;
  int ygap = 20;
  Label[] ylabel; 
  Label[] xlabel;
  Cell[] cells;
  Label mousemovelabel=null;
  Label lastlabel=null;
  //Label clikclabel=null;
  Cell mousemovecell=null;
  Cell lastcell = null;
  //int oney;
  //int onex;
  Label mouseclicklabel=null;
  Label mouseclickcell=null;
  int uselog = 0;
  int nupdown = 0;
  int nleftright = 0;
  DataRead datasets = null;
  String sortcri="Choose Critera";
  int clc=0;
  int clct=0;
  //boolean search = false;
  
  public Tables(){
    //size(640,500);
    //background(255);
    datasets = new DataRead();
    //counsele = new Country[263];
    ///////////////////////////////////initialisation manually
    /*Country c1 = new Country("Albania", 0);
    Country c2 = new Country("Argentina", 1);
    Country c3 = new Country("Belgium", 2);
    Country c4 = new Country("Brazil",3);
    Country c5 = new Country("China",4);
    Country c6 = new Country("France",5);
    Country c7 = new Country("Vietnam",6);*/
    int i,j;
     
    /*counsele[0]= c1;
    counsele[1]= c2;
    counsele[2]= c3;
    counsele[3]= c4;
    counsele[4]= c5;
    counsele[5]= c6;
    counsele[6]= c7;*/
    
    
    
    //println(counsele[0].name);
    ////////////////////////////////////initialisation manually

    /*crisele[0]=cr1;
    crisele[1]=cr2;
    crisele[2]=cr3;
    crisele[3]=cr4;
    crisele[4]=cr5;*/
    labelFont1 = loadFont("Dotum-14.vlw");
    //textFont(labelFont1,14);
    fill(30,144,255);
    findscale();
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
    noting();
    search();
    graphchange();
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
    if(x>xgapMint)xgap=(int)x;
    else xgap=xgapMint;
    //println("xgap="+xgap);
  }
  
  void drawaxis(){
    //translate(-20*nleftright,-ygap*nupdown);
    text("General View", 780,20);
    fill(120);
    stroke(120);
    line(370,50,1150,50);
    triangle(1150,47,1150,53,1157,50);
    line(370,50,370,450);// no consider the scroller first
    triangle(367,450,373,450,370,457);
    int i,xlabelnum;
    if(crinum>-nleftright+10)xlabelnum=-nleftright+10;
    else xlabelnum=crinum;
    for(i=-nleftright;i<xlabelnum;i++){
      stroke(120);
      line(370+(i+nleftright)*xgap,50,370+(i+nleftright)*xgap,450);
    }
  }
  
  void drawylabel(){
    int i,j,ylabelnum;
    if(counnum>-nupdown+19)ylabelnum=-nupdown+19;
    else ylabelnum=counnum;
    ylabel = new Label[ylabelnum+1];
    Label ylabelcoun = new Label(0);
    ylabel[0]=ylabelcoun;
    ylabel[0].draw("country",0,xgap);
    for(i=-nupdown;i<ylabelnum;i++){
      Label ylabeltemp = new Label(0);
      ylabel[i+1]=ylabeltemp;
      ylabel[i+1].draw(counsele[i].name,i+1+nupdown,xgap);
    }
      
  }
  
  void drawxlabel(){
    int i,j,xlabelnum;
    if(crinum>-nleftright+10)xlabelnum=-nleftright+10;
    else xlabelnum=crinum;
    xlabel = new Label[xlabelnum];
    for(i=-nleftright;i<xlabelnum;i++){
      Label xlabeltemp = new Label(1);
      xlabel[i]=xlabeltemp;
      xlabel[i].draw(crisele[i].name,i+nleftright,xgap);
      //stroke(120);
      //line(70+i*xgap,50,70+i*xgap,450);
    }
      
  
  
  }
  
  void drawmousemovelabel(){
    int i,j,ylabelnum,xlabelnum;
    if(mousemovelabel!=null){
      mousemovelabel.draw(xgap);
      if(mousemovelabel.axis==1){
        if(counnum>-nupdown+19)ylabelnum=-nupdown+19;
        else ylabelnum=counnum;
        if(crinum>-nleftright+10)xlabelnum=-nleftright+10;
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
      mousemovelabel.draw(xgap);
      if(mousemovelabel.axis==0){
        if(counnum+1>1-nupdown+19)ylabelnum=1-nupdown+19;
        else ylabelnum=counnum+1;
        if(crinum>-nleftright+10)xlabelnum=-nleftright+10;
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
      labelFont1 = loadFont("Dotum-14.vlw");
      //textFont(labelFont1,14);
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
    if(crinum>-nleftright+10)xlabelnum=-nleftright+10;
    else xlabelnum=crinum;
    cells = new Cell[(ylabelnum+nupdown)*(xlabelnum+nleftright)];
    for(i=-nleftright;i<xlabelnum;i++){
      for(j=-nupdown;j<ylabelnum;j++){
        Cell cell = new Cell(j+nupdown,i+nleftright,xgap,ygap);
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
     if(crinum>-nleftright+10)xlabelnum=-nleftright+10;
     else xlabelnum=crinum;
     //cells = new Cell[counnum*crinum];
     for(i=-nleftright;i<xlabelnum;i++){
       lmax=findmax(crisele[i].name);
       //println(crisele[i].name+"="+lmax);
       for(j=-nupdown;j<ylabelnum;j++){
          Cell cell = new Cell(j+nupdown,i+nleftright,xgap,ygap);
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
          rect(371+(i+nleftright)*xgap,78+(j+nupdown)*ygap,llent,3);
       }
     }
     
    if(mouseclicklabel!=null){
      if(mouseclicklabel.axis==0){
        if(counnum+1>1-nupdown+19)ylabelnum=1-nupdown+19;
        else ylabelnum=counnum+1;
        if(crinum>-nleftright+10)xlabelnum=-nleftright+10;
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
        if(crinum>-nleftright+10)xlabelnum=-nleftright+10;
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
     if(mouseX>=0 && mouseX<850 && mouseY>=0 && mouseY<450){
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
       if(crinum>-nleftright+10)xlabelnum=-nleftright+10;
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
    if(((mouseX-1300)*(mouseX-1300)+(mouseY-520)*(mouseY-520))<3600)clc=1;
    else clc=0;
    if(((mouseX-1300)*(mouseX-1300)+(mouseY-420)*(mouseY-420))<3600)clct=1;
    else clct=0;
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
     if(crinum>-nleftright+10)xlabelnum=-nleftright+10;
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
    if(((mouseX-1300)*(mouseX-1300)+(mouseY-520)*(mouseY-520))<3600)graphnum=1;
    if(((mouseX-1300)*(mouseX-1300)+(mouseY-420)*(mouseY-420))<3600)graphnum=2;
    
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
      if(key=='s'){
        sorting();
      }
      if(keyCode==CONTROL){
        search=true;
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
    rect(0,40,500,30);
    ylabel[0].draw(xgap); 
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
    //fill(255);
    //noStroke();
    //rect(0,450,500,50);
    fill(120);
    text("Note: Press the key UP,DOWN,LEFT and RIGHT to change view",310,500);
    text("           Press key l to change into log ",310,535);
    //fill(255);
    //rect(450,0,70,500);
  }
  
  void sorting(){
    if(mousemovelabel!=null){
      if(mousemovelabel.axis==1){
        sortcri=mousemovelabel.name;
        int i,j;
        double temp,mmax;
        Country ctemp = new Country();
        int ccoun=0;
        float s;
        String ss;
        for(i=0;i<counnum;i++){
          mmax=datasets.getData(datasets.getCricode(mousemovelabel.name),datasets.getCouncode(counsele[i].name));
          ccoun=i;
          for(j=i;j<counnum;j++){
            temp=datasets.getData(datasets.getCricode(mousemovelabel.name),datasets.getCouncode(counsele[j].name));
            s=(float)(temp);
            ss=str(s);
            if(ss.equals("NaN"))continue;
            if(temp>mmax){
              //println("temp="+temp+"max="+mmax);
              mmax=temp;
              ccoun=j;
            }
          }
          //println("to be change="+counsele[i].name);
          //println("max="+counsele[ccoun].name);
          ctemp.name=counsele[i].name;
          ctemp.councode=i;
          counsele[i].name=counsele[ccoun].name;
          counsele[i].councode=j;
          counsele[ccoun].name=ctemp.name;
          counsele[ccoun].councode=ctemp.councode;
        }
      }
    }
  }
  
  void noting(){
    color[] col = new color[3];
    col[2]=color(240,128,128);
    col[1]=color(255,160,122);
    col[0]=color(255,193,193);
  
    int i;
    for(i=0;i<3;i++){
      noStroke();
      fill(col[i],200);
      ellipse(1190,100,20-i*6,20-i*6);
    }
    for(i=0;i<3;i++){
      noStroke();
      fill(col[i],200);
      ellipse(1190,195,20-i*6,20-i*6);
    }
    fill(120);
    labelFont1 = loadFont("Dotum-14.vlw");
    //textFont(labelFont1,14);
    text("Sorting",1210,106);
    text(sortcri,1180,136);
    
    
  }
  
  void search(){
    //labelFont1 = loadFont("Dotum-12.vlw");
    int i=0;
    fill(120);
    text("SEARCH:",1205,200);
    text("Country's name", 1200,230);
    if(keyCode==ENTER && keyCode!=SHIFT){
      for(i=0;i<searchnamet.length;i++){
        text(searchnamet[i],1200+i*7,260);
        if(i<snum && (snum!=0))nametemp[i]=searchnamet[i];
      }
      
      String ssname = new String(nametemp);
      //println("***"+ssname+"***");
      for(i=0;i<counnum;i++){
        if(ssname.equals(counsele[i].name)){
          println("councode="+i);
          searchcoun(i);
          fill(120);
          text("Find "+ssname+" :)", 1200,290);
          break;
        }
      }
      if(i==counnum)text("Cannot find it :(",1200,290);
      snum=0;  
      search=false;
    }
    
  }
  
  void searchcoun(int _councode){
    int i,j,shift,xlabelnum,ylabelnum;
    if(counnum>-nupdown+19)ylabelnum=-nupdown+19;
     else ylabelnum=counnum;
    if(crinum>-nleftright+10)xlabelnum=-nleftright+10;
     else xlabelnum=crinum;
     
    for(i=-nleftright;i<xlabelnum;i++){
      cells[(i+nleftright)*(ylabelnum+nupdown)].draw();
      //println("@@@@@@@@@@@@@@@");
    }
    shift=_councode;
    nupdown=-shift;
    
  }
  
   void graphchange(){
    noStroke();
    fill(126,192,238,100);
    ellipse(1300,520,60,60);
    ellipse(1300,420,60,60);
    if(clc==0)fill(126,192,238,180);
    else fill(120,180);
    ellipse(1300,520,55,55);

    
    if(clct==0)fill(126,192,238,180);
    else fill(120,180);
    ellipse(1300,420,55,55);
    stroke(255);
    strokeWeight(3);
    line(1285,530,1285,510);
    line(1285,530,1315,530);
    line(1295,530,1295,505);
    line(1305,530,1305,515);
    line(1315,530,1315,520);
    fill(255,0);
    triangle(1290,430,1310,430,1300,410);
    strokeWeight(1);
  }
  
  
}
