class DataRead{
  Country[] counname;
  Criteria[] criteria;
  Double[] dataset;

  public DataRead(){
    String[] lines = loadStrings("D:\\Cloud\\GitHub\\datavisualization\\WorldMap\\data\\factbook.csv");
    int i,j;
    counname = new Country[lines.length-2];
    if(counname[1]==null)println("it is null");
    println(lines.length-2);
    String[] column0 = split(lines[0],";");
    //println(column0[column0.length-1]);
    criteria = new Criteria[column0.length-1];
    //println(column0.length);
    for(i=1;i<column0.length;i++){
      //println(column0[i]);
      Criteria cri = new Criteria(column0[i],i);
      criteria[i-1]=cri;
    }
    dataset = new Double[(lines.length-2)*(column0.length-1)];
    for(i=2;i<lines.length;i++){
      String[] columns = split(lines[i],";");
      Country c = new Country(columns[0],i-2);
      counname[i-2]=c;
      for(j=1;j<columns.length;j++){
        if(columns[j]!="")dataset[(i-2)*(columns.length-1)+j-1]=(double)float(columns[j]);
        else dataset[(i-2)*columns.length+j]=null;
        //println((double)float(columns[j]));
      }
    }
  }
  
  public int getCouncode(String str){
    int i,code;
    code=0;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    for(i=0;i<counname.length;i++){
      if(str.equals(counname[i].name)==true)code=i;
    }
    return code;
  }
  
  public int getCricode(String str){
    int i,code;
    //println(str+","+criteria[1].name);
    code=0;//!!!!!!!!!!!!!!!!!!!!!!!!!!1
    for(i=0;i<criteria.length;i++){
      //println(criteria[i].name);
      
      if(str.equals(criteria[i].name)==true){
        code=i;
        //println("find it");
      }
    }
    return code;
  }
  
  public double getData(int cricode,int councode){
    return dataset[councode*criteria.length+cricode];
  }
  
}
