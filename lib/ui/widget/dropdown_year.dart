part of 'widgets.dart';

class DropDownYear extends StatelessWidget {
  final String title;
  final List<int> years;
  final WeeklyAddTaskController controller;

  const DropDownYear({
    Key? key,
    required this.title,
    required this.years,
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
                    items: years
                        .map((e) => DropdownMenuItem<int>(
                            value: e, child: Text(e.toString())))
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
