import 'package:currency_market/transaction/presentation/transaction_cells/last_price_cell.dart';
import 'package:currency_market/transaction/presentation/transaction_cells/symbol_cell.dart';
import 'package:currency_market/transaction/presentation/transaction_cells/volume_cell.dart';
import 'package:currency_market/transaction/state/transactions_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionTable extends StatelessWidget {
  const TransactionTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final marketDataProvider = context.watch<TransactionsState>();

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
        for (var transaction in marketDataProvider.getTransactions())
          TableRow(
            children: [
              TableCell(child: SymbolCell(transaction: transaction)),
              TableCell(child: LastPriceCell(transaction: transaction)),
              TableCell(child: VolumeCell(transaction: transaction)),
            ],
          ),
      ],
    );
  }
}
