part of 'models.dart';

class MonthlyRequestModel extends Equatable {
  final int? id;
  final String? task;
  final DateTime? monthYear;
  final String? type;
  final int? valPlan;
  final bool? isAdd;
  final bool? isUpdate;
  final List<UserModel> tag;
  final List<UserModel> send;

  const MonthlyRequestModel({
    this.id,
    this.task,
    this.monthYear,
    this.type,
    this.valPlan,
    this.isUpdate,
    this.isAdd,
    required this.tag,
    required this.send,
  });

  MonthlyRequestModel copyWith({
    int? id,
    String? task,
    DateTime? monthYear,
    String? type,
    int? valPlan,
    bool? isAdd,
    bool? isUpdate,
    List<UserModel>? tag,
    List<UserModel>? send,
  }) =>
      MonthlyRequestModel(
        id: id ?? this.id,
        task: task ?? this.task,
        monthYear: monthYear ?? this.monthYear,
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
        monthYear,
        type,
        valPlan,
        isAdd,
        isUpdate,
        tag,
        send,
      ];

  Map<String, dynamic> toJson() => {
        'task': task,
        'date': DateFormat('y-MM-dd').format(monthYear!),
        'tipe': type,
        'value_plan': valPlan,
        'is_add': isAdd,
        'is_update': isUpdate ?? 0,
        'tag': tag.map((e) => e.id).toList(),
        'add_id': send.map((e) => e.id).toList(),
      };
}
