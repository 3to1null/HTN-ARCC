import '../countries.dart';
import '../country.dart';
import 'package:flutter/widgets.dart';

class CountryPickerUtils {
  static Country getCountryByShortCode(String short) {
    try {
      return countryList.firstWhere(
        (country) => country.short.toLowerCase() == short.toLowerCase(),
      );
    } catch (error) {
      throw Exception("The initialValue provided is not a supported iso code!");
    }
  }


  static Widget getDefaultFlagImage(Country country) {
    return Image.network(
      country.flag,
      height: 20.0,
      width: 30.0,
      fit: BoxFit.fill,
    );
  }
}
