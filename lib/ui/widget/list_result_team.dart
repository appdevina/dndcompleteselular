part of 'widgets.dart';

class CardTeam extends GetView<ResultController> {
  final UserModel user;
  const CardTeam({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () => Get.to(() => ResultTeamBody(user: user),
            transition: Transition.cupertino),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.2, color: greyColor),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          child: Container(
            alignment: Alignment.center,
            height: 60,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/task.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    user.namaLengkap!.toUpperCase(),
                    style: blackFontStyle2.copyWith(
                      wordSpacing: 2,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
