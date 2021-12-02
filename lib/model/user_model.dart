part of 'models.dart';

enum BackdateMode { none, daily, weekly, monthly }

class UserModel extends Equatable {
  final int? id;
  final String? namaLengkap;
  final AreaModel? area;
  final DivisiModel? divisi;
  final bool? daily;
  final bool? weeklyResult;
  final bool? weeklyNon;
  final bool? monthlyResult;
  final bool? monthlyNon;
  final BackdateMode? backDate;

  const UserModel({
    this.id,
    this.namaLengkap,
    this.area,
    this.divisi,
    this.daily,
    this.weeklyResult,
    this.weeklyNon,
    this.monthlyResult,
    this.monthlyNon,
    this.backDate,
  });

  @override
  List<Object?> get props => [
        id,
        namaLengkap,
        area,
        divisi,
        daily,
        weeklyResult,
        weeklyNon,
        monthlyResult,
        monthlyNon,
        backDate,
      ];

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        namaLengkap: json['nama_lengkap'],
        area: AreaModel.fromJson(json['area']),
        divisi: DivisiModel.fromJson(json['divisi']),
        daily: json['d'] == 0 ? false : true,
        weeklyResult: json['wr'] == 0 ? false : true,
        weeklyNon: json['wn'] == 0 ? false : true,
        monthlyResult: json['mr'] == 0 ? false : true,
        monthlyNon: json['mn'] == 0 ? false : true,
        backDate: json['bd'] == 0
            ? BackdateMode.none
            : json['bd'] == 1
                ? BackdateMode.daily
                : json['bd'] == 2
                    ? BackdateMode.weekly
                    : BackdateMode.monthly,
      );
}

UserModel mockUser = const UserModel(
  id: 1,
  namaLengkap: 'USEP HERMANTO',
  area: AreaModel(nama: 'COO'),
  divisi: DivisiModel(nama: 'BUSDEV'),
  daily: true,
  weeklyNon: true,
  weeklyResult: false,
  monthlyNon: false,
  monthlyResult: false,
  backDate: BackdateMode.none,
);
