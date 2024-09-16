import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/services/dio_client_service.dart';

convertDateString(String date) {
  DateTime dateTime = DateTime.parse(date);
  String formattedDate = DateFormat('dd MMM').format(dateTime);
  return formattedDate;
}

Future<DateTime?> selectMonthYear(BuildContext context) async {
  final DateTime? picked = await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2050));

  return picked;
}
  saveNetworkPdf(String url) async {
    try {
      await DioClientServices.instance.savePdfToDownloads(url).then((value) {
        if (value != null) {
          customSnackBar(Get.context!, "document_download_successfully".tr);
        }
      });
    } on Error {
      throw 'Error has occured while saving';
    }
  }