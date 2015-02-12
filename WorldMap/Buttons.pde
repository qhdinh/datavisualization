Button cartogramButton;
Button correlationButton;
Button otherButton;
Button backButton;
color BUTTON_BACKGROUND = color(92,64,51,255);
color BUTTON_FOREGROUND = color(133,94,66,255);

void initializeButtons()
{    
    cartogramButton = controlP5.addButton("cartogramButton")
                               .setValue(0)
                               .setPosition(10, 630)
                               .setSize(200, 20)
                               .setColorBackground(BUTTON_BACKGROUND)
                               .setColorForeground(BUTTON_FOREGROUND)
                               ;
    cartogramButton.captionLabel().set("Cartogram");
    
    // and add another 2 buttons
    correlationButton = controlP5.addButton("correlationButton")
                               .setValue(100)
                               .setPosition(10, 655)
                               .setSize(200, 20)
                               .setColorBackground(BUTTON_BACKGROUND)
                               .setColorForeground(BUTTON_FOREGROUND)
                               ;
    correlationButton.captionLabel().set("Correlation");
    
    otherButton = controlP5.addButton("otherButton")
                               .setValue(0)
                               .setPosition(10, 680)
                               .setSize(200, 20)
                               .setColorBackground(BUTTON_BACKGROUND)
                               .setColorForeground(BUTTON_FOREGROUND)
                               ;
    otherButton.captionLabel().set("Other");
    
    backButton = controlP5.addButton("backButton")
                           .setValue(0)
                           .setPosition(10, 705)
                           .setSize(200, 20)
                           .setColorBackground(BUTTON_BACKGROUND)
                           .setColorForeground(BUTTON_FOREGROUND)
                           ;
    backButton.captionLabel().set("Back to map");
}
