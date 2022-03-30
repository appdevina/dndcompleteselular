part of 'screens.dart';

class Login extends GetView<LoginController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Form(
            key: controller.key,
            child: ListView(
              children: [
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
                                controller.obsecure.toggle();
                                controller.update(['password']);
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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 120),
                  child: MyButton(
                      label: "Login",
                      onTap: () async => await controller
                              .signIn(controller.userName!.text,
                                  controller.pass!.text)
                              .then((value) {
                            if (value.value!) {
                              Get.offAll(() => HomePage(),
                                  transition: Transition.cupertino);
                              snackbar(context, value.value!, value.message!);
                            } else {
                              snackbar(context, value.value!, value.message!);
                            }
                          }),
                      height: 40,
                      width: 70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _logo() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 50),
      height: 200,
      width: 200,
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/dndwhite.png'))),
    );
  }
}
