class EmployeeIds {
  final String id;
  final String employerId;
  final String reference;

  EmployeeIds({
    required this.id,
    required this.employerId,
    required this.reference,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employerId': employerId,
      'reference': reference,
    };
  }

  factory EmployeeIds.fromMap(Map<String, dynamic> json) {
    return EmployeeIds(
      id: json['id'],
      employerId: json['employerId'],
      reference: json['reference'],
    );
  }
}
