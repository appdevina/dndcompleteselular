part of 'models.dart';

class MonthlyModel extends Equatable {
  final int? id;
  final String? task;
  final int? month;
  final int? year;
  final String? type;
  final bool? isPlan;
  int? valPlan;
  int? valAct;
  bool? statNon;
  double? statRes;
  double? value;
  final bool? isUpdate;

  MonthlyModel({
    this.id,
    this.task,
    this.month,
    this.type,
    this.valPlan,
    this.statNon,
    this.statRes,
    this.year,
    this.valAct,
    this.value,
    this.isUpdate,
    this.isPlan,
  });

  @override
  List<Object?> get props => [
        id,
        task,
        month,
        year,
        type,
        valPlan,
        statNon,
        statRes,
        valAct,
        value,
        isUpdate,
        isPlan,
      ];
}

List<MonthlyModel> mockMonthly = [
  MonthlyModel(
    id: 1,
    task: 'dokumentasi instruksi kerja (IK)',
    month: 1,
    year: 2022,
    type: 'RESULT',
    valPlan: 9,
    statNon: null,
    statRes: 0.0,
    valAct: 0,
    value: 0.0,
    isUpdate: false,
    isPlan: true,
  ),
  MonthlyModel(
    id: 2,
    task: 'dokumentasi surat edaran (SE)',
    month: 1,
    year: 2022,
    type: 'RESULT',
    valPlan: 8,
    statNon: null,
    statRes: 0.0,
    valAct: 0,
    value: 0.0,
    isUpdate: false,
    isPlan: true,
  ),
  MonthlyModel(
    id: 3,
    task: 'dokumentasi job desc (JD)',
    month: 1,
    year: 2022,
    type: 'RESULT',
    valPlan: 6,
    statNon: null,
    statRes: 0.0,
    valAct: 0,
    value: 0.0,
    isUpdate: false,
    isPlan: true,
  ),
  MonthlyModel(
    id: 4,
    task: 'dokumentasi standart operating procedure (SOP)',
    month: 1,
    year: 2022,
    type: 'RESULT',
    valPlan: 6,
    statNon: null,
    statRes: 0.0,
    valAct: 0,
    value: 0.0,
    isUpdate: false,
    isPlan: true,
  ),
  // MonthlyModel(
  //   id: 5,
  //   task: 'observasi proses bisnis divisi (IK)',
  //   month: 1,
  //   year: 2022,
  //   type: 'RESULT',
  //   valPlan: 2,
  //   statNon: null,
  //   statRes: 0.0,
  //   valAct: 0,
  //   value: 0.0,
  //   isUpdate: false,
  //   isPlan: true,
  // ),
  // MonthlyModel(
  //   id: 6,
  //   task: 'review report dokumen rilis',
  //   month: 1,
  //   year: 2022,
  //   type: 'NON',
  //   valPlan: null,
  //   statNon: false,
  //   statRes: null,
  //   valAct: 0,
  //   value: 0.0,
  //   isUpdate: false,
  //   isPlan: true,
  // ),
  MonthlyModel(
    id: 7,
    task: 'review hasil observasi',
    month: 1,
    year: 2022,
    type: 'NON',
    valPlan: null,
    statNon: false,
    statRes: null,
    valAct: 0,
    value: 0.0,
    isUpdate: false,
    isPlan: false,
  ),
];
