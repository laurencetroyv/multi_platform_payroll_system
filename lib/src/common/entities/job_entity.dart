class JobEntity {
  final String id;
  final String title;
  final double monthlySalary;
  final bool isActive;
  final String employerId;

  JobEntity(
      {required this.id,
      required this.title,
      required this.monthlySalary,
      required this.isActive,
      required this.employerId});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'monthlySalary': monthlySalary,
      'isActive': isActive,
      'employerId': employerId,
    };
  }

  factory JobEntity.fromMap(Map<String, dynamic> json) {
    final salary = json['monthlySalary'] as int;

    return JobEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      monthlySalary: salary.toDouble(),
      isActive: json['isActive'] as bool,
      employerId: json['employerId'] as String,
    );
  }
}
