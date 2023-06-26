part of 'models.dart';

class WeeklyRequestModel extends Equatable {
  final int? id;
  final String? task;
  final int? week;
  final int? year;
  final String? type;
  final int? valPlan;
  final bool? isAdd;
  final bool? isUpdate;
  final List<UserModel> tag;
  final List<UserModel> send;

  const WeeklyRequestModel({
    this.id,
    required this.task,
    required this.week,
    required this.year,
    required this.type,
    this.valPlan,
    this.isAdd,
    this.isUpdate,
    required this.tag,
    required this.send,
  });

  WeeklyRequestModel copyWith({
    int? id,
    String? task,
    int? week,
    int? year,
    String? type,
    int? valPlan,
    bool? isAdd,
    bool? isUpdate,
    List<UserModel>? tag,
    List<UserModel>? send,
  }) =>
      WeeklyRequestModel(
        id: id ?? this.id,
        task: task ?? this.task,
        week: week ?? this.week,
        year: year ?? this.year,
        type: type ?? this.type,
        valPlan: valPlan ?? this.valPlan,
        isAdd: isAdd ?? this.isAdd,
        isUpdate: isUpdate ?? this.isUpdate,
        tag: tag ?? this.tag,
        send: send ?? this.send,
      );

  @override
  List<Object?> get props => [
        id,
        task,
        week,
        year,
        type,
        valPlan,
        isAdd,
        isUpdate,
        tag,
        send,
      ];

  Map<String, dynamic> toJson() => {
        'task': task,
        'week': week,
        'year': year,
        'tipe': type,
        'value_plan': valPlan,
        'is_add': isAdd,
        'is_update': isUpdate ?? 0,
        'tag': tag.map((e) => e.id).toList(),
        'add_id': send.map((e) => e.id).toList(),
      };
}
