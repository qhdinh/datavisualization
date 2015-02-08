public class Button extends GUIControl
{    
    public color backgroundColor;
    public color hoverColor;
    public color clickedColor;
    public color textColor;
    public String caption;
    
    public int infoIndex;

    public Button()
    {
        backgroundColor  = color(0, 255, 0, 255);
        hoverColor       = color(0, 255, 150, 255);
        clickedColor     = color(120, 0, 150, 255);
        textColor        = color(255, 0, 255, 255);  
        state = STATE_NORMAL;
    }
  
    public void draw()
    {
        color usedColor = backgroundColor;
        switch (state) {
            case STATE_NORMAL:
                usedColor = backgroundColor;
                break;
            case STATE_HOVER:
                usedColor = hoverColor;
                break;
            case STATE_CLICKED:
                usedColor = clickedColor;
                break;
        }
        
        fill(usedColor);
        rect(left, top, width(), height());
        fill(textColor);
        text(caption, left + width() / 2 - (int)textWidth(caption) / 2, top + height() / 2 - textHeight + textHeight * 3 / 2 - 1);
    }
    
    public void mouseMoved()
    {
        if(contains(mouseX, mouseY))
            state = STATE_HOVER;
        else
            state = STATE_NORMAL;
    }
    
    public void mouseClicked()
    {
        if(contains(mouseX, mouseY))
        {
            state = STATE_CLICKED;
            map.getBorderFromFile("D:\\Cartograms\\" + CartogramName.get(caption) + ".txt", false);
        }
        else
            state = STATE_NORMAL;
    }
}
