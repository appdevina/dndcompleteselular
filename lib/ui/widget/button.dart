// ignore_for_file: avoid_returning_null_for_void

part of 'widgets.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  final double height;
  final double width;
  const MyButton(
      {Key? key,
      required this.label,
      required this.onTap,
      required this.height,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
            border: Border.all(color: "F6F2D4".toColor(), width: 0.8),
            borderRadius: BorderRadius.circular(12),
            color: "5584AC".toColor()),
        child: Text(
          label,
          style: blackFontStyle3.copyWith(color: "F6F2D4".toColor()),
        ),
      ),
    );
  }
}
