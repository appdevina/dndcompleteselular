part of 'widgets.dart';

snackbar(BuildContext context, bool status, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
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
