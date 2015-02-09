//This file is used for reading the data.
/*
File countriesScreenBordersFile = new File(mainFolder + "\\screen borders.txt");
FileWriter countriesScreenBordersFileWriter = new FileWriter(countriesScreenBordersFile.getAbsoluteFile());
BufferedWriter countriesScreenBordersBufferedWriter = new BufferedWriter(countriesScreenBordersFileWriter);          
map.writeScreenBordersToFile(countriesScreenBordersBufferedWriter);
countriesScreenBordersFileWriter.close();

File countriesSurfacesFile = new File(mainFolder + "\\surfaces.txt");
FileWriter countriesSurfacesFileWriter = new FileWriter(countriesSurfacesFile.getAbsoluteFile());
BufferedWriter countriesSurfacesBufferedWriter = new BufferedWriter(countriesSurfacesFileWriter);
map.writeSurfaceToFile(countriesSurfacesBufferedWriter);
countriesSurfacesBufferedWriter.close();
*/

void getMapDataFromScreenBorder() {
    try {
          map = new Map();

          Charset charset = Charset.forName("UTF-8");
    
          File countriesBordersFile = new File(mainFolder + "\\screen borders.txt");
          FileReader countriesBordersFileReader = new FileReader(countriesBordersFile.getAbsoluteFile());
          BufferedReader countriesBordersBufferedReader = new BufferedReader(countriesBordersFileReader);
          
          File countriesSurfacesFile = new File(mainFolder + "\\surfaces.txt");
          FileReader countriesSurfacesFileReader = new FileReader(countriesSurfacesFile.getAbsoluteFile());
          BufferedReader countriesSurfacesBufferedReader = new BufferedReader(countriesSurfacesFileReader);
          
          File countriesNamesFile = new File(mainFolder + "\\names.txt");
          FileReader countriesNamesFileReader = new FileReader(countriesNamesFile.getAbsoluteFile());
          BufferedReader countriesNamesBufferedReader = new BufferedReader(countriesNamesFileReader);
          
          String line = "";
          while ((line = countriesNamesBufferedReader.readLine()) != null) {
              
              String name = line;              
              Country newCountry = new Country();
              
              String bufferString;
              bufferString = countriesBordersBufferedReader.readLine();
              bufferString = countriesSurfacesBufferedReader.readLine();
              int numOfPolygons = Integer.parseInt(bufferString);
              
              for(int i = 0; i < numOfPolygons; ++i)
              {
                  //Get the border
                  bufferString = countriesBordersBufferedReader.readLine();
                  int numOfBorderPoints = Integer.parseInt(bufferString);
                  bufferString = countriesBordersBufferedReader.readLine();
                  String[] stringCoordinates = bufferString.split(" ");
                  List<Point> points = new ArrayList<Point>();
                  for(int j = 0; j < numOfBorderPoints; ++j)
                  {
                      float curX = Float.parseFloat(stringCoordinates[2 * j]);
                      float curY = Float.parseFloat(stringCoordinates[2 * j + 1]);
                      points.add(new Point(curX, curY, seaColor));
                  }
                  Region newRegion = new Region();
                  newRegion.setOriginalBorder(points);
                  newRegion.setNormalizedBorderFromPoints(points);
                  
                  //Get the surface
                  bufferString = countriesSurfacesBufferedReader.readLine();
                  int numOfSurfacePoints = Integer.parseInt(bufferString);
                  bufferString = countriesSurfacesBufferedReader.readLine();
                  stringCoordinates = bufferString.split(" ");
                  points = new ArrayList<Point>();
                  for(int j = 0; j < numOfSurfacePoints; ++j)
                  {
                      float curX = Float.parseFloat(stringCoordinates[2 * j]);
                      float curY = Float.parseFloat(stringCoordinates[2 * j + 1]);
                      points.add(new Point(curX, curY, color(0, 0, 255, 255)));
                  }
                  newRegion.fillSurfaceFromPoints(points);
                  newCountry.regions.add(newRegion);
              }
              map.countries.add(newCountry);
          }
          countriesNamesBufferedReader.close();
          countriesBordersBufferedReader.close();
          countriesSurfacesBufferedReader.close();
          
          map.assignColorsToTheCountries();
          map.indexCountries();
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
        countryFields = stringBuffer.split(";");
        stringBuffer = countryInfoBufferedReader.readLine();
        int numOfFields = countryFields.length;
        
        System.out.println(countryFields.length);
        
        while((stringBuffer = countryInfoBufferedReader.readLine()) != null) {
              
            String[] fieldData = stringBuffer.split(";", numOfFields);
            Country readCountry = map.getCountryWithName(fieldData[0]);
            //System.out.println(fieldData[0]);
            if(readCountry != null)
            {
                System.out.println(readCountry.name);
                for(int i = 1; i < numOfFields; ++i)
                if(!fieldData[i].isEmpty())
                {
                    readCountry.addField(countryFields[i], Double.parseDouble(fieldData[i]));
                }
            } 
        }
        countryInfoBufferedReader.close();
    }
    catch (IOException e)
    {
    }
}

void WriteToFile()
{
    for(int i = 1; i < countryFields.length; ++i)
    {
        try {
            String fileName = countryFields[i].replace("/","");
            File infoFile = new File("D:\\data_" + fileName + ".txt");
            FileWriter infoFileWriter = new FileWriter(infoFile.getAbsoluteFile());
            BufferedWriter infoFileBufferWriter = new BufferedWriter(infoFileWriter);
            
            infoFileBufferWriter.write(countryFields[i] + "\r\n");
            for(Country country: map.countries)
            {
                NumberFormat nf = NumberFormat.getInstance();
                nf.setMinimumFractionDigits(7);
                ((DecimalFormat) nf).setDecimalSeparatorAlwaysShown(false);
                if(country.countryInfo.get(countryFields[i]) != null)
                {
                      Double x = (Double)country.countryInfo.get(countryFields[i]);
                      infoFileBufferWriter.write(nf.format(x) + "\r\n");
                }
                else
                      infoFileBufferWriter.write(0 + "\r\n");
            }
            infoFileBufferWriter.close();
        }
        catch (IOException e)
        {
            System.out.println("Error");
        }
    }
    
}
