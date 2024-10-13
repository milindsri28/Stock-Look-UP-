import '../services/stock_api.dart';
import '../models/stock_model.dart';

class StockViewModel {
  final StockApi _stockApi = StockApi();

  Future<Stock?> fetchStock(String symbol) {
    return _stockApi.fetchStock(symbol);
  }
}
