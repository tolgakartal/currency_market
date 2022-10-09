import 'package:flutter/material.dart';

class HeaderCellContainer extends StatelessWidget {
  const HeaderCellContainer({
    Key? key,
    required this.sortRequested,
    required this.requestSort,
    required this.title,
  }) : super(key: key);

  static const double headerRowHeight = 50;
  static const double sortIconSize = 17;

  final bool sortRequested;
  final VoidCallback? requestSort;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: requestSort,
      child: Container(
        height: headerRowHeight,
        padding: const EdgeInsets.all(8),
        color: sortRequested ? Colors.amber : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
            Icon(
              sortRequested ? Icons.arrow_upward : Icons.arrow_downward,
              size: sortIconSize,
            ),
          ],
        ),
      ),
    );
  }
}
