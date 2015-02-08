//Contain all information of the map (countries, points, ...)
//Each function of this class may call to the functions with the SAME NAME and PURPOSE of its members
public class Map extends GUIControl
{    
  
    public List<Country> countries;
    
    //To zoom the map (if possible)
    public int ratio;
    
    //countryIndices(x, y) contains the index of the country at ROW x, COLLUMN y
    //The index of each country is determine in the order of the list countries
    //This can be used for the mouse events
    public int[][] countryIndices;
    
    //The field that is used to express (up to now, for CARTOGRAM)
    public String  usedCountryInfo;
    
    //countryInfo(x, y) contains the value of the field usedCountryInfo at ROW x, COLLUMN y, -1 if no country contains this point
    public double[][] countryInfo;
    
    public Map()
    {
        left = 20;
        top = 100;
        right = 1346;
        bottom = 748;
        countries = new ArrayList();
        this.ratio = ratio;
        countryIndices = new int[screenHeight][screenWidth];
        countryInfo = new double[screenHeight][screenWidth];
    }
    
    public void draw()
    {
        strokeWeight(3);
        fill(seaColor);
        stroke(color(0, 0, 0, 255));
        rect(left - 3, top - 3, width() + 2 * 3, height() + 2 * 3);
        strokeWeight(1);
        for(Country country : countries)
        {
            country.draw();
        }
        
        for(Country country : countries)
            if(country.state == STATE_CLICKED)
                country.drawInformation();
    }
    
    //Fill in the array countryIndices
    public void indexCountries()
    {
        for(int i = 0; i < screenHeight; ++i)
            Arrays.fill(countryIndices[i], -1);
        for(int i = 0; i < countries.size(); ++i)
        {
            countries.get(i).setIndex(countryIndices, i);
        }
    }
    
    public void normalizeRegionsFromRawBorder(float minX, float minY, float maxX, float maxY)
    {
        for(Country country: countries)
        {
            for(Region region: country.regions)
                region.setNormalizedBorderFromRawBorder(minX, minY, maxX, maxY);
        }
    }
    
    public void fillSurfaceFromNormalizedBorder()
    {
        for(Country country: countries)
        {
            for(Region region: country.regions)
                region.fillSurfaceFromNormalizedBorder();
        }
    }
    
    //Set the used field
    public void usesData(String field)
    {
        for(int i = 0; i < screenHeight; ++i)
            Arrays.fill(countryInfo[i], -1);
        for(Country country : countries)
            country.usesData(countryInfo, field);
    }
    
    public Country getCountryWithName(String name)
    {
        for(Country country : countries)
            if(country.name.equals(name))
                  return country;
        return null;
    }
    
    //Fill color for all the country
    public void assignColorsToTheCountries()
    {
        //Get the adjacent matrix
        int n = countries.size();
        boolean[][] adjacent = new boolean[n][n];
        for(int i = 0; i < n; ++i)
            adjacent[i][i] = false;
        for(int i = 0; i < n; ++i)
        for(int j = i + 1; j < n; ++j)
            if(countries.get(i).adjacent(countries.get(j)))
                adjacent[i][j] = adjacent[j][i] = true;
            else
                adjacent[i][j] = adjacent[j][i] = false;
                
        int numOfColors = countryColors.length;
        int iterations = 0;
        while(true)
        {
            //Get an uncolored country
            int countryIndex = -1;
            for(int i = 0; i < n; ++i)
            if(countries.get(i).countryColor == seaColor)
            {
                countryIndex = i;
                break;
            }
            if(countryIndex < 0)
                break;
            
            //Find the color
            boolean[] usedColor = new boolean[numOfColors];
            Arrays.fill(usedColor, false);  
            for(int i = 0; i < n; ++i)
            if((adjacent[countryIndex][i]) && (countries.get(i).countryColor != seaColor))
            {
                for(int j = 0; j < numOfColors; ++j)
                if(countries.get(i).countryColor == countryColors[j])
                {
                    usedColor[j] = true;
                    break;
                }
            }
            int colorIndex = 0;
            for(int i = 0; i < numOfColors; ++i)
            if(usedColor[i] == false)
            {
                colorIndex = i;
                break;
            }
                
            //Assign the color
            countries.get(countryIndex).fillColor(countryColors[colorIndex]);
        }
    }
    
    void mouseMoved()
    {
        for(Country country: countries)
        {
            country.mouseMoved();
        }
    }
    
    void mouseClicked()
    {
        for(Country country: countries)
        {
            country.mouseClicked();
        }
    }
    
    public void getBorderFromFile(String filename, boolean isEmptyMap)
    {
        float minX = 0;
        float maxX = 0;
        float minY = 0;
        float maxY = 0;  
      
        try {              
              Charset charset = Charset.forName("UTF-8");
        
              File countriesBordersFile = new File(filename);
              FileReader countriesBordersFileReader = new FileReader(countriesBordersFile.getAbsoluteFile());
              BufferedReader countriesBordersBufferedReader = new BufferedReader(countriesBordersFileReader);
              
              File countriesNamesFile = new File(mainFolder + "\\names.txt");
              FileReader countriesNamesFileReader = new FileReader(countriesNamesFile.getAbsoluteFile());
              BufferedReader countriesNamesBufferedReader = new BufferedReader(countriesNamesFileReader);
                            
              String line = "";
              while ((line = countriesNamesBufferedReader.readLine()) != null) {
                  
                  String name = line;
                  Country newCountry = null;
                  if(isEmptyMap)
                  {
                      newCountry = new Country();
                      newCountry.name = name;
                  }
                  else
                      newCountry = getCountryWithName(name);
                      
                  newCountry.regions.clear();
                  String bufferString = countriesBordersBufferedReader.readLine();
                  int numOfPolygons = Integer.parseInt(bufferString);
                  System.out.println("name " + name);
                  for(int i = 0; i < numOfPolygons; ++i)
                  {
                      bufferString = countriesBordersBufferedReader.readLine();
                      int numOfPoints = Integer.parseInt(bufferString);
                      
                      bufferString = countriesBordersBufferedReader.readLine();
                      String[] stringCoordinates = bufferString.split(" ");
                      
                      List<Point> points = new ArrayList<Point>();
                      
                      for(int j = 0; j < numOfPoints; ++j)
                      {
                          float curX = Float.parseFloat(stringCoordinates[2 * j]);
                          float curY = Float.parseFloat(stringCoordinates[2 * j + 1]);
                          points.add(new Point(curX, curY, seaColor));
                          
                          if(minX > (int)curX)  minX = (int)curX;
                          if(minY > (int)curY)  minY = (int)curY;
                          if(maxX < (int)curX)  maxX = (int)curX;
                          if(maxY < (int)curY)  maxY = (int)curY;
                      }
                          
                      Region newRegion = new Region();
                      newRegion.setOriginalBorder(points);
                      newRegion.country = newCountry;
                      newCountry.regions.add(newRegion);
                  }
                  newCountry.map = map;
                  
                  if(isEmptyMap)
                      map.countries.add(newCountry);
              }
              countriesNamesBufferedReader.close();
              countriesBordersBufferedReader.close();
              
              map.normalizeRegionsFromRawBorder(minX, minY, maxX, maxY);
              map.fillSurfaceFromNormalizedBorder();
              
              if(isEmptyMap)
                  map.assignColorsToTheCountries();
                  
              map.indexCountries();
        }
        catch (IOException e)
        {
        }
    }
    
    //Get total number of points inside the countries (to debug)
    public int getNumberOfPoints()
    {
        int numberOfPoints = 0;
        for(Country country : countries)
        for(Region region : country.regions)
            numberOfPoints += region.surface.size();
        
        return numberOfPoints;
    }
    
    public void writeSurfaceToFile(BufferedWriter bufferWriter)
    {
        for(Country country : countries)
        {
            country.writeSurfaceToFile(bufferWriter);
        }
    }
    
    public void writeScreenBordersToFile(BufferedWriter bufferWriter)
    {
        try{
            for(Country country : countries)
            {
                bufferWriter.write(country.regions.size() + "\r\n");                
                for(Region region : country.regions)
                {
                    bufferWriter.write(Integer.toString(region.normalizedBorder.npoints) + "\r\n");                    
                    for(int i = 0; i < region.normalizedBorder.npoints; ++i)
                    {
                        bufferWriter.write((int)region.normalizedBorder.xpoints[i] + " " + (int)region.normalizedBorder.ypoints[i] + " ");
                    }
                    bufferWriter.write("\r\n");                }
            }
        }
        catch (IOException e)
        {
        }
    }
}
