void otherButton(int value)
{
    updateListOfChosenCountriesAndCriteria();
    
    if(firstCombiButtonCall == true)
    {
        firstCombiButtonCall = false;
        return;
    }
    
    usedMode = MODE_COMBI;
    
    
    for(int i = 0; i < 263; ++i)
    {
      //CountryCombi c = new CountryCombi(chosenCountryNames.get(i), 0);
      combi.counsele[i] = null;
    }
    
    for(int i = 0; i < 44; ++i)
    {
      //Criteria cri = new Criteria(chosenCriteria.get(i), 0);
      combi.crisele[i]=null;
    }
    
    for(int i = 0; i < chosenCountryNames.size(); ++i)
    {
      CountryCombi c = new CountryCombi(chosenCountryNames.get(i), 0);
      combi.counsele[i] = c;
    }
    
    for(int i = 0; i < chosenCriteria.size(); ++i)
    {
      Criteria cri = new Criteria(chosenCriteria.get(i), 0);
      combi.crisele[i]=cri;
    }
    
    combi.star = new Star();
    combi.mean = new Mean();
    combi.tables = new Tables();
}
