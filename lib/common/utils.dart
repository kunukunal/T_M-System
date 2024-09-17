import 'package:flutter/material.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';

convertDateString(String date) {
  DateTime dateTime = DateTime.parse(date);
  String formattedDate = DateFormat('dd MMM').format(dateTime);
  return formattedDate;
}

Future<DateTime?> selectMonthYear(BuildContext context) async {
  DateTime today = DateTime.now();

  final DateTime? picked = await showMonthPicker(
    context: context,
    initialDate: today,
    firstDate: DateTime(2023),
    lastDate: DateTime(
        today.year, today.month), // Limits to the current month and year
  );

  return picked;
}

final _flutterMediaDownloaderPlugin = MediaDownload();

saveNetworkPdf(String url) async {
  try {
    // await DioClientServices.instance
    //     .savePdfToDownloads(Get.context!, url)
    //     .then((value) {
    //   if (value != null) {
    //     customSnackBar(Get.context!, "document_download_successfully".tr);
    //   }
    // });
    _flutterMediaDownloaderPlugin.downloadMedia(Get.context!, url);
  } on Error {
    throw 'Error has occured while saving';
  }
}
