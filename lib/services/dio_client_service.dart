import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tanent_management/common/api_service_strings/base_url.dart';
import 'package:tanent_management/common/widgets.dart';

class DioClientServices {
  DioClientServices._();
  static final DioClientServices instance = DioClientServices._();

  factory DioClientServices() => instance;

  final Dio _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30)));

  Future dioPostCall(
      {required dynamic body,
      required dynamic headers,
      required String url,
      bool? isRawData = false}) async {
    try {
      FormData? formData;

      if (isRawData == false) {
        formData = FormData.fromMap(body);
      } else {}
      Response response = await _dio.post(
        (apiBaseUrl + url),
        data: isRawData == true ? jsonEncode(body) : formData,
        options: Options(headers: headers),
      );

      return response;
    } on DioException catch (e) {
      log("${e.response?.statusCode}", name: "Exception response null");
      if (e.response == null) {
        log("$e", name: "Exception response null");
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          // showCustomFlushbar(context,
          //     message: AppLocalizations.of(context)!.internet_check); // connectivity check
        }
      } else if (e.response != null) {
        log('Dio error!', name: "dioGetCall");
        log('STATUS: ${e.response?.statusCode}', name: "dioGetCall");
        log('DATA: ${e.response?.data}', name: "dioGetCall");
        log('HEADERS: ${e.response?.headers}', name: "dioGetCall");
      } else if (e.type == DioExceptionType.receiveTimeout) {
      } else {
        log('Error sending request!', name: "dioGetCall");
        log("${e.message}", name: "dioGetCall");
      }
      return e.response;
    }
  }

  Future dioGetCall({
    required String url,
    required dynamic headers,
    bool isCustomUrl = false,
  }) async {
    try {
      Response response = await _dio.get(
        isCustomUrl ? url : (apiBaseUrl + url),
        options: Options(headers: headers),
      );

      return response;
    } on DioException catch (e) {
      log("${e.response?.statusCode}", name: "Exception response null");

      if (e.response == null) {
        log("$e", name: "Exception response null");
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          // showCustomFlushbar(context,
          //     message: AppLocalizations.of(context)!.internet_check); // connectivity check
        }
      } else if (e.response != null) {
        log('Dio error!', name: "dioGetCall");
        log('STATUS: ${e.response?.statusCode}', name: "dioGetCall");
        log('DATA: ${e.response?.data}', name: "dioGetCall");
        log('HEADERS: ${e.response?.headers}', name: "dioGetCall");
      } else if (e.type == DioExceptionType.receiveTimeout) {
      } else {
        log('Error sending request!', name: "dioGetCall");
        log("${e.message}", name: "dioGetCall");
      }
      return e.response;
    }
  }

  Future dioDeleteCall({
    required dynamic headers,
    required String url,
  }) async {
    try {
      Response response = await _dio.delete(
        (apiBaseUrl + url),
        options: Options(headers: headers),
      );

      return response;
    } on DioException catch (e) {
      log("${e.response?.statusCode}", name: "Exception response null");

      if (e.response == null) {
        log("$e", name: "Exception response null");
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          // showCustomFlushbar(context,
          //     message: AppLocalizations.of(context)!.internet_check); // connectivity check
        }
      } else if (e.response != null) {
        log('Dio error!', name: "dioGetCall");
        log('STATUS: ${e.response?.statusCode}', name: "dioGetCall");
        log('DATA: ${e.response?.data}', name: "dioGetCall");
        log('HEADERS: ${e.response?.headers}', name: "dioGetCall");
      } else if (e.type == DioExceptionType.receiveTimeout) {
      } else {
        log('Error sending request!', name: "dioGetCall");
        log("${e.message}", name: "dioGetCall");
      }
      return e.response;
    }
  }

  Future dioPatchCall(
      {required dynamic body,
      required dynamic headers,
      required String url,
      bool? isRawData = false}) async {
    try {
      FormData? formData;
      if (isRawData == false) {
        formData = FormData.fromMap(body);
      } else {}
      Response response = await _dio.patch(
        (apiBaseUrl + url),
        data: isRawData == true ? jsonEncode(body) : formData,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      log("${e.response?.statusCode}", name: "Exception response null");
      if (e.response == null) {
        log("$e", name: "Exception response null");
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          // showCustomFlushbar(context,
          //     message: AppLocalizations.of(context)!.internet_check); // connectivity check
        }
      } else if (e.response != null) {
        log('Dio error!', name: "dioGetCall");
        log('STATUS: ${e.response?.statusCode}', name: "dioGetCall");
        log('DATA: ${e.response?.data}', name: "dioGetCall");
        log('HEADERS: ${e.response?.headers}', name: "dioGetCall");
      } else if (e.type == DioExceptionType.receiveTimeout) {
      } else {
        log('Error sending request!', name: "dioGetCall");
        log("${e.message}", name: "dioGetCall");
      }
      return e.response;
    }
  }

  Future dioPutCall(
      {required dynamic body,
      required dynamic headers,
      required String url,
      bool? isRawData = false}) async {
    try {
      FormData? formData;
      if (isRawData == false) {
        formData = FormData.fromMap(body);
      } else {}
      Response response = await _dio.put(
        (apiBaseUrl + url),
        data: isRawData == true ? jsonEncode(body) : formData,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      log("${e.response?.statusCode}", name: "Exception response null");
      if (e.response == null) {
        log("$e", name: "Exception response null");
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          // showCustomFlushbar(context,
          //     message: AppLocalizations.of(context)!.internet_check); // connectivity check
        }
      } else if (e.response != null) {
        log('Dio error!', name: "dioGetCall");
        log('STATUS: ${e.response?.statusCode}', name: "dioGetCall");
        log('DATA: ${e.response?.data}', name: "dioGetCall");
        log('HEADERS: ${e.response?.headers}', name: "dioGetCall");
      } else if (e.type == DioExceptionType.receiveTimeout) {
      } else {
        log('Error sending request!', name: "dioGetCall");
        log("${e.message}", name: "dioGetCall");
      }
      return e.response;
    }
  }

  multipartFile({required XFile file}) async {
    return await MultipartFile.fromFile(file.path, filename: file.name);
  }

  Future<MultipartFile?> multipartAssetsFile() async {
    try {
      Directory directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory() ??
            await getApplicationDocumentsDirectory();
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        throw Exception("Unsupported platform");
      }

      String imagePath = path.join(directory.path, 'sample.png');
      print('Image Path: $imagePath');

      File imageFile = File(imagePath);
      if (!imageFile.existsSync()) {
        print('Image not found. Copying from assets...');

        // Check if asset path is correct.
        ByteData byteData;
        try {
          byteData = await rootBundle.load('assets/icons/no_image.png');
        } catch (e) {
          print('Error loading asset: $e');
          return null;
        }

        Uint8List imageData = byteData.buffer.asUint8List();
        await imageFile.writeAsBytes(imageData);
        print('Image saved to: $imagePath');
      } else {
        print('Image already exists at: $imagePath');
      }

      return await MultipartFile.fromFile(
        imageFile.path,
        filename: 'sample.png',
      );
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future saveImageToGallery(String imageUrl) async {
    try {
      var response = await _dio.get(imageUrl,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60);
      return result;
    } catch (e) {
      print("Error saving image to gallery: $e");
    }
  }

  Future<String?> savePdfToDownloads(
      BuildContext context, String pdfUrl) async {
    try {
      if (await Permission.manageExternalStorage.request().isGranted) {
        var response = await Dio().get(
          pdfUrl,
          options: Options(responseType: ResponseType.bytes),
        );
        Directory? downloadsDir = Directory('/storage/emulated/0/Download');
        if (!(await downloadsDir.exists())) {
          downloadsDir = await getExternalStorageDirectory();
        }
        String filePath =
            '${downloadsDir!.path}/downloaded_pdf_${DateTime.now().millisecondsSinceEpoch}.pdf';
        File file = File(filePath);
        await file.writeAsBytes(response.data);
        return filePath;
      } else {
        customSnackBar(context,
            "Permission not granted. kindly allow it from app setting.");
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future postCodeApi(String pincode, BuildContext context) async {
    try {
      Response response = await _dio.get(
        "https://api.postalpincode.in/pincode/$pincode",
      );

      if (response.data != null) {
        print("dsakdlksa ${response.data} ${response.data[0]['PostOffice']}");
        if (response.data[0]['PostOffice'] != null) {
          log("City: ${response.data[0]['PostOffice'][0]['Block']} state: ${response.data[0]['PostOffice'][0]['State']}");
          return {
            'city': response.data[0]['PostOffice'][0]['Block'],
            'state': response.data[0]['PostOffice'][0]['State']
          };
        } else {
          customSnackBar(context, response.data[0]['Message']);
          return {'city': '', 'state': ''};
        }
      } else
        print("mkalsd ${response.data}");
      return response;
    } on DioException catch (e) {
      log("${e.response?.statusCode}", name: "Exception response null");

      if (e.response == null) {
        log("$e", name: "Exception response null");
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {}
      } else if (e.response != null) {
        log('Dio error!', name: "dioGetCall");
        log('STATUS: ${e.response?.statusCode}', name: "dioGetCall");
        log('DATA: ${e.response?.data}', name: "dioGetCall");
        log('HEADERS: ${e.response?.headers}', name: "dioGetCall");
      } else if (e.type == DioExceptionType.receiveTimeout) {
      } else {
        log('Error sending request!', name: "dioGetCall");
        log("${e.message}", name: "dioGetCall");
      }
      return e.response;
    }
  }
}
