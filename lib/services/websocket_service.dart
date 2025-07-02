
import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../models/stock.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  final _controller = StreamController<List<Stock>>.broadcast();
  final _statusController = StreamController<String>.broadcast();
  Timer? _reconnectTimer;
  int _retrySeconds = 2;

  Stream<List<Stock>> get stockStream => _controller.stream;
  Stream<String> get statusStream => _statusController.stream;

  void connect() {
    _statusController.add('Connecting');
     _channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8080/ws'));

    _statusController.add('Connected');

    _channel!.stream.listen((data) {
      try {
        final List<dynamic> decoded = jsonDecode(data);
        final stocks = decoded.map((e) {
          return Stock(
            ticker: e['ticker'],
            price: double.parse(e['price']),
          );
        }).toList();
        _controller.add(stocks);
      } catch (_) {
        // malformed data, ignore
      }
    }, onDone: _scheduleReconnect, onError: (_) => _scheduleReconnect());
  }

  void _scheduleReconnect() {
    _statusController.add('Reconnecting');
    _reconnectTimer = Timer(Duration(seconds: _retrySeconds), () {
      _retrySeconds = (_retrySeconds * 2).clamp(2, 30);
      connect();
    });
  }

  void dispose() {
    _channel?.sink.close();
    _controller.close();
    _statusController.close();
    _reconnectTimer?.cancel();
  }
}
