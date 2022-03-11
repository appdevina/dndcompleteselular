part of 'widgets.dart';

class DropDownCustom extends GetView<RequestTaskController> {
  final String title;
  final List<String> todoType;

  const DropDownCustom({Key? key, required this.title, required this.todoType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: blackFontStyle3.copyWith(color: white),
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
              color: white,
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
                  child: DropdownButtonFormField<String>(
                    value: controller.selectedTodo,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: "22577E".toColor(),
                          width: 0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: "22577E".toColor(),
                          width: 0,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: "22577E".toColor(),
                          width: 0,
                        ),
                      ),
                    ),
                    items: todoType
                        .map((e) => DropdownMenuItem<String>(
                            value: e, child: Text(e.toString())))
                        .toList(),
                    onChanged: (String? val) {
                      if (val != null) {
                        controller.changeTodo(val);
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
