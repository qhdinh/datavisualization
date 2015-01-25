public class Point
{
    
    public float x;
    public float y;
    public color pointColor;
    
    public Point()
    {
    }
    
    public Point(float x, float y, color pointColor)
    {
        this();
        this.x = x;
        this.y = y;
        this.pointColor = pointColor;
    }
    
    public Point(Point originalPoint)
    {
        this(originalPoint.x, originalPoint.y, originalPoint.pointColor);
    }
    
    public Point Normalize(int ratio)
    {
        float newX = map(this.x, minX, maxX, 0, width);
        float newY = map(this.y, minY, maxY, height, 0);
        return new Point(newX, newY, pointColor);
    }
    
    public void draw()
    {
        set((int)x, (int)y, pointColor);
    }
    
    public float getDistance(Point point)
    {
        return (this.x - point.x) * (this.x - point.x) + (this.y - point.y) * (this.y - point.y);
    }
    
    public void setIndex(int[][] countryIndex, int index)
    {
        countryIndex[(int)y][(int)x] = index;
    }
    
    public void usesData(double[][] data, Double info)
    {
        data[(int)y][(int)x] = info;
    }
    
    public void fillColor(color newColor)
    {
        pointColor = newColor;
    }
    
    public void writeToFile(BufferedWriter bufferWriter)
    {
        try {
            bufferWriter.write(Integer.toString((int)x) + " " + Integer.toString((int)y) + " ");
        }
        catch (IOException e)
        {
        }
    }
}
