import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/screens/profile/edit_profile/edit_profile_controller.dart';

class EditProfileWidget {
  static commomText(String title, {bool? isMandatory = false}) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
      child: isMandatory!
          ? Row(
              children: [
                Text(title,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: HexColor('#111111'),
                        fontSize: 16.sp - commonFontSize)),
                Text('*',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: HexColor('#EF5E4E'),
                        fontSize: 16.sp - commonFontSize)),
              ],
            )
          : Text(title,
              style: TextStyle(
                  fontFamily: 'Inter',
                  color: HexColor('#111111'),
                  fontSize: 16.sp - commonFontSize)),
    );
  }

  Future<void> showSelectionDialog(
    BuildContext context,
  ) {
    return Get.bottomSheet(Container(
      width: double.infinity,
      height: 250.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
          color: Colors.black87),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
            child: Text(
              "Choose one to upload a picture",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp - commonFontSize, color: Colors.white),
            )),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                selectionCont(
                  'Gallery',
                  'assets/icons/pictures.png',
                  1,
                ),
                SizedBox(
                  width: 25.w,
                ),
                selectionCont(
                  'Camera',
                  'assets/icons/camera.png',
                  2,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp - commonFontSize, color: Colors.white),
              )),
        ),
      ]),
    ));
  }

  static selectionCont(
    String selectionTypeStr,
    String selectionIconStr,
    int btnTag,
  ) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Material(
        color: Colors.black87,
        child: StatefulBuilder(
          builder: (context, setState) => InkWell(
            onTap: () {
              if (btnTag == 1) {
                Navigator.pop(context);
                getFromGallery();
              } else {
                Navigator.pop(context);
                getFromCamera();
              }
            }, // button pressed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  selectionIconStr,
                  width: 60.0,
                  height: 60.0,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  selectionTypeStr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//get from gallery
  static getFromGallery() async {
    final profileCntrl = Get.find<EditProfileController>();
    dynamic pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileCntrl.selectedImage.value = pickedFile;
      profileCntrl.selectedImage.refresh();
    } else {
      return null;
    }
  }

  /// Get from Camera
  static getFromCamera() async {
    final profileCntrl = Get.find<EditProfileController>();
    dynamic pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      profileCntrl.selectedImage.value = pickedFile;
      profileCntrl.selectedImage.refresh();
    } else {
      return null;
    }
  }
}
