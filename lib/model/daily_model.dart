part of 'models.dart';

class DailyModel extends Equatable {
  final int? id;
  final String? task;
  final DateTime? date;
  final String? time;
  bool? status;

  DailyModel({this.id, this.task, this.date, this.time, this.status});

  DailyModel copyWith({
    int? id,
    String? task,
    DateTime? date,
    String? time,
    bool? status,
  }) =>
      DailyModel(
        id: id ?? this.id,
        task: task ?? this.task,
        date: date ?? this.date,
        time: time ?? this.time,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        id,
        task,
        date,
        time,
        status,
      ];

  factory DailyModel.fromJson(Map<String, dynamic> json) => DailyModel(
        id: json['id'],
        task: json['task'],
        date: DateTime.fromMillisecondsSinceEpoch(json["date"]),
        time: json['time'],
        status: json['status'] == 0 ? false : true,
      );
}

List<DailyModel> mockDaily = [
  DailyModel(
    id: 1,
    task: 'Meeting sistem development',
    date: DateTime.now(),
    time: '10:00 AM',
    status: true,
  ),
  DailyModel(
    id: 2,
    task: 'Review Progress dan plan next week',
    date: DateTime.now(),
    time: '1:00 PM',
    status: false,
  ),
  DailyModel(
    id: 3,
    task: 'Meeting outdoor busdev',
    date: DateTime.now(),
    time: '2:00 PM',
    status: false,
  ),
  DailyModel(
    id: 4,
    task: 'Monitoring server',
    date: DateTime.now(),
    time: '3:00 PM',
    status: false,
  ),
  DailyModel(
    id: 5,
    task: 'Helpdesk CLOUD,IMO & SAM',
    date: DateTime.now(),
    time: '4:00 PM',
    status: false,
  ),
];
