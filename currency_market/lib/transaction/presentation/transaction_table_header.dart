import 'package:currency_market/transaction/presentation/transaction_cells/header_cell_container.dart';
import 'package:currency_market/transaction/state/table_sort_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionTableHeader extends StatelessWidget {
  const TransactionTableHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortState = context.watch<TableSortState>();
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
            TableCell(
              child: HeaderCellContainer(
                title: 'Symbol',
                sortRequested: sortState.symbolSortRequested,
                requestSort: () => sortState.requestSortSymbol(),
              ),
            ),
            TableCell(
              child: HeaderCellContainer(
                title: 'Last price',
                sortRequested: sortState.lastPriceSortRequested,
                requestSort: () => sortState.requestSortLastPrice(),
              ),
            ),
            TableCell(
              child: HeaderCellContainer(
                title: 'Volume',
                sortRequested: sortState.volumeSortRequested,
                requestSort: () => sortState.requestSortVolume(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
