part of 'models.dart';

class MonthlyModel extends Equatable {
  final int? id;
  final String? task;
  final DateTime? monthYear;
  final String? type;
  final int? valPlan;
  final int? valAct;
  final bool? statNon;
  final bool? statRes;
  final double? value;
  final bool? isAdd;
  final bool? isUpdate;

  const MonthlyModel({
    this.id,
    this.task,
    this.monthYear,
    this.type,
    this.valPlan,
    this.valAct,
    this.statNon,
    this.statRes,
    this.value,
    this.isUpdate,
    this.isAdd,
  });

  @override
  List<Object?> get props => [
        id,
        task,
        monthYear,
        type,
        valPlan,
        valAct,
        statNon,
        statRes,
        value,
        isAdd,
        isUpdate,
      ];

  Map<String, dynamic> toJson() => {
        'task': task,
        'date': DateFormat('y-MM-dd').format(monthYear!),
        'tipe': type,
        'value_plan': valPlan,
        'value_actual': valAct,
        'status_non': statNon,
        'status_result': statRes,
        'value': value ?? 0,
        'is_add': isAdd,
        'is_update': isUpdate,
      };

  factory MonthlyModel.fromJson(Map<String, dynamic> json) => MonthlyModel(
        id: json['id'],
        task: json['task'],
        monthYear: DateTime.fromMillisecondsSinceEpoch(json['date']),
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
