import 'package:cartfunctionlity/controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cartfunctionlity/authentication/index.dart';

import '../methods/toast_msg.dart';
import '../reuse_widgets/custom_text.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool isChecked = false;
  final ValueNotifier<bool> isPassVisibleNotifier = ValueNotifier<bool>(false);
  final _formKey = GlobalKey<FormState>();

  void showPassword() {
    isPassVisibleNotifier.value = !isPassVisibleNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

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
                ]),
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: keyboardHeight),
              child: Container(
                width: width * .85,
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min, // Allow it to shrink if needed
                    children: [
                      const Text(
                        "Create an account",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (nameController.text.isEmpty) {
                            return "Enter the Name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Full Name",
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey)),
                        ),
                      ),
                      const SizedBox(height: 5),
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
                            return "Enter a valid email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey)),
                        ),
                      ),
                      const SizedBox(height: 5),
                      ValueListenableBuilder(
                        valueListenable: isPassVisibleNotifier,
                        builder: (context, value, _) {
                          return TextFormField(
                            controller: passwordController,
                            obscureText: !value,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (passwordController.text.isEmpty) {
                                return "Enter the Password";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: showPassword,
                                icon: value
                                    ? const Icon(Icons.remove_red_eye)
                                    : const Icon(CupertinoIcons.eye_slash_fill),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 5),
                      checkBoxList(),
                      signupButton(),
                      continueWith(),
                      otherSignupOptions(),
                      SizedBox(height: height * .005),
                      moveToLoginScreen(),
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

  Widget signupButton() {
    final authController = Get.put(AuthController());
    return SizedBox(
      width: 120,
      child: Obx(
        () => ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {
            if (!isChecked) {
              ToastMsg.showToastMsg(
                  "Please accept the T&Cs and Privacy Policy");
            }
            if (_formKey.currentState!.validate() && isChecked) {
              authController.signup(
                  emailController.text.toString(),
                  passwordController.text.toString(),
                  nameController.text.toString());
            }
          },
          child: authController.isLoading.value
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2.5))
              : const Text(
                  "Register",
                  style: TextStyle(fontSize: 15),
                ),
        ),
      ),
    );
  }

  Widget checkBoxList() {
    return CheckboxListTile(
      value: isChecked,
      activeColor: Colors.blue,
      controlAffinity: ListTileControlAffinity.leading,
      title: const Text(
        "By clicking this you accept our T&Cs. and Privacy Policy.",
        style: TextStyle(fontSize: 11),
      ),
      onChanged: (bool? value) {
        setState(() {
          isChecked = value ?? false;
        });
      },
    );
  }

  Widget continueWith() {
    return Container(
      alignment: Alignment.center,
      child: const Text("--or Continue with--"),
    );
  }

  Widget otherSignupOptions() {
    final authController = Get.put(AuthController());
    return InkWell(
      onTap: (){
        authController.signInWithGoogle();
      },
      child: Card(
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.all(4),
          alignment: Alignment.center,
          child: const Row(
            children: [
              CircleAvatar(
                foregroundImage: AssetImage("assets/images/icons/googleLogo.png"),
                foregroundColor: Colors.grey,
              ),
              SizedBox(width: 10),
              CustomText(text: "Sign up with Google", fontSize: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget moveToLoginScreen() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        const SizedBox(width: 5),
        InkWell(
          onTap: () => Get.to(() => const Login()),
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.pink),
          ),
        ),
      ],
    );
  }
}
