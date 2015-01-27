class Country{
  String name;
  double population;
  double area;
  double birthrate;
  double deathrate;
  double current_account_balance;
  
  public Country(){

  }
  public Country(String _name, double _pop, double _area, double birthr, double deathr, double cab){
    name=_name;
    population = _pop;
    area = _area;
    birthrate = birthr;
    deathrate = deathr;
    current_account_balance = cab;
  }
 
}
