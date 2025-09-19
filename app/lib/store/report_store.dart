import 'dart:collection';

import 'package:flutter/foundation.dart';
import '../models/report.dart';

class ReportStore extends ChangeNotifier {
  final List<Report> _reports = <Report>[];

  UnmodifiableListView<Report> get reports => UnmodifiableListView(_reports);

  void addReport(Report report) {
    _reports.add(report);
    notifyListeners();
  }

  void removeReport(String id) {
    _reports.removeWhere((r) => r.id == id);
    notifyListeners();
  }

  void clear() {
    _reports.clear();
    notifyListeners();
  }
}
