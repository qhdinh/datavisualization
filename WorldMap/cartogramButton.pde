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
            map.chosenCartogramCriteria = chosenCriteria.get(0);
            map.getBorderFromFile(sketchPath(mainFolder + "\\Cartograms\\" + CartogramName.get(map.chosenCartogramCriteria) + ".txt"), false);
        }
    }
}
