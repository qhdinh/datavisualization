public class Country
{
    public String name;
    
    //Each country may have many separated parts called Regions
    public List<Region> regions;
    
    //The color of the country on the map
    public color countryColor;
    
    //Information of the fields
    public java.util.Map countryInfo = new HashMap();
    
    public Country()
    {
        name = "";
        regions = new ArrayList(); 
        countryColor = seaColor;
    }
    
    public Country(String name, List<Region> regions)
    {
        this();
        this.name = name;
        for(Region Region : regions)
            this.regions.add(new Region(Region));
    }
    
    public Country(Country originalCountry)
    {
        this(originalCountry.name, originalCountry.regions);
    }
    
    public void addField(String field, double fieldData)
    {
        countryInfo.put(field, fieldData);
    }
    
    //Fill in the array Map.countryIndices
    public void setIndex(int[][] countryIndex, int index)
    {
        for(Region region : regions)
            region.setIndex(countryIndex, index);
    }
    
    //Fill in the array Map.countryInfo
    public void usesData(double[][] data, String field)
    {
        if(countryInfo.get(field) != null)
            for(Region region : this.regions)
                region.usesData(data, (Double)countryInfo.get(field));
    }
    
    public void fillSurface(int ratio)
    {
        for(Region Region : regions)
        {
            Region.fillSurface(ratio);
        }
    }
    
    public void fillColor(color newColor)
    {
        countryColor = newColor;
        for(Region region : regions)
        for(Point point : region.surface)
            point.fillColor(countryColor);
    }
    
    public void draw()
    {
        for(Region region : regions)
        {
            region.draw();
        }
    }
    
    //Check if the two countries are very closed to each other (relatively)
    public boolean adjacent(Country country)
    {
        for(Region region1 : this.regions)
        for(Region region2 : country.regions)
        if(region1.adjacent(region2))
            return true;
        return false;
    }
    
    public void writeToFile(BufferedWriter bufferWriter)
    {
        try {
            bufferWriter.write(Integer.toString(regions.size()) + "\r\n");
            for(Region region : regions)
            {
                region.writeToFile(bufferWriter);
            }
        }
        catch (IOException e)
        {
        }
    }
}
