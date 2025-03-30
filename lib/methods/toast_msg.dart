import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastMsg{

  static void showToastMsg(String msg){
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.blue.shade300,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 2,
    );
  }

}