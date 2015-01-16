import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

class DataRead{
  public List<String> columns;
  public List<String> columnTypes;
  public ArrayList<List<String>> data = new ArrayList<List<String>>();
  
  
  public DataRead(String filename){
    BufferedReader br = null;
    try {
 
      String sCurrentLine;
      String [] doc = loadStrings(filename);
      String [] items;
      items = doc[0].split(";");
      this.columns = Arrays.asList(items);
      items = doc[1].split(";");
      this.columnTypes = Arrays.asList(items);
      
      for(int i = 2; i < doc.length; i++){
          items = doc[i].split(";");
          this.data.add(Arrays.asList(items));      
      
      }

    } finally {
      try {
        if (br != null)br.close();
      } catch (IOException ex) {
        ex.printStackTrace();
      }
    } 
  }

}
