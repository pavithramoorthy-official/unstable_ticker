
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unstable_ticker/state/stock_notifier.dart';
import '../repository/stock_repository.dart';

class ConnectionStatusNotifier extends StateNotifier<String> {
  final StockRepository repository;

  ConnectionStatusNotifier(this.repository) : super('Connecting') {
    repository.getStatusStream().listen((status) {
      state = status;
    });
  }
}

final connectionStatusProvider =
    StateNotifierProvider<ConnectionStatusNotifier, String>((ref) {
  final repository = ref.read(stockRepositoryProvider);
  return ConnectionStatusNotifier(repository);
});
