import 'package:currency_market/transaction/data/model/transaction.dart';
import 'package:currency_market/transaction/presentation/transaction_cells/cell_container.dart';
import 'package:flutter/material.dart';

class LastPriceCell extends StatelessWidget {
  const LastPriceCell({
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
          '\$${transaction.lastPrice?.toStringAsFixed(2) ?? "0"}',
        ),
      ),
    );
  }
}
