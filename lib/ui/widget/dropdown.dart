part of 'widgets.dart';

class DropDownWeek extends StatelessWidget {
  final String title;
  final List<int> weeks;
  final WeeklyAddTaskController controller;

  const DropDownWeek({
    Key? key,
    required this.title,
    required this.weeks,
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
                    items: weeks
                        .map((e) => DropdownMenuItem<int>(
                            value: e, child: Text("WEEK $e")))
                        .toList(),
                    onChanged: (int? val) {
                      if (val != null) {
                        controller.changeWeek(val);
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
