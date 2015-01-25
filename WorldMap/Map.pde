//Contain all information of the map (countries, points, ...)
//Each function of this class may call to the functions with the SAME NAME and PURPOSE of its members
public class Map
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
        countries = new ArrayList();
        this.ratio = ratio;
        countryIndices = new int[screenHeight][screenWidth];
        countryInfo = new double[screenHeight][screenWidth];
    }
    
    public Map(List<Country> countries, int ratio)
    {
        this();
        for(Country country : countries)
            this.countries.add(new Country(country));
        this.ratio = ratio;
    }
    
    public Map(Map originalMap)
    {
        this(originalMap.countries, originalMap.ratio);
    }
        
    public void draw()
    {
        strokeWeight(1);
        for(Country country : countries)
        {
            country.draw();
        }
    }
    
    //From the border, find all points inside them and fill in the surface
    public void fillSurface(int ratio)
    {
        for(Country country : countries)
        {
            country.fillSurface(ratio);
        }
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
    
    //Fill color for the all the country
    public void assignColors()
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
    
    //Get total number of points inside the countries (to debug)
    public int getNumberOfPoints()
    {
        int numberOfPoints = 0;
        for(Country country : countries)
        for(Region region : country.regions)
            numberOfPoints += region.surface.size();
        
        return numberOfPoints;
    }
    
    //Write all the normalized borders to file (for the future use)
    public void writeToFile(BufferedWriter bufferWriter)
    {
        for(Country country : countries)
        {
            country.writeToFile(bufferWriter);
        }
    }
}
