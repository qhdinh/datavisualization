void cartogramButton(int value)
{
    updateListOfChosenCountriesAndCriteria();
    
    if(chosenCriteria.size() >= 1)
    {
        String usedCriteria = chosenCriteria.get(0);
        map.getBorderFromFile("D:\\Cartograms\\" + CartogramName.get(usedCriteria) + ".txt", false);
    }
}
