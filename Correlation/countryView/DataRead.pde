import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

class DataRead{
  public List<String> columns;
  public List<String> columnTypes;
  public ArrayList<List<String>> data = new ArrayList<List<String>>();

  public int columnMax;  
  
  public ArrayList<DataPoint> getData(int codeX, int codeY){
     ArrayList<DataPoint> dlist = new ArrayList<DataPoint>();
     
     for(int i = 3; i < data.size(); i++){
         try{
         if(!data.get(i).get(codeX).equals("") && !data.get(i).get(codeY).equals(""))
             dlist.add(new DataPoint(data.get(i).get(0), 
                                     Float.parseFloat(data.get(i).get(codeX)), 
                                     Float.parseFloat(data.get(i).get(codeY)),
                                     data.get(i).get(columnTypes.size())));
         }catch(Exception e){
             continue;
         }
     }
    return dlist; 
  }
  
  public int getNCategories(){
    return columnTypes.size();
  }
  
  public float getMaxX(ArrayList<DataPoint> data){
      float maxx = data.get(0).x;
      for(DataPoint d : data){
          if(d.x > maxx)
              maxx = d.x;
      }
      return maxx;
  }
  
  public float getMaxY(ArrayList<DataPoint> data){
      float maxy = data.get(0).y;
      for(DataPoint d : data){
          if(d.y > maxy)
              maxy = d.y;
      }
      return maxy;
  }
  
  public float getMinX(ArrayList<DataPoint> data){
      float minx = data.get(0).x;
      for(DataPoint d : data){
          if(d.x < minx)
              minx = d.x;
      }
      return minx;
  }
  
  public float getMinY(ArrayList<DataPoint> data){
      float miny = data.get(0).y;
      for(DataPoint d : data){
          if(d.y < miny)
              miny = d.y;
      }
      return miny;
  }
  
  
  public String getTitle(int code){
      return columns.get(code);
  }
  
  public DataRead(String filename){
    BufferedReader br = null;
    try {
      
      String sCurrentLine;
      String [] items;
      br = new BufferedReader(new FileReader(filename));
      sCurrentLine = br.readLine();
      items = sCurrentLine.split(";");
      this.columns = Arrays.asList(items);
      sCurrentLine = br.readLine();
      items = sCurrentLine.split(";");
      this.columnTypes = Arrays.asList(items);
      
      while ((sCurrentLine = br.readLine()) != null) {
          items = sCurrentLine.split(";");
          this.data.add(Arrays.asList(items));
      }
 
    } catch (IOException e) {
      e.printStackTrace();
    } finally{
      try{
        br.close();
      }catch (IOException e) {
      e.printStackTrace();
      }
    }
    columnMax = columnTypes.size() -2;
  }
  
  public void setContinentColor(String name){
      if(name.equals("Asia")){
          fill(255,0,0,200);
      }else if(name.equals("Africa")){
          fill(255,255,0,200);
      }else if(name.equals("Europe")){
          fill(0,0,255,200);
      }else if(name.equals("South America")){
          fill(0,255,0,200);
      }else if(name.equals("North America")){
          fill(255,0,255,200);
      }else if(name.equals("Oceania")){
          fill(100,100,100,200);
      }else if(name.equals("Middle East")){
          fill(0,255,255,200);
      }
  }
  

}
