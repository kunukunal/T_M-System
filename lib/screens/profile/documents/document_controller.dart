import 'package:get/get.dart';
import 'package:tanent_management/common/constants.dart';

class DocumentController extends GetxController{
  final documentList=<Map<String, dynamic>>[
    {
      'name':'Aadhar card.png',
      'image': aadharImage
    },
    {
      'name':'Police Verification.pdf',
      'image': policeVerificationImage
    },
    {
      'name':'Police Verification.pdf',
      'image': policeVerification2Image
    },
  ].obs;
}