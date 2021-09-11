// import 'package:flutter/cupertino.dart';

class AddListFileds {
  static final String id = 'id';
  static final String name = 'name';
  static final String amount = 'amount';

  static List<String> getFields() => [id, name, amount];
}

class AddList {
  final int? id;
  final String name;
  final String amount;


  const AddList({
    this.id,
    required this.name,
    required this.amount,
  });

  AddList copy({
    int? id,
    String? name,
    String? amount,
  }) =>
      AddList(
        id: id ?? this.id,
        name: name ?? this.name,
        amount: amount ?? this.amount,

      );

  Map<String, dynamic> toJson() => {
        AddListFileds.id: id,
        AddListFileds.name: name,
        AddListFileds.amount: amount,
      };
}
