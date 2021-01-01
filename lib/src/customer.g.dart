// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return Customer()
    ..first = json['first'] as String
    ..last = json['last'] as String
    ..isImportant = json['isImportant'] as bool
    ..friends = (json['friends'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : Customer.fromJson(e as Map<String, dynamic>)),
    );
}

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'first': instance.first,
      'last': instance.last,
      'isImportant': instance.isImportant,
      'friends': instance.friends,
    };
