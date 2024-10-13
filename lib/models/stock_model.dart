class Stock {
  final double currentPrice;
  final double highPrice;
  final double lowPrice;
  final double openPrice;
  final double previousClose;

  Stock({
    required this.currentPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.openPrice,
    required this.previousClose,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      currentPrice: json['c'],
      highPrice: json['h'],
      lowPrice: json['l'],
      openPrice: json['o'],
      previousClose: json['pc'],
    );
  }
}
