// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

part of 'widgets.dart';

class MyInputField extends GetView<DailyAddTaskController> {
  final String title;
  final String hint;
  final TextEditingController? controllerText;
  final bool isPassword;
  final Widget? widget;
  final bool? obsecure;
  final bool side;
  final TextInputType typeInput;
  final bool? isvalue;
  MyInputField({
    required this.title,
    required this.hint,
    this.controllerText,
    required this.isPassword,
    this.obsecure,
    this.widget,
    this.side = false,
    this.typeInput = TextInputType.name,
    this.isvalue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: side
          ? EdgeInsets.only(top: 1)
          : EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: blackFontStyle3,
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(
              top: 8,
            ),
            padding: const EdgeInsets.only(
              left: 14,
            ),
            height: 52,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    obscureText: obsecure == true ? true : false,
                    readOnly: isPassword
                        ? false
                        : widget == null
                            ? false
                            : true,
                    autofocus: false,
                    cursorColor: Colors.black,
                    controller: controllerText,
                    style: blackFontStyle3,
                    keyboardType: typeInput,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: isvalue! ? blackFontStyle3 : greyFontStyle,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: white,
                          width: 0,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: white,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
