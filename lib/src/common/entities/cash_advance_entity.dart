class CashAdvanceEntity {
  final String id;
  final String userId;
  final String amount;
  final DateTime repaymentDate;
  final DateTime createdAt;

  CashAdvanceEntity({
    required this.id,
    required this.userId,
    required this.amount,
    required this.repaymentDate,
    required this.createdAt,
  });
}
