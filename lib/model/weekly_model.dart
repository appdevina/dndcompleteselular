part of 'models.dart';

class WeeklyModel extends Equatable {
  final int? id;
  final String? task;
  final int? week;
  final int? year;
  final String? type;
  int? valPlan;
  double? valAct;
  bool? statNon;
  double? statRes;
  double? value;
  final bool? isUpdate;

  WeeklyModel(
      {this.id,
      this.task,
      this.week,
      this.type,
      this.valPlan,
      this.valAct,
      this.statNon,
      this.year,
      this.statRes,
      this.value,
      this.isUpdate});

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
}

List<WeeklyModel> mockWeekly = [
  WeeklyModel(
    id: 1,
    task: "Pembuatan IK fitur monitoring visit SAM",
    week: 3,
    type: "NON",
    valPlan: null,
    valAct: null,
    statNon: false,
    statRes: null,
    value: 0,
    isUpdate: false,
  ),
  WeeklyModel(
    id: 2,
    task: "Pembuatan UI weekly TDL",
    week: 3,
    type: "NON",
    valPlan: null,
    valAct: null,
    statNon: false,
    statRes: null,
    value: 0,
    isUpdate: false,
  ),
  WeeklyModel(
    id: 3,
    task: "Input user dan outlet baru realme region jogja dan solo ke SAM",
    week: 3,
    type: "NON",
    valPlan: null,
    valAct: null,
    statNon: false,
    statRes: null,
    value: 0,
    isUpdate: false,
  ),
  WeeklyModel(
    id: 4,
    task: "Monitoring dan Helpdesk server CLOUD, IMO dan SAM",
    week: 3,
    type: "NON",
    valPlan: null,
    valAct: null,
    statNon: false,
    statRes: null,
    value: 0,
    isUpdate: false,
  ),
  WeeklyModel(
    id: 5,
    task: "Kirim AMPM tepat waktu",
    week: 3,
    type: "NON",
    valPlan: null,
    valAct: null,
    statNon: false,
    statRes: null,
    value: 0,
    isUpdate: false,
  ),
  WeeklyModel(
    id: 6,
    task: "Sales Area A",
    week: 3,
    type: "RESULT",
    valPlan: 1000000,
    valAct: 0,
    statNon: false,
    statRes: 0.0,
    value: 0,
    isUpdate: false,
  ),
];
