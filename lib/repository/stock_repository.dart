
import '../models/stock.dart';
import '../services/websocket_service.dart';
import '../utils/anomaly_detector.dart';

class StockRepository {
  final WebSocketService _service = WebSocketService();
  final Map<String, double> _lastValidPrices = {};

  Stream<List<Stock>> getStocksStream() {
    return _service.stockStream.map((stocks) {
      return stocks.map((stock) {
        final lastPrice = _lastValidPrices[stock.ticker];
        final isAnomalous = lastPrice != null &&
            AnomalyDetector.isAnomalous(lastPrice, stock.price);
        if (!isAnomalous) {
          _lastValidPrices[stock.ticker] = stock.price;
          return stock.copyWith(previousPrice: lastPrice);
        } else {
          return Stock(
            ticker: stock.ticker,
            price: lastPrice ?? stock.price,
            isAnomalous: true,
            previousPrice: lastPrice,
          );
        }
      }).toList();
    });
  }

  Stream<String> getStatusStream() => _service.statusStream;
  void connect() => _service.connect();
  void dispose() => _service.dispose();
}
