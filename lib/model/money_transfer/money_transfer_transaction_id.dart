class MoneyTransferTransactionId {
  MoneyTransferTransactionId({
    required this.transactionId,
    required this.traceId,
  });

  int transactionId;
  String traceId;

  factory MoneyTransferTransactionId.fromJson(dynamic json) =>
      MoneyTransferTransactionId(
        transactionId: json["transactionId"],
        traceId: json["traceId"],
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "traceId": traceId,
      };
}
