part of 'widgets.dart';

snackbar(BuildContext context, bool status, String message, {int? duration}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: duration ?? 2000),
      elevation: 10,
      content: Text(
        message,
        style:
            blackFontStyle3.copyWith(fontWeight: FontWeight.w300, color: white),
      ),
      backgroundColor: status ? Colors.green[400] : Colors.red[400],
    ),
  );
}
