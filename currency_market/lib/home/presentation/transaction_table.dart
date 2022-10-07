import 'package:currency_market/home/model/market_data.dart';
import 'package:currency_market/home/state/market_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionTable extends StatelessWidget {
  const TransactionTable({
    Key? key,
    required this.marketDataType,
  }) : super(key: key);
  final MarketDataType marketDataType;

  @override
  Widget build(BuildContext context) {
    final marketDataProvider = context.watch<MarketState>();
    marketDataProvider.selectedMarketDataType = marketDataType;

    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        // Symbol
        0: FixedColumnWidth(120),
        // Last price column width
        3: IntrinsicColumnWidth(),
        // Volume column width
        4: FlexColumnWidth(),
      },
      children: [
        // Table rows - and cells
        for (var transaction in marketDataProvider.getMarketData())
          TableRow(
            children: [
              TableCell(
                child: Container(
                  color:
                      transaction.type! == 'SPOT' ? Colors.amber : Colors.green,
                  child: Text(
                    _resolveSymbol(transaction),
                  ),
                ),
              ),
              TableCell(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '\$${transaction.lastPrice?.toStringAsFixed(2) ?? "0"}',
                  ),
                ),
              ),
              TableCell(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    NumberFormat.compactCurrency(symbol: '\$')
                        .format(transaction.volume),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  String _resolveSymbol(Transaction transaction) {
    switch (transaction.type) {
      case 'FUTURES':
        return '${transaction.base}-PERP';

      case 'SPOT':
        return '${transaction.base}/${transaction.quote}';

      default:
        return '${transaction.base}/${transaction.quote}';
    }
  }
}

class TransactionTableHeader extends StatefulWidget {
  const TransactionTableHeader({Key? key}) : super(key: key);

  @override
  State<TransactionTableHeader> createState() => _TransactionTableHeaderState();
}

class _TransactionTableHeaderState extends State<TransactionTableHeader> {
  IconData defaultSortSymbol = Icons.arrow_downward;
  IconData defaultSortLastPrice = Icons.arrow_downward;
  IconData defaultSortVolume = Icons.arrow_downward;
  Color sortSymbolColor = Colors.white;
  Color sortLastPriceColor = Colors.white;
  Color sortVolumeColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final marketDataProvider = context.watch<MarketState>();

    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        // Symbol
        0: FixedColumnWidth(120),
        // Last price column width
        3: IntrinsicColumnWidth(),
        // Volume column width
        4: FlexColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            SizedBox(
              child: TableCell(
                child: Container(
                  color: sortSymbolColor,
                  child: IconButton(
                    alignment: Alignment.center,
                    iconSize: 20,
                    icon: Icon(defaultSortSymbol),
                    onPressed: () {
                      setState(
                        () {
                          sortSymbolColor = Colors.amber;
                          sortVolumeColor = Colors.white;
                          sortLastPriceColor = Colors.white;

                          if (defaultSortSymbol == Icons.arrow_downward) {
                            defaultSortSymbol = Icons.arrow_upward;
                            defaultSortLastPrice = Icons.arrow_downward;
                            defaultSortVolume = Icons.arrow_downward;
                          } else {
                            defaultSortSymbol = Icons.arrow_downward;
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                color: sortLastPriceColor,
                child: IconButton(
                  alignment: Alignment.center,
                  iconSize: 20,
                  icon: Icon(defaultSortLastPrice),
                  onPressed: () {
                    setState(
                      () {
                        sortLastPriceColor = Colors.amber;
                        sortVolumeColor = Colors.white;
                        sortSymbolColor = Colors.white;
                        if (defaultSortLastPrice == Icons.arrow_downward) {
                          defaultSortLastPrice = Icons.arrow_upward;
                          defaultSortSymbol = Icons.arrow_downward;
                          defaultSortVolume = Icons.arrow_downward;
                        } else {
                          defaultSortLastPrice = Icons.arrow_downward;
                        }
                      },
                    );
                  },
                ),
              ),
            ),
            TableCell(
              child: Container(
                color: sortVolumeColor,
                child: IconButton(
                  alignment: Alignment.center,
                  iconSize: 20,
                  icon: Icon(defaultSortVolume),
                  onPressed: () {
                    setState(
                      () {
                        sortVolumeColor = Colors.amber;
                        sortLastPriceColor = Colors.white;
                        sortSymbolColor = Colors.white;
                        if (defaultSortVolume == Icons.arrow_downward) {
                          defaultSortVolume = Icons.arrow_upward;
                          defaultSortLastPrice = Icons.arrow_downward;
                          defaultSortSymbol = Icons.arrow_downward;
                        } else {
                          defaultSortVolume = Icons.arrow_downward;
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
