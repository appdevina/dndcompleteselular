part of 'screens.dart';

class ApproveTask extends StatelessWidget {
  final controller = Get.put(ApproveRequestController());
  ApproveTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: Text(
          'Belum ada request',
          style: blackFontStyle3.copyWith(color: white),
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          CupertinoIcons.back,
          color: white,
        ),
      ),
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Approval Request',
        style: blackFontStyle3.copyWith(
          color: white,
        ),
      ),
    );
  }
}
