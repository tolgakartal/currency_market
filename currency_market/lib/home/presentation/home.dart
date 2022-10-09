import 'dart:ui';
import 'package:currency_market/transaction/presentation/transaction_table.dart';
import 'package:currency_market/transaction/presentation/transaction_table_header.dart';
import 'package:currency_market/transaction/state/table_sort_state.dart';
import 'package:currency_market/transaction/state/transactions_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactionsState = context.watch<TransactionsState>();
    final sortState = context.read<TableSortState>();
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 40),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              ),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: Column(
            children: [
              const SizedBox(height: 25),
              SizedBox(
                height: 50,
                child: TabBar(
                  labelStyle: const TextStyle(fontSize: 18),
                  indicatorColor: Colors.amberAccent,
                  indicatorWeight: 2.0,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Colors.black,
                  labelPadding: const EdgeInsets.only(top: 8),
                  unselectedLabelColor: Colors.black,
                  isScrollable: false,
                  dragStartBehavior: DragStartBehavior.start,
                  mouseCursor: SystemMouseCursors.noDrop,
                  onTap: (x) {
                    final currentTransactionType = x == 0
                        ? TransactionType.all
                        : x == 1
                            ? TransactionType.spot
                            : TransactionType.future;
                    transactionsState.transactionType = currentTransactionType;
                    transactionsState.switchDataSource(currentTransactionType);
                    switch (currentTransactionType) {
                      case TransactionType.all:
                        sortState.requestCleanSort();
                        break;
                      case TransactionType.future:
                        sortState.requestCleanSort();
                        sortState.requestSortVolume();
                        transactionsState.sortByVolume(SortType.descending);
                        break;
                      case TransactionType.spot:
                        sortState.requestCleanSort();
                        sortState.requestSortVolume();
                        transactionsState.sortByVolume(SortType.descending);
                        break;
                      default:
                    }
                  },
                  tabs: const [
                    Tab(text: 'ALL'),
                    Tab(text: spotTypeKey),
                    Tab(text: futureTypeKey),
                  ],
                ),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TabBarView(
                    children: [
                      TransactionsPage(),
                      TransactionsPage(),
                      TransactionsPage(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: const [
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 3,
                    color: Colors.amber,
                  ),
                ),
                focusColor: Colors.black,
                fillColor: Colors.black,
                labelStyle: TextStyle(color: Colors.black),
                label: Text('Search...'),
              ),
            ),
            SizedBox(height: 16),
            TransactionTableHeader(),
            SizedBox(height: 16),
            TransactionTable(),
          ],
        ),
      ),
    );
  }
}
