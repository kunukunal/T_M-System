import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/landlord_screens/onboarding/auth/login_view/auth_controller.dart';

//**********************Common Text Field****************************
customTextField({
  TextEditingController? controller,
  Function()? onTap,
  Function(String value)? onChange,
  Function(String value)? onSubmitted,
  bool isForCountryCode = false,
  FocusNode? focusNode,
  Color? color,
  bool autofocus = false,
  String? hintText,
  Widget? suffixIcon,
  Widget? prefixIcon,
  bool? isFilled,
  TextStyle? hintStyle,
  bool? isBorder,
  int? maxLines,
  int? maxLength,
  double? width,
  bool? readOnly,
  TextInputAction? textInputAction,
  TextInputType? keyboardType,
  List<TextInputFormatter>? inputFormatters,
  bool? obscureText,
  bool onDropdownChanged = true,
}) {
  return Container(
    width: width ?? Get.width,
    decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        border: isBorder == true
            ? Border.all(color: HexColor('#EBEBEB'), width: 2)
            : Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(8.r)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        isForCountryCode
            ? dropDownMenu(onDropdownChanged: onDropdownChanged)
            : Container(),
        Expanded(
          child: TextFormField(
            maxLength: maxLength,
            maxLines: maxLines ?? 1,
            obscureText: obscureText ?? false,
            controller: controller,
            focusNode: focusNode,
            readOnly: readOnly ?? false,
            keyboardType: keyboardType ?? TextInputType.name,
            textInputAction: textInputAction ?? TextInputAction.next,
            autofocus: autofocus,
            inputFormatters: inputFormatters,
            strutStyle: StrutStyle.fromTextStyle(CustomStyles.lightHint16),
            onTap: onTap ?? () {},
            onChanged: onChange,
            onFieldSubmitted: onSubmitted,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
              hintText: hintText,
              suffixIcon: Padding(
                padding: EdgeInsets.all(8.r),
                child: suffixIcon,
              ),
              hintStyle: hintStyle ?? CustomStyles.hintText,
              filled: isFilled ?? true,
              counterText: '',
              fillColor: HexColor('#EBF1F6'),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.r)),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget dropDownMenu({bool onDropdownChanged = true}) {
  final authCntrl = Get.find<AuthController>();
  return Obx(() {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: DropdownButton(
        icon: Visibility(
          visible: true,
          child: dropDownArrowIcon,
        ),
        underline: Container(),
        value: authCntrl.selectedItem.value,
        items: authCntrl.items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: CustomStyles.titleText,
            ),
          );
        }).toList(),
        onChanged: onDropdownChanged
            ? (item) {
                authCntrl.selectedItem.value = item.toString();
              }
            : null,
      ),
    );
  });
}

//**********************Common Button****************************
customButton(
    {required Function() onPressed,
    String? text,
    Widget? suffix,
    TextStyle? textStyle,
    double? verticalPadding,
    Color? color,
    double? height,
    double? borderRadius,
    double? width}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 0.h),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(10.r),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r)),
        backgroundColor: color ?? HexColor('#679BF1'),
        maximumSize: Size(width ?? 175.w, height ?? 44.h),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          text != null
              ? Text(
                  text,
                  textAlign: TextAlign.center,
                  style: textStyle ?? CustomStyles.white16,
                )
              : Container(),
          suffix != null
              ? Row(
                  children: [
                    text != null
                        ? SizedBox(
                            width: 5.w,
                          )
                        : Container(),
                    SizedBox(height: 20.h, width: 20.w, child: suffix)
                  ],
                )
              : Container()
        ],
      ),
    ),
  );
}

//**********************Custom Drop Down****************************
bigDropDown(
    {required String selectedItem,
    required List items,
    bool isReadOnly = false,
    required Function(String) onChange,
    Color? color,
    double? width}) {
  return Container(
    height: 44.h,
    width: width ?? Get.width,
    decoration: BoxDecoration(
        color: color ?? whiteColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: HexColor('#EBEBEB'), width: 2)),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: DropdownButton(
        isExpanded: true,
        icon: dropDownArrowIcon,
        underline: Container(),
        value: selectedItem,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: CustomStyles.hintText,
            ),
          );
        }).toList(),
        onChanged: isReadOnly
            ? null
            : (item) {
                onChange(item.toString());
              },
      ),
    ),
  );
}

backArrowIcon() {
  return InkWell(
    onTap: () {
      Get.back();
    },
    child: Container(
      height: 40.h,
      width: 40.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: HexColor('#EBEBEB')),
      ),
      child: const Icon(
        Icons.arrow_back_ios_new,
        size: 15,
      ),
    ),
  );
}

customSnackBar(BuildContext context, String msgStr) {
  showSimpleNotification(
      Container(
        // height: 80.0,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.4, 0.8),
            colors: <Color>[
              // primaryBlue,
              // backgroundColor,
              // secondaryGreen
              Color(0xff009FFD),
              Color(0xff2A2A72),
            ],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              msgStr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      background: Colors.transparent,
      slideDismiss: true,
      duration: const Duration(seconds: 3));
}

notification(BuildContext context, String title, String subtitle) {
  showSimpleNotification(
      Container(
        // height: 80.0,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.4, 0.8),
            colors: <Color>[
              // primaryBlue,
              // backgroundColor,
              // secondaryGreen
              Color(0xff009FFD),
              Color(0xff2A2A72),
            ],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      background: Colors.transparent,
      slideDismiss: true,
      duration: const Duration(seconds: 3));
}

resgisterPopup({
  required String title,
  required String subtitle,
  required String button1,
  required String button2,
  required Function() onButton1Tap,
  required Function() onButton2Tap,
}) async {
  return await Get.dialog(
    AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.r),
      ),
      titlePadding: EdgeInsets.only(top: 5.h, left: 14.w, right: 14.w),
      contentPadding: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 14.h),
      title: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  color: black,
                  fontSize: 18.sp - commonFontSize,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          // Spacer(),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: crossIcon,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6.0, top: 12.0),
            child: Text(
              subtitle,
              textAlign: TextAlign.start,
              style: title == 'Logout'
                  ? CustomStyles.otpStyle050505.copyWith(
                      fontFamily: 'DM Sans',
                      fontSize: 16.sp - commonFontSize,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.none)
                  : TextStyle(
                      fontFamily: 'Inter',
                      decoration: TextDecoration.none,
                      height: 1.4,
                      color: HexColor('#6C6C6C'),
                      fontSize: 16.sp - commonFontSize - commonFontSize,
                      fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: customBorderButton(
                  button1,
                  onButton1Tap,
                  verticalPadding: 5.h,
                  horizontalPadding: 2.w,
                  btnHeight: title == 'Logout' ? 42.h : 35.h,
                  width: 140.w,
                  borderColor: HexColor('#679BF1'),
                  textColor: HexColor('#679BF1'),
                ),
              ),
              title == 'Logout'
                  ? customButton(
                      onPressed: onButton2Tap,
                      text: button2,
                      width: 140.w,
                      height: 42.h,
                    )
                  : customBorderButton(
                      button2,
                      onButton2Tap,
                      verticalPadding: 5.h,
                      horizontalPadding: 2.w,
                      btnHeight: 35.h,
                      width: 140.w,
                    ),
            ],
          ),
        ],
      ),
    ),
    barrierDismissible: true,
  );
}

deletePopup({
  required String title,
  required String subtitle,
  required String button1,
  required String button2,
  required TextEditingController deleteController,
  required Function() onButton1Tap,
  required Function() onButton2Tap,
}) async {
  return await Get.dialog(
    AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.r),
      ),
      titlePadding: EdgeInsets.only(top: 5.h, left: 14.w, right: 14.w),
      contentPadding: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 14.h),
      title: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  color: black,
                  fontSize: 18.sp - commonFontSize,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          // Spacer(),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: crossIcon,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6.0, top: 12.0),
            child: Text(
              subtitle,
              textAlign: TextAlign.start,
              style: title == 'Logout'
                  ? CustomStyles.otpStyle050505.copyWith(
                      fontFamily: 'DM Sans',
                      fontSize: 16.sp - commonFontSize,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.none)
                  : TextStyle(
                      fontFamily: 'Inter',
                      decoration: TextDecoration.none,
                      height: 1.4,
                      color: HexColor('#6C6C6C'),
                      fontSize: 16.sp - commonFontSize - commonFontSize,
                      fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 10.h),
          TextFormField(
            controller: deleteController,
            decoration: InputDecoration(
              hintText: "Type \"Delete\" text",
              hintStyle: TextStyle(color: Colors.red),
              prefixIconConstraints: BoxConstraints.loose(Size(35.w, 35.h)),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: lightBorderGrey),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: lightBorderGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: lightBorderGrey),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: customBorderButton(
                  button1,
                  onButton1Tap,
                  verticalPadding: 5.h,
                  horizontalPadding: 2.w,
                  btnHeight: title == 'Logout' ? 42.h : 35.h,
                  width: 140.w,
                  borderColor: HexColor('#679BF1'),
                  textColor: HexColor('#679BF1'),
                ),
              ),
              title == 'Logout'
                  ? customButton(
                      onPressed: onButton2Tap,
                      text: button2,
                      width: 140.w,
                      height: 42.h,
                    )
                  : customBorderButton(
                      button2,
                      onButton2Tap,
                      verticalPadding: 5.h,
                      horizontalPadding: 2.w,
                      btnHeight: 35.h,
                      width: 140.w,
                    ),
            ],
          ),
        ],
      ),
    ),
    barrierDismissible: true,
  );
}

/*
  showDialog<bool>(
    context: Get.context!,
    builder: (ctx) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Registration",
              style: TextStyle(
                // color: textColor,
                  fontSize: 16.sp - commonFontSize,
                  fontWeight: FontWeight.w700),
            ),
            IconButton(onPressed: (){}, icon:const Icon(Icons.highlight_remove) )
          ],
        ),
        content: Text(
          "Join us today and experience the daily benefits of freshness firsthand!",
          style: TextStyle(fontSize: 13.sp - commonFontSize),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Get.to(()=>const SignUpScreen());
              },
              child: const Text("Landlord")),
          ElevatedButton(
              onPressed: () {
                Get.to(()=>const SignUpScreen());
              },
              child: const Text("Tenants")),
        ],
      );
    },
  );
  */

//Common Button
Widget customBorderButton(
  String btnName,
  VoidCallback onTap, {
  double? verticalPadding,
  Color? borderColor,
  Color? textColor,
  Color? color,
  double? btnHeight,
  double? width,
  double? fontSize,
  double? horizontalPadding,
  FontWeight? fontweight,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 10.w,
          vertical: verticalPadding ?? 40.h),
      child: Container(
        height: btnHeight ?? 45.h,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: borderColor ?? HexColor('#606060'),
            ),
            color: color ?? HexColor('#FFFFFF')),
        child: Center(
          child: Text(
            btnName,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: textColor ?? HexColor('#606060'),
                decoration: TextDecoration.none,
                fontSize: fontSize ?? 16.sp - commonFontSize,
                fontWeight: fontweight ?? FontWeight.w600),
          ),
        ),
      ),
    ),
  );
}

Widget customBorderWithIconButton(
  String btnName,
  VoidCallback onTap, {
  double? verticalPadding,
  Color? borderColor,
  Color? textColor,
  Color? color,
  double? btnHeight,
  double? width,
  double? fontSize,
  double? horizontalPadding,
  FontWeight? fontweight,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 10.w,
          vertical: verticalPadding ?? 40.h),
      child: Container(
        height: btnHeight ?? 45.h,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: borderColor ?? HexColor('#606060'),
            ),
            color: color ?? HexColor('#FFFFFF')),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              btnName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: textColor ?? HexColor('#606060'),
                  decoration: TextDecoration.none,
                  fontSize: fontSize ?? 16.sp - commonFontSize,
                  fontWeight: fontweight ?? FontWeight.w600),
            ),
            // Image.asset(
            //   "assets/icons/get_started_button_icon.png",
            //   color: textColor,
            //   height: 25.h,
            //   width: 25.w,
            // )
          ],
        ),
      ),
    ),
  );
}

customListTile(
    {required bool isExpanded,
    Color? color,
    bool? isDivider,
    double? elevation,
    required String name,
    String? subTitle,
    required Image suffixUrl,
    String? description,
    required Function() onTap}) {
  return Card(
    elevation: elevation,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    child: Column(
      children: [
        InkWell(
          onTap: () {
            onTap();
          },
          child: Container(
            padding: EdgeInsets.all(5.r),
            width: double.infinity,
            decoration: BoxDecoration(
                color: color ?? HexColor('#F8F8F8'),
                borderRadius: isExpanded
                    ? BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r))
                    : BorderRadius.circular(12.r)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 2,
                        style: CustomStyles.otpStyle050505.copyWith(
                            fontSize: 16.sp - commonFontSize,
                            fontFamily: 'DM Sans'),
                      ),
                      subTitle == null
                          ? Container()
                          : Text(
                              subTitle,
                              style: CustomStyles.lightHint16
                                  .copyWith(color: HexColor('#5A5A5A')),
                            ),
                    ],
                  ),
                )),
                isExpanded || isDivider != null
                    ? Container()
                    : SizedBox(
                        height: 50.h,
                        child: VerticalDivider(
                          thickness: 2,
                          color: HexColor('#000000').withOpacity(.25),
                        ),
                      ),
                Padding(padding: EdgeInsets.all(15.r), child: suffixUrl)
              ],
            ),
          ),
        ),
        isExpanded
            ? Container(
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.r),
                        bottomRight: Radius.circular(12.r))),
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(
                          left: 15.w, right: 40.w, top: 0.h, bottom: 15.h),
                      child: Text(
                        description!,
                        maxLines: 5,
                        textAlign: TextAlign.start,
                        style: CustomStyles.otpStyle050505.copyWith(
                            fontSize: 14.sp - commonFontSize,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w400),
                      ),
                    ))
                  ],
                ),
              )
            : Container()
      ],
    ),
  );
}

//This will trigger when user press back from Navbar
willPopScope() async {
  return await showDialog<bool>(
    context: Get.context!,
    builder: (ctx) {
      return AlertDialog(
        title: Center(
          child: Text(
            "Please Confirm",
            style: TextStyle(
                // color: textColor,
                fontSize: 16.sp - commonFontSize,
                fontWeight: FontWeight.w700),
          ),
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Text(
            "Are you sure you want to exit?",
            style: TextStyle(fontSize: 13.sp - commonFontSize),
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop(true);
              },
              child: const Text("Yes")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop(false);
              },
              child: const Text("No")),
        ],
      );
    },
  );
}

commonText({String? title}) {
  return Text(
    title!,
    style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16.sp - commonFontSize,
        color: black),
  );
}

appBar(
    {required String title,
    bool isBack = true,
    List<Widget>? actions,
    bool isrefreshReuquired = false}) {
  return AppBar(
    centerTitle: true,
    automaticallyImplyLeading: false,
    surfaceTintColor: Colors.transparent,
    leading: isBack
        ? InkWell(
            onTap: () {
              Get.back(result: isrefreshReuquired);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: backArrowImage,
            ),
          )
        : const SizedBox.shrink(),
    title: Text(title, style: CustomStyles.otpStyle050505W700S16),
    actions: actions,
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1.h),
      child: Divider(
        height: 1,
        color: lightBorderGrey,
      ),
    ),
  );
}
//Decline Popup

commonDeclinePopup({
  required String title,
  required String subtitle,
  required String button1,
  required String button2,
  required Function() onButton1Tap,
  required Function() onButton2Tap,
}) async {
  return await Get.dialog(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 270.h),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                18.r,
              )),
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                title != ''
                    ? Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                  color: HexColor('#111111'),
                                  fontSize: 20.sp - commonFontSize,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w700),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: crossIcon)
                          ],
                        ),
                      )
                    : const SizedBox(),
                SizedBox(
                  height: title != '' ? 15.h : 0.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 0,
                  ),
                  child: Text(subtitle,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp - commonFontSize,
                          color: black)),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customBorderButton(button1, onButton1Tap,
                        verticalPadding: 5.h,
                        horizontalPadding: 2.w,
                        btnHeight: 30.h,
                        width: 140.w,
                        fontweight: FontWeight.w500,
                        borderColor: HexColor('#679BF1'),
                        textColor: HexColor('#679BF1')),
                    customBorderButton(button2, onButton2Tap,
                        fontweight: FontWeight.w500,
                        verticalPadding: 5.h,
                        horizontalPadding: 2.w,
                        btnHeight: 30.h,
                        width: 140.w,
                        color: HexColor('#679BF1'),
                        textColor: HexColor('#FFFFFF'),
                        borderColor: Colors.transparent)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: true);
}

deleteFloorPopup({
  required String title,
  required String button1,
  required String button2,
  required Function() onButton1Tap,
  required Function() onButton2Tap,
}) async {
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
                      child: Text(title,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp - commonFontSize,
                              fontWeight: FontWeight.w700)),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customBorderButton(button1, onButton1Tap,
                            verticalPadding: 5.h,
                            horizontalPadding: 2.w,
                            btnHeight: 35.h,
                            width: 140.w,
                            borderColor: HexColor('#679BF1'),
                            textColor: HexColor('#679BF1')),
                        customBorderButton(
                          button2,
                          onButton2Tap,
                          verticalPadding: 5.h,
                          horizontalPadding: 2.w,
                          btnHeight: 35.h,
                          color: HexColor('#679BF1'),
                          textColor: Colors.white,
                          width: 140.w,
                        )
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
