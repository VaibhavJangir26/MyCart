import 'package:cartfunctionlity/utilities/bottom_nav_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../authentication/index.dart';
import '../methods/toast_msg.dart';
import '../models/user_model/user_info_model.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;
  var userInfoModel = Rxn<UserInfoModel>();


  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen(onAuthChanged);
  }

  Future<void> onAuthChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      userInfoModel.value = null;
    } else {
      final doc = await _firestore
          .collection('userDetails')
          .doc(firebaseUser.uid)
          .get();
      if (doc.exists) {
        userInfoModel.value = UserInfoModel.fromJson(doc.data()!);
      } else {
        userInfoModel.value = UserInfoModel(
          uuid: firebaseUser.uid,
          displayName: firebaseUser.displayName ?? "Guest",
          email: firebaseUser.email ?? "guest@gmail.com",
        );
        await _firestore
            .collection('userDetails')
            .doc(firebaseUser.uid)
            .set(userInfoModel.value!.toJson());
      }
    }
  }



  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    isLoading.value = true;
    try {
      await googleSignIn.signOut();
      await _auth.signOut();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final doc = await _firestore.collection('userDetail').doc(user.uid).get();
        if (!doc.exists) {
          userInfoModel.value = UserInfoModel(
            uuid: user.uid,
            displayName: user.displayName ?? "Unknown User",
            email: user.email ?? "Unknown Email",
          );
          await _firestore.collection('userDetails').doc(user.uid).set(userInfoModel.value!.toJson());
        } else {
          userInfoModel.value = UserInfoModel.fromJson(doc.data() as Map<String, dynamic>);
        }
        Get.offAll(() => const BottomNavBarWidget());
      }
      return user;
    } on FirebaseAuthException catch (e) {
      ToastMsg.showToastMsg(e.toString());
      return null;
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = userCredential.user;
      if (user != null) {
        final doc =
            await _firestore.collection('userDetails').doc(user.uid).get();
        if (doc.exists) {
          userInfoModel.value = UserInfoModel.fromJson(doc.data()!);
        }
        Get.offAll(() => const BottomNavBarWidget());
      }
    } on FirebaseAuthException catch (e) {
      ToastMsg.showToastMsg(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup(String email, String password, String name) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        userInfoModel.value = UserInfoModel(
          uuid: user.uid,
          displayName: name,
          email: user.email ?? "guest@gmail.com",
        );
        await _firestore
            .collection('userDetails')
            .doc(user.uid)
            .set(userInfoModel.value!.toJson());
        Get.offAll(() => const BottomNavBarWidget());
      }
    } on FirebaseAuthException catch (e) {
      ToastMsg.showToastMsg(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changePassword(String newPassword) async {
    isLoading.value = true;
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        ToastMsg.showToastMsg("Password updated successfully");
      }
    } on FirebaseAuthException catch (e) {
      ToastMsg.showToastMsg(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await googleSignIn.disconnect();
      await googleSignIn.signOut();
      await _auth.signOut();
      userInfoModel.value = null;
      Get.offAll(() => const Login());
    } on FirebaseAuthException catch (e) {
      ToastMsg.showToastMsg(e.toString());
    }
  }
}
