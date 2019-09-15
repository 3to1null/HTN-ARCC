List<Map<String, String>> _currencies = [
    {'short': 'USD', 'long': 'United States Dollar', 'symbol': '\$', 'flag': 'https://www.countryflags.io/us/flat/64.png'},
    {'short': 'CAD', 'long': 'Canadian Dollar', 'symbol': '\$', 'flag': 'https://www.countryflags.io/ca/flat/64.png'},
    {'short': 'EUR', 'long': 'Euro', 'symbol': '€', 'flag': 'https://www.countryflags.io/eu/flat/64.png'},
  ];


List<Map<String, String>> getCurrenciesAsync(){
  //todo api
  return _currencies;
}

List<Map<String, String>> getCurrenciesSync(){
  return _currencies;
}

String formatMoney(String c2, double a){
  for(Map<String, String> currency in getCurrenciesSync()){
    if(currency['short'] == c2){
      if(currency['symbol'] != null){
        return currency['symbol'] + a.toStringAsFixed(2);
      }
      return a.toStringAsFixed(2) + currency['short'];
    }
  }
  return null;
}