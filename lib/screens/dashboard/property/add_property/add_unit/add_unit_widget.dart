import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_property_widgets.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_unit/add_unit_controller.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/text_styles.dart';

class AddUnitWidget {
  appBar(String title) {
    return AppBar(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: backArrowImage,
        ),
      ),
      centerTitle: true,
      title: Text(title, style: CustomStyles.otpStyle050505W700S16),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          height: 1,
          color: lightBorderGrey,
        ),
      ),
    );
  }

  commomText(String title, {bool? isMandatory = false}) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
      child: isMandatory!
          ? Row(
              children: [
                Text(title,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: HexColor('#111111'),
                        fontSize: 16.sp)),
                Text('*',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: HexColor('#EF5E4E'),
                        fontSize: 16.sp)),
              ],
            )
          : Text(title,
              style: TextStyle(
                  fontFamily: 'Inter',
                  color: HexColor('#111111'),
                  fontSize: 16.sp)),
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
              style: TextStyle(fontSize: 14.sp, color: Colors.white),
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
                style: TextStyle(fontSize: 14.sp, color: Colors.white),
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
    final addUnitController = Get.find<AddUnitController>();
    dynamic pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      addUnitController.unitPickedImage.add({
        "id": -1,
        "image": pickedFile,
        "isNetwork": false,
        "isDelete": false
      });
    } else {
      return null;
    }
  }

  /// Get from Camera
  static getFromCamera() async {
    final addUnitController = Get.find<AddUnitController>();
    dynamic pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      addUnitController.unitPickedImage.add({
        "id": -1,
        "image": pickedFile,
        "isNetwork": false,
        "isDelete": false
      });
    } else {
      return null;
    }
  }

  addMultipleUnits({
    required String title,
    required String button1,
    required String button2,
    required Function() onButton1Tap,
    required Function() onButton2Tap,
  }) async {
    final addUnitCntrl = Get.find<AddUnitController>();
    return await Get.dialog(
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.r,
        ),
        child: Center(
          child: Material(
            borderRadius: BorderRadius.circular(
              18.r,
            ),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 400.w, // Adjust the max width as needed
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    18.r,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          title,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AddPropertyWidget()
                              .commomText('No. of Units', isMandatory: false),
                          customTextField(
                            controller: addUnitCntrl.numberOfUnits.value,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            textInputAction: TextInputAction.done,
                            hintText: 'Type Here...',
                            isBorder: true,
                            isFilled: false,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customBorderButton(
                            button1,
                            onButton1Tap,
                            verticalPadding: 5.h,
                            horizontalPadding: 2.w,
                            btnHeight: 35.h,
                            width: 140.w,
                            borderColor: HexColor('#679BF1'),
                            textColor: HexColor('#679BF1'),
                          ),
                          customBorderButton(
                            button2,
                            onButton2Tap,
                            verticalPadding: 5.h,
                            horizontalPadding: 2.w,
                            btnHeight: 35.h,
                            color: HexColor('#679BF1'),
                            textColor: Colors.white,
                            width: 140.w,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
