void backButton(int value)
{
    updateListOfChosenCountriesAndCriteria();
    
    if(usedMode != MODE_CARTOGRAM)
    {
        usedMode = MODE_CARTOGRAM;
        map.getBorderFromFile(sketchPath(mainFolder + "\\Cartograms\\Area.txt"), false);
    }
}
