import 'package:http/http.dart' as http;

Map<String, Map<String, double>> rates;
bool _isGettingRates;

Future<double> updateConversionRates(String c1, String c2) async {
  _isGettingRates = true;
  var url = "http://10.33.133.205:5000/api/convert?c1=$c1&c2=$c2&a=1";
  var response = await http.get(url);

  if(rates.containsKey(c1)){
    rates[c1][c2] = double.parse(response.body);
  }else{
    rates[c1] = {c2: double.parse(response.body)};
  }
  _isGettingRates = false;
}

double calculateConverted(String c1, String c2, num a){
  
  return a * 1.3;

  if(rates.containsKey(c1) && rates[c1].containsKey(c2)){
    return a * rates[c1][c2];
  }else if(!_isGettingRates){
    updateConversionRates(c1, c2);
  }
  return null;
}