
class Stock {
  final String ticker;
  final double price;
  final bool isAnomalous;
  final double? previousPrice;

  Stock({
    required this.ticker,
    required this.price,
    this.isAnomalous = false,
    this.previousPrice,
  });

  Stock copyWith({
    double? price,
    bool? isAnomalous,
    double? previousPrice,
  }) {
    return Stock(
      ticker: ticker,
      price: price ?? this.price,
      isAnomalous: isAnomalous ?? this.isAnomalous,
      previousPrice: previousPrice ?? this.previousPrice,
    );
  }
}
