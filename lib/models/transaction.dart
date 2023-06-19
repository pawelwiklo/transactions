import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

enum OperationType { deposit, transfer, withdrawal }

@JsonSerializable()
class Transaction {
  @JsonKey(name: '\$id', includeToJson: false)
  final String id;
  final DateTime transaction_date;
  final int amount;
  final String commission;
  final double total;
  final String transaction_number;
  final OperationType operation_type;

  Transaction(
      {required this.id,
      required this.transaction_date,
      required this.amount,
      required this.commission,
      required this.total,
      required this.transaction_number,
      required this.operation_type});

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<dynamic, dynamic> toJson() => _$TransactionToJson(this);
}
