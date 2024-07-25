import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/dashboard/management/management_widgets.dart';
import 'package:tanent_management/screens/onboarding/auth/login_view/auth_controller.dart';
import 'package:tanent_management/services/dio_client_service.dart';

class ManagementController extends GetxController {
  //variable
  final selectedTenantName = 'Select'.obs;
  final selectedProjectName = 'Select'.obs;
  final selectedTowerName = 'Select'.obs;
  final selectedFloorName = 'Select'.obs;
  final selectedUnitName = 'Select'.obs;
  final selectedRentType = 'Advance'.obs;

  final amountCntrl = TextEditingController().obs;
  final mobileCntrl = TextEditingController().obs;
  final nameCntrl = TextEditingController().obs;
  final remarkCntrl = TextEditingController().obs;

  final rentFrom = Rxn<DateTime>();
  final rentTo = Rxn<DateTime>();

  final amountFocus = FocusNode().obs;
  final remarkFocus = FocusNode().obs;

  final checkTanant = false.obs;

  //List variables
  final tenantList = [
    'Select',
    'Tenant 1',
    'Tenant 2',
  ].obs;
  final projectsList = [
    'Select',
  ].obs;
  final towerList = [
    'Select',
  ].obs;
  final floorList = [
    'Select',
  ].obs;
  final unitList = [
    'Select',
  ].obs;
  final rentTypeList = [
    'Advance',
    'Monthly',
    'Yearly',
  ].obs;

  final amenitiesList = <Map>[].obs;

  final tenantCheckLoading = false.obs;
  final addTenantLoading = false.obs;
  final addTenantOtpVerify = false.obs;
  final documentUploaded = true.obs;

  final unitPropertyNameData = {}.obs;
  final unitBuildingNameData = {}.obs;
  final unitFloorNameData = {}.obs;
  final unitNameData = {}.obs;

  final seletentRentTypeId = 1.obs;

  final isRentNegiosate = false.obs;

  @override
  onInit() {
    if (Get.arguments[0] == false) {
      unitPropertyNameData.value = Get.arguments[1][0];
      unitBuildingNameData.value = Get.arguments[1][1];
      unitFloorNameData.value = Get.arguments[1][2];
      unitNameData.value = Get.arguments[1][3];
      List amenities = Get.arguments[2];
      amountCntrl.value.text = Get.arguments[3]['ammount'];
      isRentNegiosate.value = Get.arguments[3]['isNegiosiate'];
      amenitiesList.clear();
      projectsList.add(unitPropertyNameData['name']);
      towerList.add(unitBuildingNameData['name']);
      floorList.add(unitFloorNameData['name']);
      unitList.add(unitNameData['name']);
      selectedProjectName.value = unitPropertyNameData['name'];
      selectedTowerName.value = unitBuildingNameData['name'];
      selectedFloorName.value = unitFloorNameData['name'];
      selectedUnitName.value = unitNameData['name'];
      for (int i = 0; i < amenities.length; i++) {
        amenitiesList.add({
          'id': amenities[i]['id'],
          'name': amenities[i]['name'],
          'amount': TextEditingController(text: amenities[i]['price']),
          'isSelected': false,
        });
      }
    }
    super.onInit();
  }

  bool setRentDates() {
    if (rentTo.value!.isAfter(rentFrom.value!)) {
// sucesss
      return true;
    } else if (rentTo.value!.isAtSameMomentAs(rentFrom.value!)) {
      customSnackBar(
          Get.context!, "Rent To date cannot be the same as Rent From date.");
      return false;
    } else {
      customSnackBar(
          Get.context!, "Rent To date cannot be earlier than Rent From date.");

      return false;
    }
  }

//functions
  Future<void> selectDateFrom(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: rentFrom.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != rentFrom.value) {
      rentFrom.value = picked;
    }
  }

  Future<void> selectDateTo(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: rentTo.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != rentTo.value) {
      rentTo.value = picked;
    }
  }

  onPaymentTypeTap(index) {
    amenitiesList[index]['isSelected'] = !amenitiesList[index]['isSelected'];
    amenitiesList.refresh();
  }

  onSubmitTap() {
    if (amountCntrl.value.text.trim().isNotEmpty) {
      if (rentFrom.value != null) {
        if (rentTo.value != null) {
          if (setRentDates()) {
            addTenant();
          }
        } else {
          customSnackBar(Get.context!, "Rent To date can not be empty");
        }
      } else {
        customSnackBar(Get.context!, "Rent From date can not be empty");
      }
    } else {
      customSnackBar(Get.context!, "Rent field can not be empty");
    }
  }

  verifyStatus() {
    if (mobileCntrl.value.text.isNotEmpty) {
      getTenenatCheck();
    } else {
      customSnackBar(Get.context!, "Mobile Number field can not be empty");
    }
  }

  getrenttypeid() {
    seletentRentTypeId.value = rentTypeList.indexOf(selectedRentType.value) + 1;
  }

  getTenenatCheck() async {
    final authCntrl = Get.find<AuthController>();
    tenantCheckLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    final response = await DioClientServices.instance.dioPostCall(
      body: {
        "phone_code": authCntrl.selectedItem.trim(),
        "phone": mobileCntrl.value.text.trim()
      },
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json"
      },
      url: checTenantStatus,
    );

    if (response != null) {
      if (response.statusCode == 200) {
        tenantCheckLoading.value = false;
        checkTanant.value = response.data['tenant'];
        documentUploaded.value = response.data['documents'];
        customSnackBar(Get.context!, response.data['message']);
      } else if (response.statusCode == 400) {
        tenantCheckLoading.value = false;
      }
    }
  }

  addTenant({bool isFromTenant = true}) async {
    final authCntrl = Get.find<AuthController>();
    authCntrl.otpController1.value.clear();
    authCntrl.otpController2.value.clear();
    authCntrl.otpController3.value.clear();
    authCntrl.otpController4.value.clear();
    String rentToDate =
        '${rentTo.value!.year}-${rentTo.value!.month}-${rentTo.value!.day}';
    String rentFromDate =
        '${rentFrom.value!.year}-${rentFrom.value!.month}-${rentFrom.value!.day}';
    addTenantLoading.value = true;
    getrenttypeid();
    List amenti = [];
    for (int i = 0; i < amenitiesList.length; i++) {
      if (amenitiesList[i]['isSelected'] == true) {
        amenti.add(
          {
            "name": amenitiesList[i]['name'],
            "price": amenitiesList[i]['amount'].text
          },
        );
      }
    }
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    final response = await DioClientServices.instance.dioPostCall(
      body: {
        "phone_code": authCntrl.selectedItem.trim(),
        "phone": mobileCntrl.value.text.trim(),
        "name": nameCntrl.value.text.trim(),
        "unit": unitNameData['id'],
        "property": unitPropertyNameData['id'],
        "building": unitBuildingNameData['id'],
        "floor": unitFloorNameData['id'],
        "amenities": amenti,
        "rent_amount": double.parse(amountCntrl.value.text.trim()),
        "rent_type":
            seletentRentTypeId.value, // (1, Advance) (2, Monthly) (3, Yearly)
        "rent_from": rentFromDate,
        "rent_to": rentToDate,
        "remarks": remarkCntrl.value.text.trim()
      },
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json"
      },
      url: addNewTenant,
    );

    if (response != null) {
      if (response.statusCode == 200) {
        if (isFromTenant == true) {
          ManagementWidgets().otpPop();
        } else {}

        customSnackBar(Get.context!, response.data['message'][0]);

        addTenantLoading.value = false;
      } else if (response.statusCode == 400) {
        addTenantLoading.value = false;
      }
    }
  }

  verifyOtpTenantApi() async {
    final authCntrl = Get.find<AuthController>();
    String rentToDate =
        '${rentTo.value!.year}-${rentTo.value!.month}-${rentTo.value!.day}';
    String rentFromDate =
        '${rentFrom.value!.year}-${rentFrom.value!.month}-${rentFrom.value!.day}';
    addTenantOtpVerify.value = true;
    getrenttypeid();
    List amenti = [];
    for (int i = 0; i < amenitiesList.length; i++) {
      if (amenitiesList[i]['isSelected'] == true) {
        amenti.add(
          {
            "name": amenitiesList[i]['name'],
            "price": amenitiesList[i]['amount'].text
          },
        );
      }
    }
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";

    final response = await DioClientServices.instance.dioPostCall(
      body: {
        "phone_code": authCntrl.selectedItem.trim(),
        "phone": mobileCntrl.value.text.trim(),
        "name": nameCntrl.value.text.trim(),

        "otp": authCntrl.otpController1.value.text.trim() +
            authCntrl.otpController2.value.text.trim() +
            authCntrl.otpController3.value.text.trim() +
            authCntrl.otpController4.value.text.trim(),
        "unit": unitNameData['id'],
        "property": unitPropertyNameData['id'],
        "building": unitBuildingNameData['id'],
        "floor": unitFloorNameData['id'],
        "amenities": amenti,
        "rent_amount": double.parse(amountCntrl.value.text.trim()),
        "rent_type":
            seletentRentTypeId.value, // (1, Advance) (2, Monthly) (3, Yearly)
        "rent_from": rentFromDate,
        "rent_to": rentToDate,
        "remarks": remarkCntrl.value.text.trim()
      },
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json"
      },
      isRawData: true,
      url: verifyTenantOtpapi,
    );

    if (response != null) {
      print("fsdaosalkasld ${response.data}  ${response.statusCode}");
      if (response.statusCode == 200) {
        print("fsdaosalkasld 2 ${response.data}");

        customSnackBar(Get.context!, response.data['message']);

        addTenantOtpVerify.value = false;
      } else if (response.statusCode == 201) {
        if (response.data['success'] == true) {
          Get.back();
          Get.back(result: true);
        } else {
          Get.back();
        }

        customSnackBar(Get.context!, response.data['message']);
        addTenantOtpVerify.value = false;
      } else if (response.statusCode == 400) {
        customSnackBar(Get.context!, response.data['message']);
        addTenantOtpVerify.value = false;
      }
    }
  }
}
