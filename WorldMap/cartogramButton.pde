void cartogramButton(int value)
{
    updateListOfChosenCountriesAndCriteria();
    
    if(usedMode != MODE_CARTOGRAM)
    {
        usedMode = MODE_CARTOGRAM;
    }
    else
    {
        if(chosenCriteria.size() >= 1)
        {
            String usedCriteria = chosenCriteria.get(0);
            map.getBorderFromFile(sketchPath(mainFolder + "\\Cartograms\\" + CartogramName.get(usedCriteria) + ".txt"), false);
        }
    }
}
