part of 'widgets.dart';

class DropDownStatus extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> opsi;
  final DetailDailyController controller;

  const DropDownStatus({
    Key? key,
    required this.title,
    required this.opsi,
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
                    items: opsi
                        .map((e) => DropdownMenuItem<int>(
                            value: e['no'], child: Text(e['status'])))
                        .toList(),
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
