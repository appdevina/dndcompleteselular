part of 'models.dart';

class DailyRequestModel extends Equatable {
  final int? id;
  final String task;
  final DateTime date;
  final String? time;
  final bool isPlan;
  final bool? isUpdate;
  final List<UserModel> tag;
  final List<UserModel> send;
  final int? valuePlan;
  final String tipe;

  const DailyRequestModel({
    this.id,
    required this.task,
    required this.date,
    this.time,
    required this.isPlan,
    this.isUpdate,
    required this.tag,
    required this.send,
    this.valuePlan,
    required this.tipe,
  });

  DailyRequestModel copyWith({
    int? id,
    String? task,
    DateTime? date,
    String? time,
    bool? isPlan,
    bool? isUpdate,
    List<UserModel>? tag,
    List<UserModel>? send,
    int? valuePlan,
    String? tipe,
  }) =>
      DailyRequestModel(
        id: id ?? this.id,
        task: task ?? this.task,
        date: date ?? this.date,
        time: time ?? this.time,
        isPlan: isPlan ?? this.isPlan,
        isUpdate: isUpdate ?? this.isUpdate,
        tag: tag ?? this.tag,
        send: send ?? this.send,
        valuePlan: valuePlan ?? this.valuePlan,
        tipe: tipe ?? this.tipe,
      );

  @override
  List<Object?> get props => [
        id,
        task,
        date,
        time,
        isPlan,
        isUpdate,
        tag,
        send,
        valuePlan,
        tipe,
      ];

  Map<String, dynamic> toJson() => {
        'id': id,
        'task': task,
        'date': DateFormat('y-MM-dd').format(date),
        'time': time,
        'isplan': isPlan,
        'isupdate': isUpdate ?? 0,
        'value_plan': valuePlan,
        'tipe': tipe,
        'tag': tag.map((e) => e.id).toList(),
        'add_id': send.map((e) => e.id).toList(),
      };
}
