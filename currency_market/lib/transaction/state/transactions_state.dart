import 'package:currency_market/transaction/data/model/transaction.dart';
import 'package:currency_market/transaction/data/repository/transactions_repository.dart';
import 'package:flutter/foundation.dart';

enum TransactionType { spot, future, all }

enum SortType { symbol, lastPrice, volume }

const String spotTypeKey = 'SPOT';
const String futureTypeKey = 'FUTURES';

/// Stores and notifies market data
class TransactionsState extends ChangeNotifier {
  /*
- All: Show both Spot and Futures data
- Spot: Only show Spot data
- Futures: Only show Futures data
  */

  TransactionType _selectedTransactionType = TransactionType.all;
  TransactionType get selectedMarketDataType => _selectedTransactionType;
  set selectedMarketDataType(TransactionType newValue) {
    _selectedTransactionType = newValue;
    notifyListeners();
  }

  List<Transaction> getTransactions() {
    final transactions = TransactionsRepository.instance.getTransactions();
    transactions.sort((a, b) => a.compareTo(b));
    switch (selectedMarketDataType) {
      case TransactionType.all:
        return transactions;
      case TransactionType.spot:
        return spotData;
      case TransactionType.future:
        return futuresData;
      default:
    }
    return transactions.where((element) => element.type == 'SPOT').toList();
  }

  List<Transaction> get spotData => TransactionsRepository.instance
      .getTransactions()
      .where((element) => element.type == 'SPOT')
      .toList();

  List<Transaction> get futuresData => TransactionsRepository.instance
      .getTransactions()
      .where((element) => element.type == 'FUTURES')
      .toList();
}
