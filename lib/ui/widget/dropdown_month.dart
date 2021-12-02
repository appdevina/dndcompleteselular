// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

part of 'widgets.dart';

class DropDownMonth extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> month;
  final MonthlyAddTaskController controller;

  const DropDownMonth({
    Key? key,
    required this.title,
    required this.month,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  child: DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: white,
                          width: 0,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: white,
                          width: 0,
                        ),
                      ),
                    ),
                    items: controller.month
                        .map((e) => DropdownMenuItem<int>(
                            value: e['no'], child: Text("${e['bulan']}")))
                        .toList(),
                    onChanged: (int? val) {
                      if (val != null) {
                        controller.changeMonth(val);
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
