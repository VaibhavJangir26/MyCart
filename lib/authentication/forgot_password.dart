import 'package:cartfunctionlity/authentication/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../methods/toast_msg.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {


  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();



  Future<void> resetPassword(String email) async {
    isLoading.value = true;
    try {
      await auth.sendPasswordResetEmail(email: email).then((value) {
        isLoading.value = false;
        ToastMsg.showToastMsg("Email is sent successfully for password reset");
        Get.to(()=>const Login());
      }).onError((error, stackTrace) {
        isLoading.value = false;
        ToastMsg.showToastMsg(error.toString());
      });
    } on FirebaseException catch (e) {
      isLoading.value = false;
      ToastMsg.showToastMsg(e.toString());
    }
  }

  @override
  void dispose() {
    isLoading.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Stack(
            alignment: Alignment.center,
            children: [


              Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xfffff1eb), Color(0xfface0f9)],
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    const Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.cyan,
                      ),
                    ),

                    const Text(
                      "We will send you a link to reset your password. Please follow the instructions in the email to change your password.",
                      style: TextStyle(color: Colors.pink),
                    ),


                    SizedBox(height: height * 0.02),


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
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),


                    SizedBox(height: height * 0.02),

                    ValueListenableBuilder<bool>(
                      valueListenable: isLoading,
                      builder: (context, loading, child) {
                        return SizedBox(
                          width: width / 2,
                          child: ElevatedButton(
                            onPressed: loading
                                ? null
                                : () {
                              if (_formKey.currentState!.validate()) {
                                resetPassword(
                                    emailController.text.toString());
                              }
                            },
                            child: loading
                                ? const CircularProgressIndicator(strokeWidth: 2)
                                : const Text(
                              "Send",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      },
                    ),


                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
