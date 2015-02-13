Button cartogramButton;
Button correlationButton;
Button otherButton;
Button backButton;
color BUTTON_BACKGROUND = color(91,91,91,255);//color(176,23,31,255);//color(0,104,139,255);//color(51,102,153,255);//color(92,64,51,255);
color BUTTON_FOREGROUND = color(40,40,40,255);//color(0,154,205,255);//color(133,94,66,255);

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
    
    otherButton = controlP5.addButton("combinationButton")
                               .setValue(0)
                               .setPosition(10, 680)
                               .setSize(200, 20)
                               .setColorBackground(BUTTON_BACKGROUND)
                               .setColorForeground(BUTTON_FOREGROUND)
                               ;
    otherButton.captionLabel().set("Combination Graphs");
    
    backButton = controlP5.addButton("backButton")
                           .setValue(0)
                           .setPosition(10, 705)
                           .setSize(200, 20)
                           .setColorBackground(BUTTON_BACKGROUND)
                           .setColorForeground(BUTTON_FOREGROUND)
                           ;
    backButton.captionLabel().set("Back to map");
}
