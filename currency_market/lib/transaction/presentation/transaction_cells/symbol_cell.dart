import 'package:currency_market/transaction/data/model/transaction.dart';
import 'package:currency_market/transaction/presentation/transaction_cells/cell_container.dart';
import 'package:currency_market/transaction/state/transactions_state.dart';
import 'package:flutter/material.dart';

class SymbolCell extends StatelessWidget {
  const SymbolCell({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return CellContainer(
      transaction: transaction,
      child: Text(
        _resolveSymbol(),
      ),
    );
  }

  String _resolveSymbol() {
    switch (transaction.type) {
      case futureTypeKey:
        return '${transaction.base}-PERP';

      case spotTypeKey:
        return '${transaction.base}/${transaction.quote}';

      default:
        return '${transaction.base}/${transaction.quote}';
    }
  }
}
