void backButton(int value)
{
    updateListOfChosenCountriesAndCriteria();
    
    
    if(usedMode != MODE_CARTOGRAM)
    {
        usedMode = MODE_CARTOGRAM;
    }
    if(map.chosenCartogramCriteria != "Area")
    {
        map.chosenCartogramCriteria = "Area";
        map.getBorderFromFile(sketchPath(mainFolder + "\\Cartograms\\" + map.chosenCartogramCriteria + ".txt"), false);
    } 
}
