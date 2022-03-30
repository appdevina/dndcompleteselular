part of 'widgets.dart';

class CardDetailResult extends StatelessWidget {
  final String title, value;
  final String? titleTooltip;
  const CardDetailResult(
      {Key? key, required this.title, required this.value, this.titleTooltip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      showDuration: const Duration(milliseconds: 500),
      verticalOffset: -60,
      textStyle: blackFontStyle3.copyWith(color: white),
      decoration: BoxDecoration(
          color: "22577E".toColor(),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: white)),
      message: titleTooltip ?? '',
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 80,
        width: 120,
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
                      fontSize: 18, color: "22577E".toColor()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
