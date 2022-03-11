part of 'models.dart';

class RequestModel extends Equatable {
  final int? id;
  final UserModel? user;
  final String? jenisToDo;
  final UserModel? approvalName;
  final UserModel? approvedName;
  final DateTime? appovedAt;
  final String? status;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final List<DailyModel>? dailyExisting;
  final List<DailyModel>? dailyReplace;
  final List<WeeklyModel>? weeklyExisting;
  final List<WeeklyModel>? weeklyReplace;
  final List<MonthlyModel>? monthlyExisting;
  final List<MonthlyModel>? monthlyReplace;

  const RequestModel({
    this.id,
    this.user,
    this.jenisToDo,
    this.approvalName,
    this.approvedName,
    this.appovedAt,
    this.status,
    this.createdAt,
    this.deletedAt,
    this.dailyExisting,
    this.dailyReplace,
    this.weeklyExisting,
    this.weeklyReplace,
    this.monthlyExisting,
    this.monthlyReplace,
  });

  @override
  List<Object?> get props => [
        id,
        user,
        jenisToDo,
        approvalName,
        approvedName,
        appovedAt,
        status,
        createdAt,
        deletedAt,
        dailyExisting,
        dailyReplace,
        weeklyExisting,
        weeklyReplace,
        monthlyExisting,
        monthlyReplace,
      ];

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        id: json['request']['id'],
        user: UserModel.fromJson(json['request']['user']),
        jenisToDo: json['request']['jenistodo'],
        approvalName: UserModel.fromJson(json['request']['approve_id']),
        approvedName: json['request']['approved_by'] == null
            ? null
            : UserModel.fromJson(json['request']['approved_by']),
        appovedAt: json['request']['approved_at'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(
                json['request']['approved_at']),
        status: json['request']['status'],
        createdAt:
            DateTime.fromMillisecondsSinceEpoch(json['request']['created_at']),
        deletedAt: json['request']['deleted_at'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(
                json['request']['deleted_at']),
        dailyExisting: (json['request']['jenistodo'] == 'Daily')
            ? (json['existing'] as Iterable)
                .map((e) => DailyModel.fromJson(e))
                .toList()
            : null,
        dailyReplace: (json['request']['jenistodo'] == 'Daily')
            ? (json['replace'] as Iterable)
                .map((e) => DailyModel.fromJson(e))
                .toList()
            : null,
        weeklyExisting: (json['request']['jenistodo'] == 'Weekly')
            ? (json['existing'] as Iterable)
                .map((e) => WeeklyModel.fromJson(e))
                .toList()
            : null,
        weeklyReplace: (json['request']['jenistodo'] == 'Weekly')
            ? (json['replace'] as Iterable)
                .map((e) => WeeklyModel.fromJson(e))
                .toList()
            : null,
        monthlyExisting: (json['request']['jenistodo'] == 'Monthly')
            ? (json['existing'] as Iterable)
                .map((e) => MonthlyModel.fromJson(e))
                .toList()
            : null,
        monthlyReplace: (json['request']['jenistodo'] == 'Monthly')
            ? (json['replace'] as Iterable)
                .map((e) => MonthlyModel.fromJson(e))
                .toList()
            : null,
      );
}
