public class GUIControl
{
    public static final int STATE_NORMAL = 0;
    public static final int STATE_HOVER = 1;
    public static final int STATE_CLICKED = 2;
    public int state;
    
    //Coordinates on the screen
    public int top;
    public int left;
    public int bottom;
    public int right;

    public int width()
    {
        return right - left + 1;
    }
    
    public int height()
    {
        return bottom - top + 1;
    }
    
    public boolean contains(int x, int y)
    {
        return ((left <= x) && (x <= right) && (top <= y) && (y <= bottom));
    }
}
