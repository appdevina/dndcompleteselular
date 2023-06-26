part of 'models.dart';

class UserModel extends Equatable {
  final int? id;
  final String? namaLengkap;
  final RoleModel? role;
  final AreaModel? area;
  final DivisiModel? divisi;
  final bool? daily;
  final bool? dailyResult;
  final bool? weeklyResult;
  final bool? weeklyNon;
  final bool? monthlyResult;
  final bool? monthlyNon;
  final String? profilePicture;

  const UserModel({
    this.id,
    this.namaLengkap,
    this.role,
    this.area,
    this.divisi,
    this.daily,
    this.dailyResult,
    this.weeklyResult,
    this.weeklyNon,
    this.monthlyResult,
    this.monthlyNon,
    this.profilePicture,
  });

  @override
  List<Object?> get props => [
        id,
        namaLengkap,
        role,
        area,
        divisi,
        daily,
        dailyResult,
        weeklyResult,
        weeklyNon,
        monthlyResult,
        monthlyNon,
        profilePicture,
      ];

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        namaLengkap: json['nama_lengkap'],
        role: RoleModel.fromJson(json['role']),
        area: AreaModel.fromJson(json['area']),
        divisi: DivisiModel.fromJson(json['divisi']),
        daily: json['d'] == 0 ? false : true,
        dailyResult: json['dr'] == 0 ? false : true,
        weeklyResult: json['wr'] == 0 ? false : true,
        weeklyNon: json['wn'] == 0 ? false : true,
        monthlyResult: json['mr'] == 0 ? false : true,
        monthlyNon: json['mn'] == 0 ? false : true,
        profilePicture: json['profile_picture'],
      );
}
