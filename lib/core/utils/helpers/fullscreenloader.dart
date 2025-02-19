import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenLoader{
  static void openingLoadingDialog(){
    showDialog(context: Get.overlayContext!, barrierDismissible: false,builder: (_)=> PopScope(canPop: false,child: Container(
      color: Colors.black12,
      width: double.infinity,
      height: double.infinity,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.white,)
        ],
      ),
    )));
  }
  static void stopLoading(){
    Navigator.of(Get.overlayContext!).pop;
  }
}