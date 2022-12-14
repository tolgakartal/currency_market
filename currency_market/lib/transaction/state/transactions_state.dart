import 'package:currency_market/transaction/data/model/transaction.dart';
import 'package:currency_market/transaction/data/repository/transactions_repository.dart';
import 'package:currency_market/transaction/state/table_sort_state.dart';
import 'package:flutter/foundation.dart';
import 'package:fuzzy/fuzzy.dart';

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
  String _searchText;
  List<Transaction> _currentData = [];

  TransactionsState.initial() : _searchText = '' {
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

  /// Determines the sort behaviour of the symbol column
  ///
  /// Rule for sorting by Symbol: {base} + {quote} + {type}
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

  void searchTextChanged(String newText) {
    List<Transaction> transactionsToSearch = [];
    if (newText.isEmpty) {
      // When user text is empty then return all the transactions
      final searchResults = getTransactions();
      _currentData = searchResults;
      notifyListeners();
      return;
    }
    // When user text is longer than the previous search text
    transactionsToSearch = getTransactions();
    final Fuzzy<String?> fuzzyWrapper = Fuzzy(
      transactionsToSearch.map((e) => e.base).toList(),
      options: FuzzyOptions(
        findAllMatches: true,
        tokenize: true,
        threshold: 0.5,
      ),
    );

    _searchText = newText;

    // Make the fuzzy search
    final searchResult = fuzzyWrapper.search(_searchText);

    // Find out all transactions that intersect
    // with the fuzzy search results of the
    // base field of the transaction
    _currentData = _resolveFuzzyIntersection(
      baseSearchResults: searchResult.map((e) => e.item).toList(),
      transactions: transactionsToSearch,
    );

    notifyListeners();
  }

  List<Transaction> _resolveFuzzyIntersection({
    required List<String?> baseSearchResults,
    required List<Transaction> transactions,
  }) {
    transactions.removeWhere((item) => !baseSearchResults.contains(item.base));
    return transactions;
  }
}
