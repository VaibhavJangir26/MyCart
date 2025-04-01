
import 'package:cartfunctionlity/controller/index.dart';
import 'package:cartfunctionlity/reuse_widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  


  TextEditingController changePasswordController = TextEditingController();

  final GlobalKey<FormState> changePasswordKey = GlobalKey<FormState>();


  
  @override
  Widget build(BuildContext context) {

    final authController= Get.put(AuthController());

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: ()=>Get.back(), icon: const Icon(Icons.arrow_back_ios)),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                const Text("Profile",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),

                Card(
                  elevation: 1,
                  color: Theme.of(context).cardColor,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.shade200,
                            radius: 25,
                          ),
                          title: CustomText(text: authController.userInfoModel.value?.displayName??"Guest",fontSize: 18,fontWeight: FontWeight.bold,textOverFlow: TextOverflow.ellipsis,maxLine: 1,),
                          subtitle: CustomText(text: authController.userInfoModel.value?.email??"guest@gmail.com",maxLine: 1,textOverFlow: TextOverflow.ellipsis,),
                        ),
                      ],
                    ),
                  ),
                ),


                Card(
                  elevation: 1,
                  color: Theme.of(context).cardColor,
                  child: Column(
                    children: [

                      frequentlyAskedQuestions(),

                      const Divider(),

                      help()

                    ],
                  ),
                ),


                const Text("Account & Privacy",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),


                Card(
                  elevation: 1,
                  color: Theme.of(context).cardColor,
                  child: Column(
                    children: [

                      /// this is edit profile
                      editProfile(),
                      const Divider(),





                      /// change the app password or not
                      changeUserPassword(),
                      const Divider(),


                      /// logout the current user
                      logoutButton()


                    ],
                  ),
                ),

          
              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget frequentlyAskedQuestions(){
    return const ExpansionTile(title:  Text("Frequently asked questions"),
      leading:  Icon(Icons.question_mark,color: Colors.blue,),
      shape:  RoundedRectangleBorder(),
      children: [
        ListTile(
          title:  CustomText(text: "1. How to change theme",color: Colors.grey,),
          subtitle:  Text("Change theme by using button on change theme"),
        ),
        Divider(),
        ListTile(
          title:  CustomText(text: "2. How to change theme",color: Colors.grey,),
          subtitle:  Text("Change theme by using button on change theme"),
        ),
        Divider(),
        ListTile(
          title:  CustomText(text: "3. How to change theme",color: Colors.grey),
          subtitle:  Text("Change theme by using button on change theme"),
        ),

      ],
    );
  }



  Widget help(){
    return ExpansionTile(title:  const Text("Help"),
      leading:  const Icon(Icons.help_outlined,color: Colors.blue,),
      shape:  const RoundedRectangleBorder(),
      children: [
        const ListTile(
          title:  Text("1. Help Center",),
          subtitle:  Text("Change theme by using button on change theme"),
        ),
        const Divider(),
        const ListTile(
          title:  Text("2. Contact us",),
          subtitle:  Text("For questions regarding this policy, please contact us at support@mycart.com or call at +91 1234567890"),
        ),
        const Divider(),
        ListTile(
          title:  const Text("3. Terms and Privacy Policy",),
          subtitle:  const Text("Read our Terms & Conditions, and Privacy policy"),
          onTap: ()=>Get.bottomSheet(Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              color: Theme.of(context).canvasColor,
            ),
            child: const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CustomText(text: "Welcome to MyCart! By accessing or using our e-commerce services, you agree to comply with our terms: All orders are subject to stock availability, accurate pricing, and shipping rules. Users must provide correct personal details and keep their account credentials safe. Any misuse, fraud, or violation may result in account restrictions. At MyCart, we value your privacy. We collect necessary data—such as name, address, and payment details—to process orders and improve your experience. Your information won't be shared with third parties without your consent, unless legally required. Please revisit our policies periodically for updates.",
                fontSize: 15,
                ),
              ),
            ),
          )),
        ),
      ],
    );
  }



  Widget editProfile(){
    final imagePickerController= Get.put(ImagePickerController());
    return ExpansionTile(title: const Text("Edit profile"),
      leading: const Icon(FontAwesomeIcons.userPen,color: Colors.blue,size: 19,),
      shape: const RoundedRectangleBorder(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListTile(
            leading: const Icon(Icons.edit,color: Colors.blue,),
            title: const Text("Edit user name"),
            onTap: (){},
          ),
        ),
        const Divider(),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListTile(
            leading: const Icon(Icons.image_outlined,color: Colors.blue,),
            title: const Text("Edit profile picture"),
            onTap: (){
              Get.defaultDialog(
                backgroundColor: Theme.of(context).canvasColor,
                title: "Select Image",
                content: const CustomText(text: "Select the mode for choosing images.",fontSize: 18,),
                actions: [
                  ListTile(
                    leading: const Icon(Icons.photo),
                    title: const Text("Gallery"),
                    onTap: () async {
                      await imagePickerController.pickImageFromGallery();
                      Get.back();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text("Camera"),
                    onTap: () async {
                      await imagePickerController.pickImageFromCamera();
                      Get.back();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }



  Widget changeUserPassword() {
    final authController = Get.put(AuthController());
    final TextEditingController changePasswordController = TextEditingController();
    final GlobalKey<FormState> changePasswordKey = GlobalKey<FormState>();

    return ListTile(
      leading: const Icon(Icons.key, color: Colors.blue),
      title: const Text("Change password"),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Get.bottomSheet(
          Container(
            width: Get.width,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Get.theme.canvasColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Enter new password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 10),
                Form(
                  key: changePasswordKey,
                  child: TextFormField(
                    controller: changePasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter new password";
                      } else if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "New Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: Get.width * .6,
                    child: Obx(() => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        if (changePasswordKey.currentState!.validate()) {
                          authController.changePassword(changePasswordController.text.trim());
                        }
                      },
                      child: authController.isLoading.value
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                      )
                          : const Text("Change password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    )),
                  ),
                )
              ],
            ),
          ),
          isScrollControlled: true,
        );
      },
    );
  }



  Widget logoutButton(){
    final authController= Get.put(AuthController());
    return ListTile(
      leading: const Icon(Icons.logout,color: Colors.blue,),
      title: const Text("Logout"),
      onTap: (){
        authController.logout();
      },
    );
  }






}



