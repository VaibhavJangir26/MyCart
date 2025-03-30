


import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class ImagePickerController extends GetxController {
  var selectedImage = Rx<File?>(null);
  var isUploading = false.obs;
  var isDeleting= false.obs;
  final ImagePicker _picker = ImagePicker();



  var uploadedImageUrl="".obs;

  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    } else {
      Get.snackbar("Error", "No image selected", snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImage.value = File(image.path);
    } else {
      Get.snackbar("Error", "No image selected", snackPosition: SnackPosition.BOTTOM);
    }
  }








}

