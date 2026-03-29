import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/school_data.dart';

class SchoolDataService {
  const SchoolDataService();

  Future<SchoolData> loadData() async {
    final rawData = await rootBundle.loadString('assets/data/school_data.json');
    final decoded = jsonDecode(rawData) as Map<String, dynamic>;
    return SchoolData.fromJson(decoded);
  }
}
