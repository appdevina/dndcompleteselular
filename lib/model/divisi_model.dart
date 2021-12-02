part of 'models.dart';

class DivisiModel extends Equatable {
  final int? id;
  final String? nama;

  const DivisiModel({this.id, this.nama});

  @override
  List<Object?> get props => [
        id,
        nama,
      ];

  factory DivisiModel.fromJson(Map<String, dynamic> json) => DivisiModel(
        id: json['id'],
        nama: json['nama'],
      );
}
