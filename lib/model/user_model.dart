part of 'models.dart';

class UserModel extends Equatable {
  final int? id;
  final String? namaLengkap;
  final RoleModel? role;
  final AreaModel? area;
  final DivisiModel? divisi;
  final bool? daily;
  final bool? weeklyResult;
  final bool? weeklyNon;
  final bool? monthlyResult;
  final bool? monthlyNon;

  const UserModel({
    this.id,
    this.namaLengkap,
    this.role,
    this.area,
    this.divisi,
    this.daily,
    this.weeklyResult,
    this.weeklyNon,
    this.monthlyResult,
    this.monthlyNon,
  });

  @override
  List<Object?> get props => [
        id,
        namaLengkap,
        role,
        area,
        divisi,
        daily,
        weeklyResult,
        weeklyNon,
        monthlyResult,
        monthlyNon,
      ];

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        namaLengkap: json['nama_lengkap'],
        role: RoleModel.fromJson(json['role']),
        area: AreaModel.fromJson(json['area']),
        divisi: DivisiModel.fromJson(json['divisi']),
        daily: json['d'] == 0 ? false : true,
        weeklyResult: json['wr'] == 0 ? false : true,
        weeklyNon: json['wn'] == 0 ? false : true,
        monthlyResult: json['mr'] == 0 ? false : true,
        monthlyNon: json['mn'] == 0 ? false : true,
      );
}

UserModel mockUser = const UserModel(
  id: 4,
  namaLengkap: 'USEP HERMANTO',
  role: RoleModel(id: 2, nama: 'STAFF'),
  area: AreaModel(id: 1, nama: 'COO'),
  divisi: DivisiModel(id: 4, nama: 'BUSDEV'),
  daily: true,
  weeklyNon: true,
  weeklyResult: false,
  monthlyNon: false,
  monthlyResult: false,
);
