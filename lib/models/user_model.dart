import 'package:json_annotation/json_annotation.dart';
import 'settings_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  final Map<String, dynamic>? stats;
  final UserSettings settings;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    this.stats,
    required this.settings,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
