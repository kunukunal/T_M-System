import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tanent_management/common/api_service_strings/base_url.dart';

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
        (commonBaseUrl + url),
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
  }) async {
    try {
      Response response = await _dio.get(
        (commonBaseUrl + url),
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
        (commonBaseUrl + url),
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
        (commonBaseUrl + url),
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
}
