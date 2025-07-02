
import 'package:flutter/material.dart';
import '../models/stock.dart';

class StockItem extends StatelessWidget {
  final Stock stock;

  const StockItem({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final priceColor = stock.previousPrice == null
        ? Colors.black
        : stock.price > stock.previousPrice!
            ? Colors.green
            : stock.price < stock.previousPrice!
                ? Colors.red
                : Colors.black;

    return ListTile(
      //tileColor: Colors.indigo,
      title: Text(stock.ticker),
      subtitle: Text(
        stock.price.toStringAsFixed(2),
        style: TextStyle(color: priceColor, fontWeight: FontWeight.bold),
      ),
      trailing: stock.isAnomalous
          ? const Icon(Icons.warning, color: Colors.orange)
          : null,
    );
  }
}
