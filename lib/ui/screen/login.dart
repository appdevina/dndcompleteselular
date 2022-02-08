part of 'screens.dart';

class Login extends GetView<LoginController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          child: Form(
            key: controller.key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Spacer(),
                _logo(),
                SizedBox(
                  child: Column(
                    children: [
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
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                MyButton(
                    label: "Login",
                    onTap: () => Get.offAll(() => HomePage(),
                        transition: Transition.cupertino),
                    height: 40,
                    width: 70),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _logo() {
    return Column(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/user.png'),
          backgroundColor: white,
        ),
        Text(
          'To Do List Mobile',
          style: blackFontStyle3.copyWith(color: white, fontSize: 20),
        )
      ],
    );
  }
}
