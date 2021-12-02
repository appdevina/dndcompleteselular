part of 'screens.dart';

class Login extends GetView<LoginController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: white,
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _logo(),
            MyInputField(
              title: 'Username',
              controllerText: controller.userName,
              hint: 'Username',
              isPassword: false,
            ),
            GetBuilder<LoginController>(
              id: 'password',
              builder: (_) => MyInputField(
                title: 'Password',
                controllerText: controller.pass,
                hint: 'Password',
                isPassword: true,
                obsecure: controller.obsecure.value,
                widget: IconButton(
                    onPressed: () {
                      controller.open();
                    },
                    icon: controller.obsecure.value
                        ? const Icon(MdiIcons.eye)
                        : const Icon(MdiIcons.eyeOff)),
              ),
            ),
            MyButton(label: "Login", onTap: () {}, height: 40, width: 70)
          ],
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'ToDoListMobile',
        style: blackFontStyle3,
      ),
    );
  }

  _logo() {
    return const CircleAvatar(
      backgroundImage: AssetImage('assets/user.png'),
      backgroundColor: white,
    );
  }
}
