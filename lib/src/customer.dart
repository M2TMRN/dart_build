
import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart'; // Where the mapper will be generated

@JsonSerializable(ignoreUnannotated: true)
class Customer {
  @JsonKey(name: 'first')
  String first;
  String last; // @last is not mapped since it is not annotated
  @JsonKey(name: 'isImportant')
  bool isImportant;

  @JsonKey(name: 'friends')
  Map<String, Customer> friends;

  Customer();

  // Before code generation
  //factory Customer.fromJson(Map<String, dynamic> json) => null;

  // Has to be implemented after code generation so Lint would not complain
  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);


  // Before code generation
  //Map<String, dynamic> toJson() => null;

  // Has to be implemented after code generation so Lint would not complain
  Map<String, dynamic> toJson() => _$CustomerToJson(this);

}
