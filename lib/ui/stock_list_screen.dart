
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/stock_notifier.dart';
import '../state/connection_status.dart';
import 'stock_item.dart';
import 'connection_status_banner.dart';

class StockListScreen extends ConsumerWidget {
  const StockListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stocks = ref.watch(stockListProvider);
    final status = ref.watch(connectionStatusProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Unstable Ticker')),
      body: Column(
        children: [
          ConnectionStatusBanner(status: status),
          Expanded(
            child: ListView.builder(
              itemCount: stocks.length,
              itemBuilder: (context, index) => StockItem(stock: stocks[index]),
            ),
          ),
        ],
      ),
    );
  }
}
