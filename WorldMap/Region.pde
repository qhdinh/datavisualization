public class Region
{
    public Country country;
    
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
    
    public void setOriginalBorder(List<Point> points)
    {
        originalBorder.clear();
        for(Point point: points)
            originalBorder.add(point);
    }
    
    public void setNormalizedBorderFromPoints(List<Point> points)
    {
        int[] x = new int [points.size()];
        for (int i = 0; i < points.size(); ++i)    x[i] = (int)points.get(i).x;
        
        int[] y = new int [points.size()];
        for (int i = 0; i < points.size(); ++i)    y[i] = (int)points.get(i).y;
        

        normalizedBorder = new Polygon(x, y, points.size());
        normalizedBound = normalizedBorder.getBounds();
    }
    
    public void setNormalizedBorderFromRawBorder(float minX, float minY, float maxX, float maxY)
    {
        for(int i = 0; i < screenWidth; ++i)
            Arrays.fill(screenMark[i], false);
         
        List<Point> points = new ArrayList(); 
        for(Point point : originalBorder)
        {
            Point newPoint = point.Normalize(minX, minY, maxX, maxY);
            //System.out.println(newPoint.x + " " + newPoint.y + "\r\n");
            if ((newPoint.x >= 0) && (newPoint.x < screenWidth) &&
                (newPoint.y >= 0) && (newPoint.y < screenHeight)&&
                (screenMark[(int)newPoint.x][(int)newPoint.y] == false))
            {
                screenMark[(int)newPoint.x][(int)newPoint.y] = true;
                points.add(newPoint);
            }
        }
        setNormalizedBorderFromPoints(points);
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
    
    public void fillSurfaceFromPoints(List<Point> surface)
    {
        this.surface.clear();
        for(Point point : surface)
            this.surface.add(point);
    }
    
    public void fillSurfaceFromNormalizedBorder()
    {        
        int minX = Integer.MAX_VALUE;
        int minY = Integer.MAX_VALUE;
        int maxX = Integer.MIN_VALUE;
        int maxY = Integer.MIN_VALUE;
          
        for(int i = 0; i < normalizedBorder.npoints; ++i)
        {
            if(minX > normalizedBorder.xpoints[i])  minX = normalizedBorder.xpoints[i];
            if(minY > normalizedBorder.ypoints[i])  minY = normalizedBorder.ypoints[i];
            if(maxX < normalizedBorder.xpoints[i])  maxX = normalizedBorder.xpoints[i];
            if(maxY < normalizedBorder.ypoints[i])  maxY = normalizedBorder.ypoints[i];
        }
               
        for(int tx = minX; tx <= maxX; ++tx)
            for(int ty = minY; ty <= maxY; ++ty)
              if(normalizedBorder.contains(tx, ty))
                  surface.add(new Point(tx, ty, seaColor));
    }
    
    public void draw()
    {
        if(surface.size() == 0)
            return;
            
        int state = this.country.state;
        
        color usedBorderColor = color(255, 255, 255, 255);
        color usedSurfaceColor = country.countryColor;
        switch (state) {
            case GUIControl.STATE_NORMAL:
                //usedBorderColor = color(255, 255, 255, 255);
                usedBorderColor = country.countryColor;//color(0, 0, 0, 255);
                break;
            case GUIControl.STATE_HOVER:
                usedBorderColor = color(255, 255, 0, 255);
                usedSurfaceColor = color(min(red(usedSurfaceColor) + 50, 255),
                                         min(green(usedSurfaceColor) + 50, 255),
                                         min(blue(usedSurfaceColor) + 50, 255),
                                         255);
                break;
            case GUIControl.STATE_CLICKED:
                usedBorderColor = color(255, 255, 0, 255);
                usedSurfaceColor = color(min(red(usedSurfaceColor) + 50, 255),
                                         min(green(usedSurfaceColor) + 50, 255),
                                         min(blue(usedSurfaceColor) + 50, 255),
                                         255);
                break;
        }
        
        stroke(usedBorderColor);
        for(int i = 0; i < normalizedBorder.npoints; ++i)
        {
            Point point = new Point((float)normalizedBorder.xpoints[i], (float)normalizedBorder.ypoints[i], color(255, 255, 255, 255));
            set((int)point.x, (int)point.y, usedBorderColor);
            //point.draw();
        }
        
        stroke(usedSurfaceColor);
        for(Point point : surface)
            set((int)point.x, (int)point.y, usedSurfaceColor);
            //point.draw();
    }
    
    int getDistance(int x1, int y1, int x2, int y2)
    {
        return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
    }
    
    public boolean adjacent(Region region)
    {
        return this.normalizedBound.intersects(region.normalizedBound);
    }
    
    public void writeSurfaceToFile(BufferedWriter bufferWriter)
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
    
    public void writeScreenBordersToFile(BufferedWriter bufferWriter)
    {
        try {
            bufferWriter.write(Integer.toString(normalizedBorder.npoints) + "\r\n");
            //System.out.println("screen " + normalizedBorder.npoints);
            for(int i = 0; i < normalizedBorder.npoints; ++i)
            {
                bufferWriter.write((int)normalizedBorder.xpoints[i] + " " + (int)normalizedBorder.ypoints[i] + " ");
                //System.out.print(normalizedBorder.xpoints[i] + " " + normalizedBorder.ypoints[i] + " ");
            }
            //System.out.println("\n");
            bufferWriter.write("\r\n");
        }
        catch (IOException e)
        {
        }
        catch (Exception e)
        {
            System.out.println(e.toString());
        }
    }
}
