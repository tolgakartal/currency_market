class Transaction extends Comparable<Transaction> {
  final String? base;
  final String? quote;
  final String? type;
  final double? lastPrice;
  final double? volume;

  Transaction({
    required this.base,
    required this.quote,
    required this.type,
    required this.lastPrice,
    required this.volume,
  });

  Transaction.fromJson(
    Map<String, dynamic> json,
  )   : base = json['base'],
        quote = json['quote'],
        type = json['type'],
        lastPrice = json['lastPrice'],
        volume = json['volume'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base'] = base;
    data['quote'] = quote;
    data['type'] = type;
    data['lastPrice'] = lastPrice;
    data['volume'] = volume;
    return data;
  }

  @override
  int compareTo(other) {
    final otherVal = _sortPriorityValue(other.base);
    final currentVal = _sortPriorityValue(base);
    final otherQuote = _sortQuoteValue(other);
    final currentQuote = _sortQuoteValue(this);

    return (otherVal + otherQuote) - (currentVal + currentQuote);
  }

  int _sortPriorityValue(String? val) {
    if (val == null) {
      return 0;
    } else if (val == 'BTC') {
      return 40;
    } else if (val == 'ETH') {
      return 30;
    } else if (val == 'WOO') {
      return 20;
    } else {
      return 10;
    }
  }

  int _sortQuoteValue(Transaction? val) {
    if (val == null) {
      return 0;
    }
    if (val.quote == 'USDT') {
      return 3;
    } else if (val.quote == 'USDC') {
      return 2;
    } else if (val.type == 'FUTURES') {
      return 1;
    } else {
      return 0;
    }
  }
}
