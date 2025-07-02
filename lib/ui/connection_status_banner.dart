
import 'package:flutter/material.dart';

class ConnectionStatusBanner extends StatelessWidget {
  final String status;

  const ConnectionStatusBanner({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      color: status == 'Connected'
          ? Colors.green
          : status == 'Connecting'
              ? Colors.yellow
              : Colors.red,
      child: Text(status, style: const TextStyle(color: Colors.white)),
    );
  }
}
