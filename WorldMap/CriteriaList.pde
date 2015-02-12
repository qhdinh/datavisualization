int    CRITERIA_LIST_LEFT                 = 1077;
int    CRITERIA_LIST_TOP                  = 395;
int    CRITERIA_LIST_WIDTH                = 280;
int    CRITERIA_LIST_HEIGHT               = 350;
color  CRITERIA_LIST_BACKGROUND           = color(40,40,40,255);//color(0,139,69,255);//(46,139,87, 255);
color  CRITERIA_LIST_FOREGROUND           = color(205,55,0,255);//color(92,64,51,255);//color(60,179,113,255);//(92,64,51,255);//(255, 100, 0, 255);
int    CRITERIA_LIST_ITEM_HEIGHT          = 20;
int    CRITERIA_LIST_BAR_HEIGHT           = 20;

int    CHOSEN_CRITERIA_LIST_LEFT          = 790;
int    CHOSEN_CRITERIA_LIST_TOP           = 650;
int    CHOSEN_CRITERIA_LIST_WIDTH         = 280;
int    CHOSEN_CRITERIA_LIST_HEIGHT        = 120;
color  CHOSEN_CRITERIA_LIST_BACKGROUND    = color(40,40,40,255);//color(92,64,51,255);//color(0,139,69,255);
color  CHOSEN_CRITERIA_LIST_FOREGROUND    = color(205,55,0,255);//color(92,64,51,255);//color(133,94,66,255);//color(60,179,113,255);
int    CHOSEN_CRITERIA_LIST_ITEM_HEIGHT   = 20;
int    CHOSEN_CRITERIA_LIST_BAR_HEIGHT    = 20;

ListBox criteriaList;
ListBox chosenCriteriaList;

public java.util.Map chosenCriteriaItemHandleMap = new HashMap();
int chosenCriteriaItemHandle = 0;

void initializeCriteriaList()
{
    criteriaList = controlP5.addListBox("criteriaList")
                           .setPosition(CRITERIA_LIST_LEFT, CRITERIA_LIST_TOP)
                           .setSize(CRITERIA_LIST_WIDTH, CRITERIA_LIST_HEIGHT)
                           .setItemHeight(CRITERIA_LIST_ITEM_HEIGHT)
                           .setBarHeight(CRITERIA_LIST_BAR_HEIGHT)
                           .setColorBackground(CRITERIA_LIST_BACKGROUND)
                           .setColorActive(color(0))
                           .setColorForeground(CRITERIA_LIST_FOREGROUND);
    
    criteriaList.captionLabel().toUpperCase(true);
    criteriaList.captionLabel().set("List of Criteria");
    criteriaList.captionLabel().style().marginTop = 3;
    criteriaList.valueLabel().style().marginTop = 3;
    
    for (int i = 1; i < countryFields.length - 1; ++i) {
        ListBoxItem lbi = criteriaList.addItem(countryFields[i], i - 1);
        lbi.setColorBackground(CRITERIA_LIST_BACKGROUND);
    }
    
    chosenCriteriaList = controlP5.addListBox("chosenCriteriaList")
                           .setPosition(CHOSEN_CRITERIA_LIST_LEFT, CHOSEN_CRITERIA_LIST_TOP)
                           .setSize(CHOSEN_CRITERIA_LIST_WIDTH, CHOSEN_CRITERIA_LIST_HEIGHT)
                           .setItemHeight(CHOSEN_CRITERIA_LIST_ITEM_HEIGHT)
                           .setBarHeight(CHOSEN_CRITERIA_LIST_BAR_HEIGHT)
                           .setColorBackground(CHOSEN_CRITERIA_LIST_BACKGROUND)
                           .setColorActive(color(0))
                           .setColorForeground(CHOSEN_CRITERIA_LIST_FOREGROUND)
                           ;
    
    chosenCriteriaList.captionLabel().toUpperCase(true);
    chosenCriteriaList.captionLabel().set("Chosen criteria");
    chosenCriteriaList.captionLabel().style().marginTop = 3;
    chosenCriteriaList.valueLabel().style().marginTop = 3;
}

void criteriaListControlEvent(ControlEvent event){
    String[][] listboxItemNames = chosenCriteriaList.getListBoxItems();
    int numOfAvailableItemNames = listboxItemNames.length;
    
    String itemName = criteriaList.getItem((int)event.value()).getText();
    boolean isNameAvailable = false;
    for(int i = 0; i < listboxItemNames.length; ++i)
        if(listboxItemNames[i][0].equals(itemName))
        {
            isNameAvailable = true;
            break;
        }
    
    if(!isNameAvailable)
    {
        ListBoxItem item = chosenCriteriaList.addItem(itemName, chosenCriteriaItemHandle);
        item.setColorBackground(CHOSEN_CRITERIA_LIST_BACKGROUND);
        chosenCriteriaItemHandleMap.put(chosenCriteriaItemHandle, itemName);
        ++chosenCriteriaItemHandle;
        chosenCriteriaList.updateListBoxItems();
    }
}

void chosenCriteriaListControlEvent(ControlEvent event){
    String itemName = (String)chosenCriteriaItemHandleMap.get((int)event.value());
    chosenCriteriaList.removeItem(itemName);
    chosenCriteriaList.updateListBoxItems();
}
