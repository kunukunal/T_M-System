import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../modals/dio_modal.dart';
import '../modals/user_modal.dart';
import '../widgets/dialog.dart';

//Accessing permissions
Future<bool> requestPermissions() async {
  await Permission.storage.request();

  if (await Permission.storage.request().isGranted) {
    // Permissions have already been granted.
    return true;
  } else {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    if (statuses[Permission.storage]!.isDenied) {
      // Permissions were denied.
      // Handle the situation accordingly (e.g., show a message or disable functionality).
      return false;
    } else {
      return true;
    }
  }
}

// handelApi will handel internet connectivity, api exception, dio exception.
// callApi method which will return instance of DioResult.
// in every conditon it will show snackbar with message.

Future<DioResult?> handelApi({
  required BuildContext context,
  required Function callApi,
  bool automatic = false,
}) async {
  if (await checkConnectivity()) {
    try {
      automatic ? null : CustomDialog.circularProcessDialog(Get.context!);

      DioResult? dioResult = await callApi();

      // Navigator.pop(context);
      automatic ? null : Get.back();
      return dioResult;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        automatic
            ? null
            : CustomDialog.customSnackBar(
            Get.context!, "Connection Timeout Exception. Try again!");
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        automatic
            ? null
            : CustomDialog.customSnackBar(
            Get.context!, "Connection Timeout Exception. Try again!");
      } else {
        automatic
            ? null
            : CustomDialog.customSnackBar(Get.context!, "something_went_wrong".tr);
      }
      automatic ? null : Get.back();
      // Navigator.pop(context);
      log("Exception(DioError) - handelApi(): $e");
    } catch (e) {
      automatic
          ? null
          : CustomDialog.customSnackBar(Get.context!, "something_went_wrong".tr);
      // Navigator.pop(context);
      automatic ? null : Get.back();
      log("Exception - handelApi(): $e");
    }
    // Navigator.pop(context);
  } else {
    automatic ? null : showNetworkError(Get.context!);
    return null;
  }
  return null;
}

//Check Network Connectivity
Future<bool> checkConnectivity() async {
  try {
    bool isConnected;
    var connectivity = await (Connectivity().checkConnectivity());
    if (connectivity == ConnectivityResult.mobile) {
      isConnected = true;
    } else if (connectivity == ConnectivityResult.wifi) {
      isConnected = true;
    } else {
      isConnected = false;
    }
    return isConnected;
  } catch (e) {
    log('Exception - commons.dart - checkConnectivity(): $e');
  }
  return false;
}

//Showing Network Message
showNetworkError(BuildContext context) {
  CustomDialog.customSnackBar(context, "No internet available");
}

//Set User Data
Future<bool> setUserData(UserModel userModel, BuildContext context) async {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  try {
    await storage.write(key: "user_id", value: userModel.userId.toString());
    await storage.write(key: "name", value: userModel.name.toString());
    await storage.write(key: "email", value: userModel.email.toString());
    await storage.write(key: "image", value: userModel.image.toString());
    await storage.write(key: "plan_id", value: userModel.planId.toString());
    await storage.write(
        key: "plan_expired", value: userModel.planExpired.toString());
    await storage.write(key: "authToken", value: userModel.token.toString());
    await storage.write(
        key: "expiresAt", value: userModel.tokenExpireAt.toString());

    return true;
  } catch (e) {
    CustomDialog.customSnackBar(context, "Error While storing data");
    return false;
  }
}

//Remove UserData
Future<dynamic> removeUserData(BuildContext context) async {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  //exception will handel by handelExceptionApi funciton
  await storage.delete(key: "user_id");
  await storage.delete(
    key: "name",
  );
  await storage.delete(
    key: "email",
  );
  await storage.delete(
    key: "image",
  );
  await storage.delete(
    key: "plan_id",
  );
  await storage.delete(
    key: "plan_expired",
  );
  await storage.delete(
    key: "authToken",
  );
  await storage.delete(
    key: "expiresAt",
  );
}

//Get User Data
Future<UserModel?> getUserData() async {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  try {
    final userId = await storage.read(key: "user_id");
    // print(userId);
    final name = await storage.read(
      key: "name",
    );
    final email = await storage.read(
      key: "email",
    );
    final imageUrl = await storage.read(
      key: "image",
    );
    final tokenExpireAt = await storage.read(
      key: "expiresAt",
    );
    // print(name);
    final token = await storage.read(
      key: "authToken",
    );

    return userId != null
        ? UserModel(
      userId: int.parse(userId),
      token: token!,
      tokenExpireAt: tokenExpireAt,
      name: name!,
      email: email!,
      image: imageUrl!,
    )
        : null;
  } catch (e) {
    log("Exception Commons() - getUserData $e");
    // customSnackBar(context, "Error While fetching data");
    return null;
  }
}

Future<bool> get isGothroughVisible async {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String? value = await storage.read(key: "isGothroughVisible");

  if (value == null) {
    await storage.write(key: "isGothroughVisible", value: "1");
    return true;
  } else {
    return false;
  }
}