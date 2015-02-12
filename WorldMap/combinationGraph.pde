class combinationGraph
{
    //global variable for the graph star
    Criteria[] crisele;
    CountryCombi[] counsele;
    float angapMin = QUARTER_PI/6;
    int rMax = 200;
    int xcentre = 560;
    int ycentre = 280;
    PFont labelFont1;
    int snum=0;
    char[] searchname;
    char[] nametemp;
    
    //global variable for the graph parallel
    int xgapMinp = 15;
    int ygapMaxp = 300;
    //global variable for the table
    int xgapMint = 75;
    boolean search = false;
    
    //construct the main prog
    DataReadCombi datasets1 = null;
    Star star;
    Mean mean;
    Tables tables;
    int graphnum=0;
    char[] searchnamet;
    
    void initialize(){
      size(1366, 768);
      int i,j;
      datasets1 = new DataReadCombi();
      counsele = new CountryCombi[263];
      crisele = new Criteria[44];
      searchname = new char[50];
      searchnamet = new char[50];
      for(i=0;i<20;i++){
        CountryCombi c = new CountryCombi(datasets1.counname[i+220].name,i+220);
        counsele[i]=c;
      }
      for(i=0;i<11;i++){
        Criteria cri = new Criteria(datasets1.criteria[i+5].name,i+5);
        crisele[i]=cri;
      }
      star = new Star();
      mean = new Mean();
      tables = new Tables();
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
      if(graphnum==0)tables.mouseClicked();
      else if(graphnum==1)mean.mouseClicked();
      else if(graphnum==2)star.mouseClicked();
      println("I am in the "+graphnum+" graph!");
    }
}


