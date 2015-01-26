public class Region
{
    //The original border in the original dataset
    public List<Point> originalBorder;
    
    //The normalize border with the point coordinates on the screen
    Polygon normalizedBorder;
    
    //All points inside the normalized border
    public List<Point> surface;
    
    //The bound rectangle of the normalized border
    public Rectangle normalizedBound;
    
    public Region()
    {
        originalBorder = new ArrayList();
        surface = new ArrayList();
    }

    public Region(List<Point> border)
    {
        this();
        for(Point point : border)
            this.originalBorder.add(new Point(point));
    }
    
    public Region(Region originalCountry)
    {
        this(originalCountry.originalBorder);
    }
    
    //Update the bound (for the first creation of the map of when zooming)
    public void updateBound()
    {
        normalizedBound = normalizedBorder.getBounds();
    }
    
    public void setIndex(int[][] countryIndex, int index)
    {
        for(Point point : surface)
            point.setIndex(countryIndex, index);
    }
    
    public void usesData(double[][] data, Double info)
    {
        for(Point point : surface)
            point.usesData(data, info);
    }
    
    public void fillSurface(int ratio)
    {
        List<Integer> normalizedBorderx = new ArrayList<Integer>();
        List<Integer> normalizedBordery = new ArrayList<Integer>();
        
        int minx = Integer.MAX_VALUE;
        int miny = Integer.MAX_VALUE;
        int maxx = Integer.MIN_VALUE;
        int maxy = Integer.MIN_VALUE;
     
        for(int i = 0; i < screenWidth; ++i)    Arrays.fill(screenMark[i], false);    
        
        for(Point point : originalBorder)
        {
            Point newPoint = point.Normalize(ratio);
            if ((newPoint.x >= 0) && (newPoint.x < screenWidth) &&
                (newPoint.y >= 0) && (newPoint.y < screenHeight)&&
                (screenMark[(int)newPoint.x][(int)newPoint.y] == false))
            {
                screenMark[(int)newPoint.x][(int)newPoint.y] = true;
                normalizedBorderx.add((int)newPoint.x);
                normalizedBordery.add((int)newPoint.y);
                if(minx > (int)newPoint.x)  minx = (int)newPoint.x;
                if(miny > (int)newPoint.y)  miny = (int)newPoint.y;
                if(maxx < (int)newPoint.x)  maxx = (int)newPoint.x;
                if(maxy < (int)newPoint.y)  maxy = (int)newPoint.y;
            }
        }
               
        int[] x = new int [normalizedBorderx.size()];
        for (int i = 0; i < normalizedBorderx.size(); ++i)    x[i] = normalizedBorderx.get(i);
        
        int[] y = new int [normalizedBordery.size()];
        for (int i = 0; i < normalizedBordery.size(); ++i)    y[i] = normalizedBordery.get(i);
        
        normalizedBorder = new Polygon(x, y, normalizedBorderx.size());
        updateBound();
        
        for(int tx = minx; tx <= maxx; ++tx)
            for(int ty = miny; ty <= maxy; ++ty)
              if(normalizedBorder.contains(tx, ty))
                  surface.add(new Point(tx, ty, color(0, 0, 255, 255)));
    }
    
    //Draw all point inside the borders and draw lines connecting 2 consecutive points of the borders
    public void draw()
    {
        if(surface.size() == 0)
            return;
        stroke(surface.get(0).pointColor);
        for(int i = 1; i < normalizedBorder.npoints; ++i)
              line(normalizedBorder.xpoints[i - 1], normalizedBorder.ypoints[i - 1], normalizedBorder.xpoints[i], normalizedBorder.ypoints[i]);
        if(normalizedBorder.npoints > 1)
              line(normalizedBorder.xpoints[normalizedBorder.npoints - 1], normalizedBorder.ypoints[normalizedBorder.npoints - 1],
                   normalizedBorder.xpoints[0], normalizedBorder.ypoints[0]);
        for(Point point : surface)
            point.draw();
    }
    
    int getDistance(int x1, int y1, int x2, int y2)
    {
        return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
    }
    
    public boolean adjacent(Region region)
    {
        return this.normalizedBound.intersects(region.normalizedBound);
    }
    
    public void writeToFile(BufferedWriter bufferWriter)
    {
        try {
            bufferWriter.write(Integer.toString(surface.size()) + "\r\n");
            for(Point point : surface)
            {
                point.writeToFile(bufferWriter);
            }
            bufferWriter.write("\r\n");
        }
        catch (IOException e)
        {
        }
    }
}
