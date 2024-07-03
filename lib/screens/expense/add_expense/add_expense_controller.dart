
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tanent_management/common/widgets.dart';

class AddExpenseController extends GetxController{
  //variable
  final selectedProjectItem ='Select'.obs;
  final selectedBuildingItem ='Select'.obs;
  final selectedExpenseItem ='Select'.obs;
  final amountCntrl = TextEditingController().obs;
  final remarkCntrl = TextEditingController().obs;
  final date = Rxn<DateTime>();

  final selectedImages = <XFile>[].obs; // List of selected image
  final picker = ImagePicker();

  final  amountFocus = FocusNode().obs;
  final  remarkFocus = FocusNode().obs;
  //List variables
  final projrctsList=[
    'Select',
    'Project 1',
    'Project 2',
  ].obs;
  final buildingList=[
    'Select',
    'Building 1',
    'Building 2',
  ].obs;
final expenseList=[
    'Select',
    'Expense 1',
    'Expense 2',
  ].obs;
final paymentTypeList = <Map>[
  {
    'name':'Cash',
    'isSelected':true
  }, {
    'name':'Credit Card',
    'isSelected':false
  }, {
    'name':'Credit Card',
    'isSelected':false
  }, {
    'name':'UPI/Other',
    'isSelected':false
  },
].obs;

//functions
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != date.value) {
        date.value = picked;
    }
  }

  onPaymentTypeTap(index){
    paymentTypeList.map((element)  {
      element['isSelected']=false;
    }).toList();
    paymentTypeList.value[index]['isSelected']=true;
    paymentTypeList.refresh();
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, // To set quality of images
        maxHeight: 1000, // To set maxheight of images that you want in your app
        maxWidth: 1000); // To set maxheight of images that you want in your app
    List<XFile> xfilePick = pickedFile;

    // if atleast 1 images is selected it will add
    // all images in selectedImages
    // variable so that we can easily show them in UI
    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.value.add(xfilePick[i]);
      }
      log(selectedImages.first.name.toString(),name: 'Images');
    selectedImages.refresh();
    } else {
      // If no image is selected it will show a
      // snackbar saying nothing is selected
      customSnackBar(Get.context!, 'Nothing is selected');
    }

  }


  onSaveTap(){
    Get.back();
  }
}