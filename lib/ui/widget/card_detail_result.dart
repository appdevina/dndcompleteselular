part of 'widgets.dart';

class CardDetailResult extends StatelessWidget {
  final String title, value;
  const CardDetailResult({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: MediaQuery.of(context).size.width / 4,
      child: Card(
        color: Colors.black45,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(15)),
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: Colors.green[500],
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: blackFontStyle3.copyWith(color: white, fontSize: 12),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 40,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: blackFontStyle3.copyWith(
                    fontSize: 22, color: "22577E".toColor()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
