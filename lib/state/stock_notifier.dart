
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/stock.dart';
import '../repository/stock_repository.dart';

final stockRepositoryProvider = Provider((ref) => StockRepository());

final stockListProvider = StateNotifierProvider<StockListNotifier, List<Stock>>((ref) {
  final repository = ref.read(stockRepositoryProvider);
  return StockListNotifier(repository);
});

class StockListNotifier extends StateNotifier<List<Stock>> {
  final StockRepository repository;

  StockListNotifier(this.repository) : super([]) {
    repository.getStocksStream().listen((stocks) {
      state = stocks;
    });
    repository.connect();
  }
}
