class CashAdvanceEntity {
  final String id;
  final String employeeId;
  final String amount;
  final DateTime repaymentDate;
  final DateTime createdAt;
  final String employerId;

  CashAdvanceEntity({
    required this.id,
    required this.employeeId,
    required this.amount,
    required this.repaymentDate,
    required this.createdAt,
    required this.employerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': employeeId,
      'amount': amount,
      'repaymentDate': repaymentDate,
      'employerId': employerId,
    };
  }

  factory CashAdvanceEntity.fromMap(Map<String, dynamic> json) {
    return CashAdvanceEntity(
      id: json['id'],
      employeeId: json['userId'],
      amount: json['amount'],
      repaymentDate: json['repaymentDate'],
      createdAt: DateTime.parse(json['\$createdAt']),
      employerId: json['employerId'],
    );
  }
}
