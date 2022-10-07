import 'dart:ui';
import 'package:currency_market/home/presentation/transaction_table.dart';
import 'package:currency_market/home/state/market_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final marketDataProvider = context.watch<MarketState>();
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
                    marketDataProvider.selectedMarketDataType = x == 0
                        ? MarketDataType.all
                        : x == 1
                            ? MarketDataType.spot
                            : MarketDataType.future;
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
                      Transactions(),
                      Transactions(),
                      Transactions(),
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

class Transactions extends StatelessWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          SizedBox(height: 64),
          TransactionTableHeader(),
          SizedBox(height: 16),
          TransactionTable(),
        ],
      ),
    );
  }
}
