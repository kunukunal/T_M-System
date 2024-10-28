import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/management/managment_modal.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class AddExpenseController extends GetxController {
  //variable
  // final selectedProjectItem = 'Select'.obs;
  // final selectedBuildingItem = 'Select'.obs;
  final selectedExpenseItem = 'Select'.obs;
  final amountCntrl = TextEditingController().obs;
  final remarkCntrl = TextEditingController().obs;
  final date = Rxn<DateTime>();

  final selectedImages = [].obs; // List of selected image
  final picker = ImagePicker();
  // final selectedProperty = Rxn<Property>();
  // final selectedBuilding = Rxn<Building>();
  final amountFocus = FocusNode().obs;
  final remarkFocus = FocusNode().obs;
  final otherExpense = TextEditingController().obs;
  //List variables
  // final projrctsList = <Property>[].obs;
  final expenseList = [
    'Select',
  ].obs;
  final paymentTypeList = <Map>[
    {'name': 'UPI', 'isSelected': false},
    {'name': 'Bank Transfer', 'isSelected': false},
    {'name': 'Net Banking', 'isSelected': false},
    {'name': 'Credit Card', 'isSelected': false},
    {'name': 'Cash', 'isSelected': false},
    {'name': 'Cheque', 'isSelected': false},
  ].obs;
  final paymentTypeSelected = "".obs;

  final isfromEdit = false.obs;
  final editMap = {}.obs;
  @override
  onInit() {
    super.onInit();
    getPropertyBuilding();
    getExpenseTypeListApi();
    isfromEdit.value = Get.arguments[0];

    if (isfromEdit.value) {
      editMap.value = Get.arguments[1];
      amountCntrl.value.text = editMap['expense_amount'];
      date.value = DateTime.parse(editMap['expense_date']);
      remarkCntrl.value.text = editMap['remarks'];

      for (var element in paymentTypeList) {
        if (element['name'] == editMap['payment_type']) {
          element['isSelected'] = true;
          paymentTypeSelected.value = element['name'];
        } else {
          element['isSelected'] = false;
        }
      }
      for (int i = 0; i < editMap['images'].length; i++) {
        selectedImages.add({
          'isNetworkImage': true,
          'imagePath': editMap['images'][i]['image_url'],
          "id": editMap['images'][i]['id'],
          "isDeleted": false,
        });
      }
    }
  }

  // void getPropertyBuilding() async {
  //   String accessToken = await SharedPreferencesServices.getStringData(
  //           key: SharedPreferencesKeysEnum.accessToken.value) ??
  //       "";
  //   String languaeCode = await SharedPreferencesServices.getStringData(
  //           key: SharedPreferencesKeysEnum.languaecode.value) ??
  //       "en";

  //   final response = await DioClientServices.instance.dioGetCall(
  //     headers: {
  //       'Authorization': "Bearer $accessToken",
  //       "Content-Type": "application/json",
  //       "Accept-Language": languaeCode,
  //     },
  //     url: getPropertyAndBuildingList,
  //   );

  //   if (response.statusCode == 200) {
  //     List<dynamic> responseData = response.data;
  //     projrctsList.clear();
  //     for (var item in responseData) {
  //       projrctsList.add(Property.fromJson(item));
  //     }
  //     if (isfromEdit.value) {
  //       if (isfromEdit.value) {
  //         for (int i = 0; i < projrctsList.length; i++) {
  //           if (projrctsList[i].id == editMap['project']) {
  //             selectedProperty.value = projrctsList[i];
  //             for (int k = 0; k < projrctsList[i].buildings.length; k++) {
  //               print("Selected Property: ${selectedProperty.value!.title}, Buildings Count: ${projrctsList[i].buildings.length}, Building ID: ${projrctsList[i].buildings[k].id}");

  //               if (projrctsList[i].buildings[k].id == editMap['building']) {
  //                 selectedBuilding.value = projrctsList[i].buildings[k];
  //                 break;
  //               }
  //             }
  //             break;
  //           }
  //         }
  //       }
  //     }
  //   } else {
  //     print('Error: ${response.statusCode}');
  //   }
  // }

  final selectedProperty = Rxn<Property>();
  final selectedBuilding = Rxn<Building>();
  final selectedFloor = Rxn<Floor>();
  final selectedUnit = Rxn<Unit>();

  final projectsListData = <Property>[].obs;
  final buildingsList = <Building>[].obs;
  final floorsList = <Floor>[].obs;
  final unitsList = <Unit>[].obs;

  void getPropertyBuilding() async {
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioGetCall(
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: getPropertyAndBuildingList,
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = response.data;
      projectsListData.clear();
      print("dasjkjsd ${responseData}");
      for (var item in responseData) {
        projectsListData.add(Property.fromJson(item));
      }
      if (isfromEdit.value) {
        for (int i = 0; i < projectsListData.length; i++) {
          print("jkkjkj ${editMap}");
          if (projectsListData[i].id == editMap['project']) {
            selectedProperty.value = projectsListData[i];
            if (editMap['building'] != null) {
              for (int k = 0; k < projectsListData[i].buildings.length; k++) {
                print(
                    "Selected Property: ${selectedProperty.value!.title}, Buildings Count: ${projectsListData[i].buildings.length}, Building ID: ${projectsListData[i].buildings[k].id}");
                if (projectsListData[i].buildings[k].id ==
                    editMap['building']) {
                  selectedBuilding.value = projectsListData[i].buildings[k];
                  print("dsajkdjasl ${editMap['building']}");
                  getFloorsAndUnits(editMap['building']);
                  break;
                }
              }
            }
            break;
          }
        }
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  void getFloorsAndUnits(int buildingId) async {
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioGetCall(
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: "$getFloorAndUnitList$buildingId/",
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = response.data['floors'];
      floorsList.clear();
      for (var item in responseData) {
        floorsList.add(Floor.fromJson(item));
      }
      if (isfromEdit.value) {
        print("daskldk ${editMap['floor']}");
        if (editMap['floor'] != null) {
          for (int i = 0; i < floorsList.length; i++) {
            if (floorsList[i].id == editMap['floor']) {
              selectedFloor.value = floorsList[i];
              print("daskldk ${editMap['unit']}");
              if (editMap['unit'] != null) {
                unitsList.value = floorsList[i].units;
                for (int k = 0; k < floorsList[i].units.length; k++) {
                  print(
                      "Selected Property: ${selectedProperty.value!.title}, Buildings Count: ${projectsListData[i].buildings.length}, Building ID: ${projectsListData[i].buildings[k].id}");

                  if (floorsList[i].units[k].id == editMap['unit']) {
                    print("dsadsa ${floorsList[i].units[k].id}");
                    selectedUnit.value = floorsList[i].units[k];
                    print(
                        "dsadsa ${floorsList[i].units[k].id} ${selectedUnit.value}  ${unitsList.length}");
                    break;
                  }
                }
              }

              break;
            }
          }
        }
      }
    } else {
      // Handle other status codes and errors
      print('Error: ${response.statusCode}');
    }
  }

  void onProjectSelected(Property? project) {
    selectedProperty.value = project;
    selectedBuilding.value = null;
    selectedFloor.value = null;
    selectedUnit.value = null;
    floorsList.clear();
    unitsList.clear();
  }

  void onBuildingSelected(Building? building) {
    selectedBuilding.value = building;
    if (building != null) {
      floorsList.value = building.floors;
      // Optionally fetch floors from API if not included in the building data
      getFloorsAndUnits(building.id); // Uncomment if floors need to be fetched
    } else {
      floorsList.clear();
    }
    selectedFloor.value = null;
    selectedUnit.value = null;
    unitsList.clear();
  }

  void onFloorSelected(Floor? floor) {
    selectedFloor.value = floor;
    if (floor != null) {
      unitsList.value = floor.units;
    } else {
      unitsList.clear();
    }
    selectedUnit.value = null;
  }

  void onUnitSelected(Unit? unit) {
    selectedUnit.value = unit;
    if (unit != null) {
      // Pre-fill rent data
      // amountCntrl.value.text = unit.unitRent.toString();
    } else {
      // amountCntrl.value.clear();
    }
  }

  void getExpenseTypeListApi() async {
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioGetCall(
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: getExpenseTypeList,
    );
    if (response.statusCode == 200) {
      final data = response.data;
      print("dsakdsajdas ${data}");
      for (int i = 0; i < data.length; i++) {
        expenseList.add(data[i]['name']);
      }

      if (isfromEdit.value) {
        if (expenseList.contains(editMap['expense_type'])) {
          selectedExpenseItem.value = editMap['expense_type'];
          print("dasklkdlksaldklask ${selectedExpenseItem.value == "Other"}");
          if (selectedExpenseItem.value == "Other") {
            otherExpense.value.text = editMap['other_expense'];
          }
        }
      }
    } else {}
  }

  // void onProjectSelected(Property? project) {
  //   selectedProperty.value = project;
  //   selectedBuilding.value = null;
  // }

  // void onBuildingSelected(Building? building) {
  //   selectedBuilding.value = building;
  // }

//functions
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != date.value) {
      date.value = picked;
      print("dfdf ${date.value}");
    }
  }

  onPaymentTypeTap(index) {
    paymentTypeList.map((element) {
      element['isSelected'] = false;
    }).toList();
    paymentTypeList[index]['isSelected'] = true;
    paymentTypeSelected.value = paymentTypeList[index]['name'];
    paymentTypeList.refresh();
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, // To set quality of images
        maxHeight: 1000, // To set maxheight of images that you want in your app
        maxWidth: 1000); // To set maxheight of images that you want in your app
    List<XFile> xfilePick = pickedFile;
    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add({
          'isNetworkImage': false,
          'imagePath': xfilePick[i],
          "id": 0,
          "isDeleted": false,
        });
      }
      // log(selectedImages.first.name.toString(), name: 'Images');
      selectedImages.refresh();
    } else {
      customSnackBar(Get.context!, 'nothing_is_selected'.tr);
    }
  }

  onSaveTap() {
    if (selectedProperty.value != null) {
      // if (selectedBuilding.value != null) {
      if (selectedExpenseItem.value != "Select") {
        if (date.value != null) {
          if (amountCntrl.value.text.isNotEmpty) {
            if (paymentTypeSelected.value != "") {
              if (selectedExpenseItem.value != "Other") {
                if (isfromEdit.value) {
                  updateExpense();
                } else {
                  addExpense();
                }
              } else {
                if (otherExpense.value.text.trim().isNotEmpty) {
                  if (isfromEdit.value) {
                    updateExpense();
                  } else {
                    addExpense();
                  }
                } else {
                  customSnackBar(
                      Get.context!, "Please enter the other Expense");
                }
              }
            } else {
              customSnackBar(Get.context!, "please_select_payment_type".tr);
            }
          } else {
            customSnackBar(Get.context!, "please_fill_amount".tr);
          }
        } else {
          customSnackBar(Get.context!, "please_select_date".tr);
        }
      } else {
        customSnackBar(Get.context!, "please_select_expense_type".tr);
      }
    }
    // else {
    //   customSnackBar(Get.context!, "please_select_building".tr);
    // }
    // }

    else {
      customSnackBar(Get.context!, "please_select_property".tr);
    }
  }

  final addExpenseDatta = false.obs;
  addExpense() async {
    final image = [];

    for (int i = 0; i < selectedImages.length; i++) {
      image.add(await DioClientServices.instance
          .multipartFile(file: selectedImages[i]['imagePath']));
    }

    addExpenseDatta.value = true;

    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";
    print(
        "dksalkd ${selectedBuilding.value?.id} ${selectedFloor.value?.id} ${selectedUnit.value?.id}");
    final response = await DioClientServices.instance.dioPostCall(
      body: {
        "project": selectedProperty.value!.id,
        if (selectedBuilding.value != null)
          "building": selectedBuilding.value!.id,
        if (selectedFloor.value != null) "floor": selectedFloor.value!.id,
        if (selectedUnit.value != null) "unit": selectedUnit.value!.id,
        "expense_type": selectedExpenseItem.value,
        "other_expense": otherExpense.value.text.trim(),
        "expense_date":
            "${date.value!.year}-${date.value!.month}-${date.value!.day}",
        "expense_amount": amountCntrl.value.text,
        "payment_type": paymentTypeSelected.value,
        "remarks": remarkCntrl.value.text,
        "expense_images": image
      },
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: getAllExpense,
    );

    if (response != null) {
      if (response.statusCode == 201) {
        addExpenseDatta.value = false;
        Get.back(result: true);
        customSnackBar(Get.context!, "expense_added_successfully".tr);
      } else if (response.statusCode == 400) {
        addExpenseDatta.value = false;
      } else {
        addExpenseDatta.value = false;
      }
    }
  }

  updateExpense() async {
    final image = [];
    final deletedId = [];
    for (int i = 0; i < selectedImages.length; i++) {
      if (selectedImages[i]['isNetworkImage'] == false) {
        image.add(await DioClientServices.instance
            .multipartFile(file: selectedImages[i]['imagePath']));
      }
      if (selectedImages[i]['isDeleted'] == true) {
        deletedId.add(selectedImages[i]['id']);
      }
    }
    addExpenseDatta.value = true;

    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioPatchCall(
      body: {
        "project": selectedProperty.value!.id,
        if (selectedBuilding.value != null)
          "building": selectedBuilding.value!.id,
        if (selectedFloor.value != null) "floor": selectedFloor.value!.id,
        if (selectedUnit.value != null) "unit": selectedUnit.value!.id,
        "expense_type": selectedExpenseItem.value,
        "other_expense": otherExpense.value.text.trim(),
        "expense_date":
            "${date.value!.year}-${date.value!.month}-${date.value!.day}",
        "expense_amount": amountCntrl.value.text,
        "payment_type": paymentTypeSelected.value,
        "remarks": remarkCntrl.value.text,
        "expense_images": image,
        "img_deleted": jsonEncode(deletedId),
      },
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: "$getAllExpense${editMap['id']}/",
    );

    if (response != null) {
      print("sasalklsadsa ${response.data} ${response.statusCode}");
      if (response.statusCode == 200) {
        addExpenseDatta.value = false;
        Get.back(result: true);
        customSnackBar(Get.context!, "expense_update_successfully".tr);
      } else if (response.statusCode == 400) {
        addExpenseDatta.value = false;
      } else {
        addExpenseDatta.value = false;
      }
    }
  }
}
