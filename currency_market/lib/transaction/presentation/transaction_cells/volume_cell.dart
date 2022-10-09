import 'package:currency_market/transaction/data/model/transaction.dart';
import 'package:currency_market/transaction/presentation/transaction_cells/cell_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VolumeCell extends StatelessWidget {
  const VolumeCell({
    Key? key,
    required this.transaction,
  }) : super(key: key);
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return CellContainer(
      transaction: transaction,
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          NumberFormat.compactCurrency(symbol: '\$').format(transaction.volume),
        ),
      ),
    );
  }
}
