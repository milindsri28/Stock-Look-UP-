import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/stock_model.dart';

class StockApi {
  final String baseUrl = 'https://finnhub.io/api/v1/quote';
  final String apiKey = 'crvucf1r01qrbtrl52hgcrvucf1r01qrbtrl52i0';

  Future<Stock?> fetchStock(String symbol) async {
    final url = Uri.parse('$baseUrl?symbol=$symbol&token=$apiKey');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return Stock.fromJson(
            jsonResponse); // Assuming Stock model maps the response
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching stock data: $e');
      return null;
    }
  }
}
