Button cartogramButton;
Button correlationButton;
Button otherButton;

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
                               .setPosition(10, 660)
                               .setSize(200, 20)
                               ;
    correlationButton.captionLabel().set("Correlation");
    
    otherButton = controlP5.addButton("otherButton")
                               .setValue(0)
                               .setPosition(10, 690)
                               .setSize(200, 20)
                               ;
    otherButton.captionLabel().set("Other");
}
