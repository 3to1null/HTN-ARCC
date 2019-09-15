import 'package:http/http.dart' as http;
import 'dart:convert';

List<Map<String, String>> _currencies = [
    {'short': 'USD', 'long': 'United States Dollar', 'symbol': '\$', 'flag': 'https://www.countryflags.io/us/flat/64.png'},
    {'short': 'CAD', 'long': 'Canadian Dollar', 'symbol': '\$', 'flag': 'https://www.countryflags.io/ca/flat/64.png'},
    {'short': 'EUR', 'long': 'Euro', 'symbol': '€', 'flag': 'https://www.countryflags.io/eu/flat/64.png'},
  ];


Future<List<Map<String, String>>> getCurrenciesAsync() async {
  var url = "http://10.33.133.205:5000/api/currencies";
  var response = await http.get(url);
  _currencies = json.decode(response.body);
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