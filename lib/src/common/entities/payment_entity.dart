class PaymentEntity {
  String id;
  bool status;
  String userId;
  DateTime createdAt;

  PaymentEntity({
    required this.id,
    required this.status,
    required this.userId,
    required this.createdAt,
  });
}
