class CashAdvanceEntity {
  final String id;
  final String employeeId;
  final String amount;
  final DateTime repaymentDate;
  final DateTime createdAt;
  final String employerId;
  final String contactNumber;
  final bool active;

  CashAdvanceEntity({
    required this.id,
    required this.employeeId,
    required this.amount,
    required this.repaymentDate,
    required this.createdAt,
    required this.employerId,
    required this.contactNumber,
    required this.active,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': employeeId,
      'repaymentDate': repaymentDate.toIso8601String(),
      'employerId': employerId,
      'amount': double.parse(amount),
      'contactNumber': contactNumber,
    };
  }

  factory CashAdvanceEntity.fromMap(Map<String, dynamic> json) {
    final repaymentDate = DateTime.parse(json['repaymentDate']);
    return CashAdvanceEntity(
      id: json['\$id'],
      employeeId: json['userId'],
      amount: "${json['amount']}",
      repaymentDate: repaymentDate,
      createdAt: DateTime.parse(json['\$createdAt']),
      employerId: json['employerId'],
      contactNumber: json['contactNumber'],
      active: json['active'],
    );
  }
}
