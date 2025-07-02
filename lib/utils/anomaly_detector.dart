
class AnomalyDetector {
  static bool isAnomalous(double previous, double current) {
    if (previous == 0) return false;
    final changePercent = ((current - previous).abs() / previous) * 100;
    return changePercent > 50;
  }
}
