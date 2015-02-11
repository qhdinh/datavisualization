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
        final int TOP_LEFT = 0,
                  TOP_RIGHT = 1,
                  BOTTOM_LEFT = 2,
                  BOTTOM_RIGHT = 3;
        
        int position = TOP_LEFT,
            frameWidth = 6 + (int)textWidth(name),
            frameHeight = 6 + textHeight,
            top = 0,
            left = 0,
            bottom = 0,
            right = 0;
        
        if(mouseX - frameWidth <= 0)
        {
            if(mouseY - frameHeight <= 0)
                position = BOTTOM_RIGHT;
            else
                position = TOP_RIGHT;
        }
        else
        {
            if(mouseY - frameHeight <= 0)
                position = BOTTOM_LEFT;
            else
                position = TOP_LEFT;
        }
        
        switch(position)
        {
            case TOP_LEFT:
                left = mouseX - frameWidth;
                top = mouseY - frameHeight;
                right = mouseX;
                bottom = mouseY;
                break;
            case TOP_RIGHT:
                left = mouseX;
                top = mouseY - frameHeight;
                right = mouseX + frameWidth;
                bottom = mouseY;
                break;
            case BOTTOM_LEFT:
                left = mouseX - frameWidth;
                top = mouseY;
                right = mouseX;
                bottom = mouseY + frameHeight;
                break;
            case BOTTOM_RIGHT:
                left = mouseX;
                top = mouseY;
                right = mouseX + frameWidth;
                bottom = mouseY + frameHeight;
                break;
        }
        
        fill(color(149, 33, 246, 100));
        rect(left, top, right - left + 1, bottom - top + 1);
        fill(color(216, 0, 115, 255));
        textSize(textHeight);
        text(name, left + 4, top + textHeight + 2);
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
                chooseCountryToList(name);
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
