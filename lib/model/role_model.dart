part of 'models.dart';

class RoleModel extends Equatable {
  final int? id;
  final String? nama;

  const RoleModel({this.id, this.nama});

  @override
  List<Object?> get props => [
        id,
        nama,
      ];

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        id: json['id'],
        nama: json['name'],
      );
}
