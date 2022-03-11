part of 'models.dart';

class DailyModel extends Equatable {
  final int? id;
  final String? task;
  final DateTime? date;
  final String? time;
  final bool? status;
  final double? ontime;
  final bool? isPlan;
  final bool? isUpdate;
  final UserModel? tag;

  const DailyModel({
    this.id,
    this.task,
    this.date,
    this.status,
    this.time,
    this.ontime,
    this.isPlan,
    this.isUpdate,
    this.tag,
  });

  DailyModel copyWith({
    int? id,
    String? task,
    DateTime? date,
    String? time,
    bool? status,
    double? ontime,
    bool? isPlan,
    bool? isUpdate,
    UserModel? tag,
  }) =>
      DailyModel(
        id: id ?? this.id,
        task: task ?? this.task,
        date: date ?? this.date,
        time: time ?? this.time,
        status: status ?? this.status,
        ontime: ontime ?? this.ontime,
        isPlan: isPlan ?? this.isPlan,
        isUpdate: isUpdate ?? this.isUpdate,
        tag: tag ?? this.tag,
      );

  @override
  List<Object?> get props => [
        id,
        task,
        date,
        time,
        ontime,
        status,
        isPlan,
        isUpdate,
        tag,
      ];

  Map<String, dynamic> toJson() => {
        'task': task,
        'date': DateFormat('y-MM-dd').format(date!),
        'time': time,
        'status': status,
        'ontime': ontime,
        'isplan': isPlan,
        'isupdate': isUpdate,
        'tag_id': tag
      };

  factory DailyModel.fromJson(Map<String, dynamic> json) => DailyModel(
        id: json['id'],
        task: json['task'],
        date: DateTime.fromMillisecondsSinceEpoch(json["date"]),
        status: json['status'] == 0 ? false : true,
        time: json['time'],
        ontime: json['ontime'] == 0
            ? 0.0
            : json['ontime'] == 1
                ? 1.0
                : 0.5,
        isPlan: json['isplan'] == 0 ? false : true,
        isUpdate: json['isupdate'] == 0 ? false : true,
        tag: json['tag'] == null ? null : UserModel.fromJson(json['tag']),
      );
}
