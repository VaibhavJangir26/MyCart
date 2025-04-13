import 'package:cartfunctionlity/authentication/index.dart';
import 'package:cartfunctionlity/controller/auth_controller.dart';
import 'package:cartfunctionlity/reuse_widgets/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(false);

  void showPassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xfffff1eb),
                Color(0xfface0f9),
              ])),
            ),
            SingleChildScrollView(
              child: Container(
                width: width * .85,
                height: height * .8,
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Welcome Back!",
                        style: TextStyle(
                            fontSize: 33, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        enableSuggestions: true,
                        enableIMEPersonalizedLearning: true,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (emailController.text.isEmpty) {
                            return "Enter the email";
                          }
                          if (!value!.contains('@')) {
                            return "Enter a valid mail";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: const Icon(
                              Icons.email,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey))),
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      ValueListenableBuilder(
                        valueListenable: isPasswordVisible,
                        builder: (context, value, _) {
                          return TextFormField(
                            controller: passwordController,
                            obscureText: value ? false : true,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (passwordController.text.isEmpty) {
                                return "Enter the Password";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: const Icon(
                                  Icons.lock,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: showPassword,
                                  icon: value
                                      ? const Icon(Icons.remove_red_eye)
                                      : const Icon(
                                          CupertinoIcons.eye_slash_fill),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.grey))),
                          );
                        },
                      ),
                      forgotPassword(height, width),
                      loginButton(height, width),
                      const OrContinueWithText(),
                      const ContinueWithGoogleButton(),
                      SizedBox(
                        height: height * .005,
                      ),
                      newRegister(height, width),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget forgotPassword(double height, double width) {
    return InkWell(
      onTap: () => Get.to(() => const ForgotPasswordScreen()),
      child: Container(
        width: width,
        height: height * .04,
        alignment: Alignment.centerRight,
        child: const Text(
          "forgot password?",
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }

  Widget loginButton(double height, double width) {
    final authController = Get.put(AuthController());
    return Container(
      width: width * .6,
      height: height * .095,
      padding: const EdgeInsets.all(8),
      child: Obx(() => ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                authController.login(emailController.text.toString(),
                    passwordController.text.toString());
              }
            },
            child: authController.isLoading.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                    ))
                : const Text(
                    "Login",
                    style: TextStyle(fontSize: 15),
                  ),
          )),
    );
  }

  Widget newRegister(double height, double width) {
    return Container(
      width: width,
      height: height * .05,
      padding: const EdgeInsets.all(4),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Create an Account?"),
          SizedBox(
            width: width * .025,
          ),
          InkWell(
              onTap: () => Get.to(() => const Signup()),
              child: const Text(
                "Sign Up",
                style: TextStyle(color: Colors.pink),
              )),
        ],
      ),
    );
  }
}
