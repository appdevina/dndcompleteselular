part of 'models.dart';

class AreaModel extends Equatable {
  final int? id;
  final String? nama;

  const AreaModel({this.id, this.nama});

  @override
  List<Object?> get props => [
        id,
        nama,
      ];

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
        id: json['id'],
        nama: json['nama'],
      );
}
