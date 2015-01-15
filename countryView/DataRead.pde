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
    } finally {
      try {
        if (br != null)br.close();
      } catch (IOException ex) {
        ex.printStackTrace();
      }
    } 
  }

}
