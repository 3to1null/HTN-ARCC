class Country {
  final String long;
  final String short;
  final String flag;
  final String symbol;
  Country({this.long, this.short, this.flag, this.symbol});

  factory Country.fromMap(Map<String, String> map) => Country(
        long: map['long'],
        short: map['short'],
        flag: map['flag'],
        symbol: map['symbol'],
      );
}
