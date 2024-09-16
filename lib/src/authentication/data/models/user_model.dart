import 'dart:convert';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.createdAt,
    required super.name,
    required super.avatar,
  });

  const UserModel.empty() : this(
      id: '_empty.id',
      createdAt: '_empty.createdAt',
      name: '_empty.name',
      avatar: '_empty.avatar'
  );

  UserModel copyWith({
    String? id,
    String? createdAt,
    String? name,
    String? avatar,
  }) => UserModel(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    name: name ?? this.name,
    avatar: avatar ?? this.avatar,
  );

  factory UserModel.fromJson(String string) => UserModel.fromMap(jsonDecode(string));

  factory UserModel.fromMap(DataMap map) => UserModel(
    id: map['id'],
    createdAt: map['createdAt'],
    name: map['name'],
    avatar: map['avatar'],
  );

  toJson() => jsonEncode(toMap());

  DataMap toMap() => {
    'id': id,
    'createdAt': createdAt,
    'name': name,
    'avatar': avatar,
  };
}