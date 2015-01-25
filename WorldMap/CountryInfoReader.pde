//This file is used for reading the data.

void getMapData() {

    minX = minY = Integer.MAX_VALUE;
    maxX = maxY = Integer.MIN_VALUE;
    
    try {
          Charset charset = Charset.forName("UTF-8");
    
          File countriesBordersFile = new File(mainFolder + "\\original borders.txt");
          FileReader countriesBordersFileReader = new FileReader(countriesBordersFile.getAbsoluteFile());
          BufferedReader countriesBordersBufferedReader = new BufferedReader(countriesBordersFileReader);
          
          File countriesNamesFile = new File(mainFolder + "\\country names.txt");
          FileReader countriesNamesFileReader = new FileReader(countriesNamesFile.getAbsoluteFile());
          BufferedReader countriesNamesBufferedReader = new BufferedReader(countriesNamesFileReader);
          
          String line = "";
          List<Country> countries = new ArrayList<Country>();
          while ((line = countriesNamesBufferedReader.readLine()) != null) {
              
              String name = line;
              System.out.println(name);
              
              String bufferString = countriesBordersBufferedReader.readLine();
              int numOfPolygons = Integer.parseInt(bufferString);
              List<Region> regions = new ArrayList<Region>();
              
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
                      points.add(new Point(curX, curY, color(0, 0, 255, 255)));
                      
                      if(minX > (int)curX)  minX = (int)curX;
                      if(minY > (int)curY)  minY = (int)curY;
                      if(maxX < (int)curX)  maxX = (int)curX;
                      if(maxY < (int)curY)  maxY = (int)curY;
                  }
                  regions.add(new Region(points));
              }
              countries.add(new Country(name, regions));
          }
          map = new Map(countries, ratio);
          map.fillSurface(100);
          map.assignColors();
          map.indexCountries();
          countriesNamesBufferedReader.close();
          countriesBordersBufferedReader.close();
          
    
          File countriesSurfacesFile = new File(mainFolder + "\\screen borders.txt");
          FileWriter countriesSurfacesFileWriter = new FileWriter(countriesSurfacesFile.getAbsoluteFile());
          BufferedWriter countriesSurfacesBufferedWriter = new BufferedWriter(countriesSurfacesFileWriter);
          map.writeToFile(countriesSurfacesBufferedWriter);
          countriesSurfacesBufferedWriter.close();
    }
    catch (IOException e)
    {
    }
}

void getCountryInfo()
{
    try {
        File countryInfoFile = new File(mainFolder + "\\world statistics.csv");
        FileReader countryInfoFileReader = new FileReader(countryInfoFile.getAbsoluteFile());
        BufferedReader countryInfoBufferedReader = new BufferedReader(countryInfoFileReader);
        
        String stringBuffer = countryInfoBufferedReader.readLine();
        String[] fields = stringBuffer.split(";");
        stringBuffer = countryInfoBufferedReader.readLine();
        int numOfFields = fields.length;
        while((stringBuffer = countryInfoBufferedReader.readLine()) != null) {
              
            String[] fieldData = stringBuffer.split(";", numOfFields);
            Country readCountry = map.getCountryWithName(fieldData[0]);
            System.out.println(fieldData.length);
            if(readCountry != null)
            {
                for(int i = 1; i < numOfFields; ++i)
                if(!fieldData[i].isEmpty())
                {
                    readCountry.addField(fields[i], Double.parseDouble(fieldData[i]));
                }
            } 
        }
        countryInfoBufferedReader.close();
    }
    catch (IOException e)
    {
    }
}

//Set the used data to draw cartogram or any other purpose
void getUsedData(String field)
{
    map.usesData(field);
    
    try{
        File countriesInfoMatrixFile = new File(mainFolder + "\\used data for cartogram.txt");
        FileWriter countriesInfoMatrixFileWriter = new FileWriter(countriesInfoMatrixFile.getAbsoluteFile());
        BufferedWriter countriesInfoMatrixBufferWriter = new BufferedWriter(countriesInfoMatrixFileWriter);
             
        for(int i = 0; i < screenHeight; ++i)
        {
            for(int j = 0; j < screenWidth; ++j)
                countriesInfoMatrixBufferWriter.write(((Double)map.countryInfo[i][j]).toString() + " ");
            countriesInfoMatrixBufferWriter.write("\r\n");
        }
        countriesInfoMatrixBufferWriter.close();


        File countriesIndicesMatrixFile = new File(mainFolder + "\\country indices.txt");
        FileWriter countriesIndicesMatrixFileWriter = new FileWriter(countriesIndicesMatrixFile.getAbsoluteFile());
        BufferedWriter countriesIndicesMatrixBufferWriter = new BufferedWriter(countriesIndicesMatrixFileWriter);
        
        for(int i = 0; i < screenHeight; ++i)
        {
            for(int j = 0; j < screenWidth; ++j)
                countriesIndicesMatrixBufferWriter.write(((Integer)map.countryIndices[i][j]).toString() + " ");
            countriesIndicesMatrixBufferWriter.write("\r\n");
        }
        countriesIndicesMatrixBufferWriter.close();
    }
    catch (IOException e)
    {
    }
}
