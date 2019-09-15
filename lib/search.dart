import 'package:flutter/material.dart';

import 'search/country_picker_dialog.dart';
import 'search/country.dart';
import 'search/countries.dart';
import 'search/utils/utils.dart';

import 'functions/conversion_rates.dart';

Map<String, Country> selectedCountriesShared = {'c1': countryList[0], 'c2': countryList[1]};


  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Text(country.short),
          SizedBox(width: 8.0),
          Flexible(child: Text(country.long))
        ],
      );

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20.0, right: 20.0, top: 60.0, height: 50.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          color: Colors.black54
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CurrencyPicker(true),
            Icon(Icons.keyboard_arrow_right, color: Colors.white,),
            CurrencyPicker(false)
          ],
        ),
      ),
    );
  }
}

class CurrencyPicker extends StatefulWidget {
  @override
  _CurrencyPickerState createState() => _CurrencyPickerState();

  final bool isC1;
  CurrencyPicker(this.isC1);
}

class _CurrencyPickerState extends State<CurrencyPicker> {
  Map<String, Country> selectedCountries = selectedCountriesShared;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: <Widget>[
          Image(image: NetworkImage(selectedCountries[widget.isC1 ? 'c1' : 'c2'].flag)),
          Icon(Icons.arrow_drop_down, color: Colors.white,)
        ],
      ),
      onTap: (){
        showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: CountryPickerDialog(
                titlePadding: EdgeInsets.all(8.0),
                searchCursorColor: Colors.pinkAccent,
                searchInputDecoration: InputDecoration(hintText: 'Search...'),
                isSearchable: true,
                title: Text( widget.isC1 ? 'Select input currency' : 'Select output currency'),
                onValuePicked: (Country country){
                  selectedCountriesShared[widget.isC1 ? 'c1' : 'c2'] = country;
                  setState(() {
                    selectedCountries = selectedCountriesShared;
                  });
                  updateConversionRates(selectedCountriesShared['c1'].short, selectedCountriesShared['c2'].short);
                },
                itemBuilder: _buildDialogItem)),
      );
      },
    );
  }
}