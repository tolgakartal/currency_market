import 'package:currency_market/transaction/data/model/transaction.dart';
import 'package:currency_market/transaction/data/repository/transactions_repository.dart';
import 'package:currency_market/transaction/state/table_sort_state.dart';
import 'package:flutter/foundation.dart';

enum TransactionType { spot, future, all }

enum SortColumn { symbol, lastPrice, volume }

const String spotTypeKey = 'SPOT';
const String futureTypeKey = 'FUTURES';

/// Stores and notifies market data
class TransactionsState extends ChangeNotifier {
  /*
- All: Show both Spot and Futures data
- Spot: Only show Spot data
- Futures: Only show Futures data
  */

  TransactionsState.initial() {
    _currentData = TransactionsRepository.instance.getTransactions();
    _currentData.sort((a, b) => a.compareTo(b));
  }

  TransactionType _selectedTransactionType = TransactionType.all;
  TransactionType get transactionType => _selectedTransactionType;
  set transactionType(TransactionType newValue) {
    _selectedTransactionType = newValue;
    notifyListeners();
  }

  List<Transaction> getTransactions() {
    final transactions = TransactionsRepository.instance.getTransactions();
    transactions.sort((a, b) => a.compareTo(b));
    switch (transactionType) {
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

  List<Transaction> _currentData = [];
  List<Transaction> get currentData => _currentData;

  void switchDataSource(TransactionType transactionType) {
    switch (transactionType) {
      case TransactionType.all:
        _currentData = getTransactions();
        notifyListeners();
        break;
      case TransactionType.spot:
        _currentData = spotData;
        notifyListeners();
        break;
      case TransactionType.future:
        _currentData = futuresData;
        notifyListeners();
        break;
      default:
    }
  }

  void sortBySymbol(SortType sortType) {
    if (sortType == SortType.descending) {
      currentData.sort((a, b) => (b.base! + b.quote! + b.type!)
          .compareTo((a.base! + a.quote! + a.type!)));
    } else {
      currentData.sort((a, b) => (a.base! + a.quote! + a.type!)
          .compareTo((b.base! + b.quote! + b.type!)));
    }

    notifyListeners();
  }

  void sortByLastPrice(SortType sortType) {
    if (sortType == SortType.descending) {
      currentData.sort((a, b) => b.lastPrice!.compareTo(a.lastPrice!));
    } else {
      currentData.sort((a, b) => a.lastPrice!.compareTo(b.lastPrice!));
    }

    notifyListeners();
  }

  void sortByVolume(SortType sortType) {
    if (sortType == SortType.descending) {
      currentData.sort((a, b) => b.volume!.compareTo(a.volume!));
    } else {
      currentData.sort((a, b) => a.volume!.compareTo(b.volume!));
    }

    notifyListeners();
  }
}
