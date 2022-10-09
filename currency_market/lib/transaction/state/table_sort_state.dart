import 'package:flutter/material.dart';

class TableSortState extends ChangeNotifier {
  bool _symbolSortRequested = false;
  bool _lastPriceSortRequested = false;
  bool _volumeSortRequested = false;

  bool get symbolSortRequested => _symbolSortRequested;
  bool get lastPriceSortRequested => _lastPriceSortRequested;
  bool get volumeSortRequested => _volumeSortRequested;

  void requestSortSymbol() {
    if (_symbolSortRequested) {
      _resetTableSortState();
      notifyListeners();
      return;
    }
    _resetTableSortState();
    _symbolSortRequested = true;
    notifyListeners();
  }

  void requestSortLastPrice() {
    if (_lastPriceSortRequested) {
      _resetTableSortState();
      notifyListeners();
      return;
    }
    _resetTableSortState();
    _lastPriceSortRequested = true;
    notifyListeners();
  }

  void requestSortVolume() {
    if (_volumeSortRequested) {
      _resetTableSortState();
      notifyListeners();
      return;
    }
    _resetTableSortState();
    _volumeSortRequested = true;
    notifyListeners();
  }

  void _resetTableSortState() {
    _symbolSortRequested = false;
    _lastPriceSortRequested = false;
    _volumeSortRequested = false;
  }
}
