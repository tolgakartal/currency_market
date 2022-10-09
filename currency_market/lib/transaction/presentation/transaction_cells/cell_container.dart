import 'package:currency_market/transaction/data/model/transaction.dart';
import 'package:currency_market/transaction/state/transactions_state.dart';
import 'package:flutter/material.dart';

class CellContainer extends StatelessWidget {
  const CellContainer({
    Key? key,
    required this.transaction,
    required this.child,
  }) : super(key: key);

  final Transaction transaction;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: transaction.type == null
          ? Colors.white
          : transaction.type == spotTypeKey
              ? Colors.amber
              : Colors.green,
      child: Container(
        height: 32,
        padding: const EdgeInsets.all(8),
        child: child,
      ),
    );
  }
}
