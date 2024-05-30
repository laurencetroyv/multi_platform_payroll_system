class EmployeeEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String address;
  final String jobId;
  final bool status;

  EmployeeEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.jobId,
    required this.status,
  });

  EmployeeEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? address,
    String? jobId,
    bool? status,
  }) {
    return EmployeeEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      jobId: jobId ?? this.jobId,
      status: status ?? this.status,
    );
  }
}
