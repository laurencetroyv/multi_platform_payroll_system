class PaymentEntity {
  String id;
  bool status;
  String employeeId;
  DateTime createdAt;
  String employerId;

  PaymentEntity({
    required this.id,
    required this.status,
    required this.employeeId,
    required this.createdAt,
    required this.employerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'employeeId': employeeId,
      'employerId': employerId,
    };
  }

  factory PaymentEntity.fromMap(Map<String, dynamic> json) {
    return PaymentEntity(
      id: json['id'],
      status: json['status'],
      employeeId: json['employeeId'],
      createdAt: DateTime.parse(json['\$createdAt']),
      employerId: json['employerId'],
    );
  }
}
