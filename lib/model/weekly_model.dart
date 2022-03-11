part of 'models.dart';

class WeeklyModel extends Equatable {
  final int? id;
  final String? task;
  final int? week;
  final int? year;
  final String? type;
  final int? valPlan;
  final int? valAct;
  final bool? statNon;
  final bool? statRes;
  final double? value;
  final bool? isAdd;
  final bool? isUpdate;

  const WeeklyModel({
    this.id,
    this.task,
    this.week,
    this.type,
    this.valPlan,
    this.valAct,
    this.statNon,
    this.year,
    this.statRes,
    this.value,
    this.isUpdate,
    this.isAdd,
  });

  @override
  List<Object?> get props => [
        id,
        task,
        week,
        type,
        valPlan,
        valAct,
        statNon,
        statRes,
        value,
        isUpdate,
      ];

  Map<String, dynamic> toJson() => {
        'task': task,
        'week': week,
        'year': year,
        'tipe': type,
        'value_plan': valPlan,
        'value_actual': valAct,
        'status_non': statNon,
        'status_result': statRes,
        'value': value ?? 0,
        'is_add': isAdd,
        'is_update': isUpdate,
      };

  factory WeeklyModel.fromJson(Map<String, dynamic> json) => WeeklyModel(
        id: json['id'],
        task: json['task'],
        week: json['week'],
        year: json['year'],
        type: json['tipe'],
        valPlan: json['value_plan'],
        valAct: json['value_actual'],
        statNon: json['status_non'] == null
            ? null
            : json['status_non'] == 0
                ? false
                : true,
        statRes: json['status_result'] == null
            ? null
            : json['status_result'] == 0
                ? false
                : true,
        value: json['value'] == 0
            ? 0.0
            : json['value'] == 1
                ? 1.0
                : json['value'],
        isAdd: json['is_add'] == 0 ? false : true,
        isUpdate: json['is_update'] == 0 ? false : true,
      );
}
