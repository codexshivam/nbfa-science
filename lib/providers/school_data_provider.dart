import 'package:flutter/material.dart';

import '../models/school_data.dart';
import '../services/school_data_service.dart';

class SchoolDataProvider extends ChangeNotifier {
  SchoolDataProvider({SchoolDataService? service})
    : _service = service ?? const SchoolDataService();

  final SchoolDataService _service;

  SchoolData? _data;
  bool _isLoading = false;
  String? _error;

  SchoolData? get data => _data;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _data = await _service.loadData();
    } catch (_) {
      _error = 'Unable to load school data. Please refresh and try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
