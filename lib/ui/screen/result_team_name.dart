part of 'screens.dart';

class ResultTeamName extends GetView<ResultController> {
  const ResultTeamName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.team.isEmpty
        ? Center(
            child: Text(
            'Tidak ada data',
            textAlign: TextAlign.center,
            style: blackFontStyle1.copyWith(color: white),
          ))
        : GetBuilder<ResultController>(
            id: 'team',
            builder: (_) => ListView.builder(
              itemBuilder: (context, index) =>
                  CardTeam(user: controller.team[index]),
              itemCount: controller.team.length,
            ),
          );
  }
}
