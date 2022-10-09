import 'package:currency_market/transaction/data/model/transaction.dart';

class TransactionsRepository {
  TransactionsRepository._();

  static final instance = TransactionsRepository._();

  List<Transaction> getTransactions() {
    return _mockMarketData;
  }
}

final _mockMarketData = [
  Transaction(
    base: 'BTC',
    quote: 'USDT',
    type: 'SPOT',
    lastPrice: 43899.92,
    volume: 246944876.72997272,
  ),
  Transaction(
    base: 'ETH',
    quote: 'USDT',
    type: 'SPOT',
    lastPrice: 3132.67,
    volume: 177111682.0831828,
  ),
  Transaction(
    base: 'DODO',
    quote: 'USDT',
    type: 'SPOT',
    lastPrice: 0.601,
    volume: 2406.8213148,
  ),
  Transaction(
    base: 'USDC',
    quote: 'USDT',
    type: 'SPOT',
    lastPrice: 0.9993,
    volume: 146155.347837,
  ),
  Transaction(
    base: 'SHIB',
    quote: 'USDT',
    type: 'SPOT',
    lastPrice: 0.00003288,
    volume: 5848644.59795569,
  ),
  Transaction(
    base: 'DOGE',
    quote: 'USDT',
    type: 'SPOT',
    lastPrice: 0.164544,
    volume: 8114501.025757,
  ),
  Transaction(
    base: 'NEAR',
    quote: 'USDT',
    type: 'SPOT',
    lastPrice: 13.501,
    volume: 1448972.921938,
  ),
  Transaction(
    base: 'OKB',
    quote: 'USDT',
    type: 'SPOT',
    lastPrice: 22.973,
    volume: 5128.2330661,
  ),
  Transaction(
    base: 'WOO',
    quote: 'USDT',
    type: 'SPOT',
    lastPrice: 0.80146,
    volume: 6099463.5366493,
  ),
  Transaction(
    base: 'XRP',
    quote: 'USDT',
    type: 'SPOT',
    lastPrice: 0.8633,
    volume: 10964532.135953,
  ),
  Transaction(
    base: 'DYDX',
    quote: 'USDT',
    type: 'SPOT',
    lastPrice: 8.179,
    volume: 366540.0043351,
  ),
  Transaction(
    base: 'AURORA',
    quote: 'USDT',
    type: 'SPOT',
    lastPrice: 14.213,
    volume: 4436.1874587,
  ),
  Transaction(
    base: 'ATOM',
    quote: 'USDT',
    type: 'SPOT',
    lastPrice: 31.832,
    volume: 3038527.85901,
  ),
  Transaction(
    base: 'LINK',
    quote: 'USDT',
    type: 'SPOT',
    lastPrice: 18.825,
    volume: 3268539.039502,
  ),
  Transaction(
    base: 'SUSHI',
    quote: 'USDT',
    type: 'SPOT',
    lastPrice: 4.8646,
    volume: 774147.137607,
  ),
  Transaction(
    base: 'QRDO',
    quote: 'USDT',
    type: 'SPOT',
    lastPrice: 3.67602,
    volume: 107119.72425381,
  ),
  Transaction(
    base: 'BTC',
    quote: 'USDC',
    type: 'SPOT',
    lastPrice: 43210.53,
    volume: 4682391.712736,
  ),
  Transaction(
    base: 'ETH',
    quote: 'USDC',
    type: 'SPOT',
    lastPrice: 3456.78,
    volume: 72342.81923,
  ),
  Transaction(
    base: 'BSV',
    quote: 'USDC',
    type: 'SPOT',
    lastPrice: 102.78,
    volume: 129837.32864,
  ),
  Transaction(
    base: 'BTC',
    quote: 'USDT',
    type: 'FUTURES',
    lastPrice: 44409,
    volume: 67823641,
  ),
  Transaction(
    base: 'ETH',
    quote: 'USDT',
    type: 'FUTURES',
    lastPrice: 3333.00,
    volume: 67823642,
  ),
];
