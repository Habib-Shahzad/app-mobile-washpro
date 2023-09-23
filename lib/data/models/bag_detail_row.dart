class BagDetailRow {
  final String orderNumber;
  final String serviceType;
  final String expected;
  final String actual;
  final String variance;

  BagDetailRow({
    required this.orderNumber,
    required this.serviceType,
    required this.expected,
    required this.actual,
    required this.variance,
  });
}
