public class Country extends GUIControl
{
    public Map map;
    
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
        state = STATE_NORMAL;
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
    
    public void drawInformation()
    {
        fill(color(0, 255, 255, 255));
        rect(mouseX - 100, mouseY - 100, 100, 100);
    }
    
    void mouseMoved()
    {
        state = STATE_NORMAL;
        for(Region region: regions)
            if(region.normalizedBorder.contains(mouseX, mouseY))
            {
                state = STATE_HOVER;
                break;
            }
    }
    
    void mouseClicked()
    {
        state = STATE_NORMAL;
        for(Region region: regions)
            if(region.normalizedBorder.contains(mouseX, mouseY))
            {
                state = STATE_CLICKED;
                break;
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
    
    public void writeSurfaceToFile(BufferedWriter bufferWriter)
    {
        try {
            bufferWriter.write(Integer.toString(regions.size()) + "\r\n");
            for(Region region : regions)
            {
                region.writeSurfaceToFile(bufferWriter);
            }
        }
        catch (IOException e)
        {
        }
    }
    
    public void writeScreenBordersToFile(BufferedWriter bufferWriter)
    {
        try {
            bufferWriter.write(Integer.toString(regions.size()) + "\r\n");
            for(Region region : regions)
            {
                region.writeScreenBordersToFile(bufferWriter);
            }
        }
        catch (IOException e)
        {
        }
    }
}
