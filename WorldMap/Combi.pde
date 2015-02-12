class Combi
{
    //global variable for the graph star
    public Criteria[] crisele;
    public CountryCombi[] counsele;
    public float angapMin = QUARTER_PI/6;
    public int rMax = 200;
    public int xcentre = 560;
    public int ycentre = 280;
    public PFont labelFont1;
    public int snum=0;
    public char[] searchname;
    public char[] nametemp;
    
    //global variable for the graph parallel
    public int xgapMinp=15;
    public int ygapMaxp=300;
    //global variable for the table
    public int xgapMint = 75;
    public boolean search = false;
    
    //construct the main prog
    public Star star;
    public Mean mean;
    public Tables tables;
    public int graphnum=0;
    public char[] searchnamet;
    
    public Combi()
    {
      counsele = new CountryCombi[263];
      crisele = new Criteria[44];
      searchname = new char[50];
      searchnamet = new char[50];
    }
    
    void draw(){
      if(graphnum==0)tables.draw();
      else if(graphnum==1)mean.draw();
      else if(graphnum==2)star.draw();
      //fill(150);
      //rect(0,0,300,1366);
      //rect(0,568,1366,300);
      
    }
    
    void mouseMoved(){
      if(graphnum==0)tables.mouseMoved();
      else if(graphnum==1)mean.mouseMoved();
      else if(graphnum==2)star.mouseMoved();
    }
    
    void keyPressed(){
      int i;
      if(graphnum==1 || graphnum==2){
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
      else if(graphnum==0){
        tables.keyPressed();
        if(search==true){
          if(snum==0){
            for(i=0;i<searchnamet.length;i++){
              searchnamet[i]=0;
            }
          }
          if(keyCode==BACKSPACE && snum>0)snum--;
          if(keyCode!=BACKSPACE && keyCode!=SHIFT && keyCode!=ENTER && keyCode!=CONTROL){
            searchnamet[snum]=key;
            println("snum="+snum);
            snum++;
          }
          if(keyCode==ENTER && search==true)nametemp = new char[snum];
        }
      }
      
      
    }
    
    void mouseClicked(){
      if((mouseX < map.left) | (mouseX > map.right) | (mouseY < map.top) | (mouseY > map.bottom))
          return;
      if(graphnum==0)tables.mouseClicked();
      else if(graphnum==1)mean.mouseClicked();
      else if(graphnum==2)star.mouseClicked();
      println("I am in the "+graphnum+" graph!");
    }
}

