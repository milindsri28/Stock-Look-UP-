import 'package:flutter/material.dart';
import '../viewmodels/stock_viewmodel.dart';
import '../models/stock_model.dart';

class StockLookupScreen extends StatefulWidget {
  const StockLookupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StockLookupScreenState createState() => _StockLookupScreenState();
}

class _StockLookupScreenState extends State<StockLookupScreen> {
  final TextEditingController _controller = TextEditingController();
  StockViewModel stockViewModel = StockViewModel();
  Stock? stock;
  bool isLoading = false;
  String? errorMessage;

  void _searchStock() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    final symbol = _controller.text.toUpperCase();
    stock = await stockViewModel.fetchStock(symbol);
    setState(() {
      isLoading = false;
      if (stock == null) {
        errorMessage = 'Could not find stock for $symbol';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Lookup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Stock Symbol',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchStock,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (isLoading) const CircularProgressIndicator(),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            if (stock != null) ...[
              Text(
                'Stock Symbol: ${_controller.text.toUpperCase()}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Current Price: \$${stock!.currentPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'High Price: \$${stock!.highPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Low Price: \$${stock!.lowPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Open Price: \$${stock!.openPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Previous Close: \$${stock!.previousClose.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
