part of 'models.dart';

class DailyModel extends Equatable {
  final int? id;
  final String? task;
  final DateTime? date;
  final String? time;
  final bool? status;

  const DailyModel({this.id, this.task, this.date, this.time, this.status});

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
    task: 'like save share medsos',
    date: DateTime.now(),
    time: '10:00 AM',
    status: true,
  ),
  DailyModel(
    id: 1,
    task: 'monitoring server IMO dan CLOUD',
    date: DateTime.now(),
    time: '10:30 AM',
    status: false,
  ),
  DailyModel(
    id: 1,
    task: 'setup dev',
    date: DateTime.now(),
    time: '12:30 AM',
    status: false,
  ),
  DailyModel(
    id: 1,
    task: 'pembuatan ui homepage todolist',
    date: DateTime.now(),
    time: '13:00 AM',
    status: false,
  ),
  DailyModel(
    id: 1,
    task: 'Monitoring server dan helpdesk SAM',
    date: DateTime.now(),
    time: '17:00 AM',
    status: false,
  ),
];
