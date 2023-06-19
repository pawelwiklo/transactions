// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: json[r'$id'] as String,
      transaction_date: DateTime.parse(json['transaction_date'] as String),
      amount: json['amount'] as int,
      commission: json['commission'] as String,
      total: (json['total'] as num).toDouble(),
      transaction_number: json['transaction_number'] as String,
      operation_type:
          $enumDecode(_$OperationTypeEnumMap, json['operation_type']),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'transaction_date': instance.transaction_date.toIso8601String(),
      'amount': instance.amount,
      'commission': instance.commission,
      'total': instance.total,
      'transaction_number': instance.transaction_number,
      'operation_type': _$OperationTypeEnumMap[instance.operation_type]!,
    };

const _$OperationTypeEnumMap = {
  OperationType.deposit: 'deposit',
  OperationType.transfer: 'transfer',
  OperationType.withdrawal: 'withdrawal',
};
