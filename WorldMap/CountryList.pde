int    COUNTRY_LIST_LEFT                 = 1077;
int    COUNTRY_LIST_TOP                  = 27;
int    COUNTRY_LIST_WIDTH                = 280;
int    COUNTRY_LIST_HEIGHT               = 350;
color  COUNTRY_LIST_BACKGROUND           = color(94,38,18,255);//color(51,102,153,255);//(24,116,205, 255);
color  COUNTRY_LIST_FOREGROUND           = color(205,55,0,255);//color(0,154,205,255);//(16,78,139, 255);//color(255, 100, 0, 255);
int    COUNTRY_LIST_ITEM_HEIGHT          = 20;
int    COUNTRY_LIST_BAR_HEIGHT           = 20;

int    CHOSEN_COUNTRY_LIST_LEFT          = 500;
int    CHOSEN_COUNTRY_LIST_TOP           = 650;
int    CHOSEN_COUNTRY_LIST_WIDTH         = 280;
int    CHOSEN_COUNTRY_LIST_HEIGHT        = 120;
color  CHOSEN_COUNTRY_LIST_BACKGROUND    = color(94,38,18,255);//color(139,37,0,255);//color(51,102,153,255);
color  CHOSEN_COUNTRY_LIST_FOREGROUND    = color(205,55,0,255);//color(0,154,205,255);
int    CHOSEN_COUNTRY_LIST_ITEM_HEIGHT   = 20;
int    CHOSEN_COUNTRY_LIST_BAR_HEIGHT    = 20;


ListBox countryList;
ListBox chosenCountryList;

public java.util.Map chosenCountryItemHandleMap = new HashMap();
int chosenCountryItemHandle = 0;

void initializeCountryList()
{
    countryList = controlP5.addListBox("countryList")
                           .setPosition(COUNTRY_LIST_LEFT, COUNTRY_LIST_TOP)
                           .setSize(COUNTRY_LIST_WIDTH, COUNTRY_LIST_HEIGHT)
                           .setItemHeight(COUNTRY_LIST_ITEM_HEIGHT)
                           .setBarHeight(COUNTRY_LIST_BAR_HEIGHT)
                           .setColorBackground(COUNTRY_LIST_BACKGROUND)
                           .setColorActive(color(0))
                           .setColorForeground(COUNTRY_LIST_FOREGROUND);
    
    countryList.captionLabel().toUpperCase(true);
    countryList.captionLabel().set("List of countries");
    countryList.captionLabel().style().marginTop = 3;
    countryList.valueLabel().style().marginTop = 3;
    
    int i = 0;
    for (Country country: map.countries) {
        ListBoxItem lbi = countryList.addItem(country.name, i++);
        lbi.setColorBackground(COUNTRY_LIST_BACKGROUND);
    }
    
    chosenCountryList = controlP5.addListBox("chosenCountryList")
                           .setPosition(CHOSEN_COUNTRY_LIST_LEFT, CHOSEN_COUNTRY_LIST_TOP)
                           .setSize(CHOSEN_COUNTRY_LIST_WIDTH, CHOSEN_COUNTRY_LIST_HEIGHT)
                           .setItemHeight(CHOSEN_COUNTRY_LIST_ITEM_HEIGHT)
                           .setBarHeight(CHOSEN_COUNTRY_LIST_BAR_HEIGHT)
                           .setColorBackground(CHOSEN_COUNTRY_LIST_BACKGROUND)
                           .setColorActive(color(0))
                           .setColorForeground(CHOSEN_COUNTRY_LIST_FOREGROUND);
    
    chosenCountryList.captionLabel().toUpperCase(true);
    chosenCountryList.captionLabel().set("Chosen countries");
    chosenCountryList.captionLabel().style().marginTop = 3;
    chosenCountryList.valueLabel().style().marginTop = 3;
}

void chooseCountryToList(String name)
{
    String[][] listboxItemNames = chosenCountryList.getListBoxItems();
    int numOfAvailableItemNames = listboxItemNames.length;
    boolean isNameAvailable = false;
    for(int i = 0; i < listboxItemNames.length; ++i)
        if(listboxItemNames[i][0].equals(name))
        {
            isNameAvailable = true;
            break;
        }
    
    if(!isNameAvailable)
    {
        ListBoxItem item = chosenCountryList.addItem(name, chosenCountryItemHandle);
        item.setColorBackground(CHOSEN_COUNTRY_LIST_BACKGROUND);
        chosenCountryItemHandleMap.put(chosenCountryItemHandle, name);
        ++chosenCountryItemHandle;
        chosenCountryList.updateListBoxItems();
    }
    
    System.out.println("Added " + chosenCountryList.getListBoxItems().length);
}

void countryListControlEvent(ControlEvent event){
    String itemName = countryList.getItem((int)event.value()).getText();
    chooseCountryToList(itemName);
}

void chosenCountryListControlEvent(ControlEvent event){
    String itemName = (String)chosenCountryItemHandleMap.get((int)event.value());
    if(usedMode == MODE_COMBI)
    {
        if(combi.graphnum == 0)
            combi.tables.search_name(itemName);
    }
    else
    {
        chosenCountryList.removeItem(itemName);
        chosenCountryList.updateListBoxItems();
    }
}
