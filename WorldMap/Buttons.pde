Button cartogramButton;
Button correlationButton;
Button otherButton;
Button backButton;

void initializeButtons()
{    
    cartogramButton = controlP5.addButton("cartogramButton")
                               .setValue(0)
                               .setPosition(10, 630)
                               .setSize(200, 20)
                               ;
    cartogramButton.captionLabel().set("Cartogram");
    
    // and add another 2 buttons
    correlationButton = controlP5.addButton("correlationButton")
                               .setValue(100)
                               .setPosition(10, 655)
                               .setSize(200, 20)
                               ;
    correlationButton.captionLabel().set("Correlation");
    
    otherButton = controlP5.addButton("otherButton")
                               .setValue(0)
                               .setPosition(10, 680)
                               .setSize(200, 20)
                               ;
    otherButton.captionLabel().set("Other");
    
    backButton = controlP5.addButton("backButton")
                           .setValue(0)
                           .setPosition(10, 705)
                           .setSize(200, 20)
                           ;
    backButton.captionLabel().set("Back to map");
}
