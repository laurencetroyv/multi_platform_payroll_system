class EmployeeEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String address;
  final String jobId;
  final bool status;
  final String employerId;

  EmployeeEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.jobId,
    required this.status,
    required this.employerId,
  });

  EmployeeEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? address,
    String? jobId,
    bool? status,
    String? employerId,
  }) {
    return EmployeeEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      jobId: jobId ?? this.jobId,
      status: status ?? this.status,
      employerId: employerId ?? this.employerId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'jobId': jobId,
      'status': status,
      'employerId': employerId,
    };
  }

  factory EmployeeEntity.fromMap(Map<String, dynamic> json) {
    return EmployeeEntity(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      address: json['address'],
      jobId: json['jobId'],
      status: json['status'],
      employerId: json['employerId'],
    );
  }

  factory EmployeeEntity.init() {
    return EmployeeEntity(
      id: '',
      firstName: '',
      lastName: '',
      address: '',
      jobId: '',
      status: false,
      employerId: '',
    );
  }
}
