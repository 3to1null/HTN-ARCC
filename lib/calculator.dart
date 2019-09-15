import 'package:flutter/material.dart';
import 'search/country_picker_dialog.dart';
import 'search/country.dart';
import 'search/countries.dart';
import 'search/utils/utils.dart';
import 'charts.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

import 'functions/conversion_rates.dart';
import 'functions/currencies.dart';

Map<String, Country> selectedCountriesShared = {
  'c1': countryList[0],
  'c2': countryList[1]
};

Widget _buildDialogItem(Country country) => Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(width: 8.0),
        Text(country.short),
        SizedBox(width: 8.0),
        Flexible(child: Text(country.long))
      ],
    );

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final currencyStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20);
  final TextEditingController inputController = TextEditingController();
  final valueStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w200, fontSize: 50);
  Map<String, Country> selectedCountries = selectedCountriesShared;
  String c2 = "";

  int _value = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final _appBar = AppBar(
      backgroundColor: Colors.teal,
      centerTitle: true,
      title: Text(
        "Calculate Currency",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );

    final _cardShadow = <BoxShadow>[
      BoxShadow(
        color: Colors.black54,
        blurRadius: 5.0, // has the effect of softening the shadow
        spreadRadius: 0.08, // has the effect of extending the shadow
        offset: Offset(
          1.5, // horizontal, move right 10
          1.5, // vertical, move down 10
        ),
      )
    ];

    final _cardDeco = BoxDecoration(
      boxShadow: _cardShadow,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF00FF9C), Color(0xFF1CD0A2)],
      ),
    );

    return Scaffold(
      appBar: _appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: _cardDeco,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildCurrency1Widgets(),
                _buildArrowIcon(),
                _buildCurrency2Widgets(),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              _buildTimeScaleButtons(),

              RatesChart(),
            ],
          )
        ],
      ),
    );
  }

  _buildTimeScaleButtons() => Wrap(
        spacing: 20,
        children: [
          ChoiceChip(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            selectedColor: Color(0xFF1CD0A2),
            labelStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
            label: Text('DAY'),
            selected: _value == 0,
            onSelected: (bool selected) {
              setState(() {
                _value = selected ? 0 : null;
              });
            },
          ),
          ChoiceChip(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            selectedColor: Color(0xFF1CD0A2),
            labelStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
            label: Text('MON'),
            selected: _value == 1,
            onSelected: (bool selected) {
              setState(() {
                _value = selected ? 1 : null;
              });
            },
          ),
          ChoiceChip(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            selectedColor: Color(0xFF1CD0A2),
            labelStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
            label: Text('YEAR'),
            selected: _value == 2,
            onSelected: (bool selected) {
              setState(() {
                _value = selected ? 2 : null;
              });
            },
          ),
        ],
      );

  _buildInputField() => TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        controller: inputController,
        onChanged: (String amnt) {
          double newa = calculateConverted(selectedCountries['c1'].short, selectedCountries['c2'].short, double.parse(amnt));
          if(newa != null){
            setState(() {
              c2 = newa.toStringAsFixed(2);
            });
          }
        },
        decoration: InputDecoration(
          hintText: "00.00",
          hintStyle: valueStyle.copyWith(color: Colors.white.withOpacity(0.80)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                  style: BorderStyle.solid)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                  style: BorderStyle.solid)),
        ),
        style: valueStyle,
      );

  _buildCurrency1Widgets() => Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Theme(
                    data: Theme.of(context).copyWith(primaryColor: Colors.pink),
                    child: CountryPickerDialog(
                        titlePadding: EdgeInsets.all(8.0),
                        searchCursorColor: Color(0xFF1CD0A2),
                        searchInputDecoration:
                            InputDecoration(hintText: 'Search...'),
                        isSearchable: true,
                        title: Text('Select output currency'),
                        onValuePicked: (Country country) {
                          selectedCountriesShared['c1'] = country;
                          setState(() {
                            selectedCountries = selectedCountriesShared;
                            c2 = "";
                          });
                          updateConversionRates(
                              selectedCountriesShared['c1'].short,
                              selectedCountriesShared['c2'].short);
                        },
                        itemBuilder: _buildDialogItem)),
              );
            },
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    selectedCountries['c1'].short,
                    style: currencyStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white.withOpacity(.85),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 150,
            height: 70,
            child: _buildInputField(),
          ),
        ],
      );

  _buildCurrency2Widgets() => Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Theme(
                    data: Theme.of(context).copyWith(primaryColor: Colors.pink),
                    child: CountryPickerDialog(
                        titlePadding: EdgeInsets.all(8.0),
                        searchCursorColor: Color(0xFF1CD0A2),
                        searchInputDecoration:
                            InputDecoration(hintText: 'Search...'),
                        isSearchable: true,
                        title: Text('Select output currency'),
                        onValuePicked: (Country country) {
                          selectedCountriesShared['c2'] = country;
                          setState(() {
                            selectedCountries = selectedCountriesShared;
                            c2 = "";
                          });
                          updateConversionRates(
                              selectedCountriesShared['c1'].short,
                              selectedCountriesShared['c2'].short);
                        },
                        itemBuilder: _buildDialogItem)),
              );
            },
            child: Row(
              children: <Widget>[
                Text(
                  selectedCountries['c2'].short,
                  style: currencyStyle,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white.withOpacity(.85),
                  ),
                ),
              ],
            ),
          ),
          Text(
            c2,
            style: valueStyle,
          )
        ],
      );

  _buildArrowIcon() => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
          size: 30,
        ),
      );
}
