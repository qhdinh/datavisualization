void correlationButton(int value)
{
    updateListOfChosenCountriesAndCriteria();
    
    //The list of chosen country names is chosenCountryNames    
    //The list of chosen criteria is chosenCriteria
    //U can read the file WorldMap
    if(firstCorrelationButtonCall == true)
    {
        firstCorrelationButtonCall = false;
        return;
    }
    
    if(correlationGraph.setSelectedCriteria(chosenCriteria)!=-1){
        usedMode = MODE_CORRELATION;   
    }else{
      javax.swing.JOptionPane.showMessageDialog(null, "You have to select 2 criteria");
    }
    
}
