import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/dashboard/management/management_widgets.dart';
import 'package:tanent_management/screens/dashboard/tenant/add_tenant/add_tenant_view.dart';
import 'package:tanent_management/screens/dashboard/tenant/add_tenant/tenant_documents.dart';
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
  final isFromHome = false.obs;

  final phonecode = "+91".obs;
  @override
  onInit() {
    isFromHome.value = Get.arguments[0];
    if (isFromHome.value == false) {
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
    } else {
      final data = Get.arguments[1];
      nameCntrl.value.text = data['name'] ?? "";
      mobileCntrl.value.text = data['phone_number'] ?? "";
      phonecode.value = data['phone_code'] ?? "";

      getPropertyBuilding();
    }
    super.onInit();
  }

  final selectedProperty = Rxn<Property>();
  final selectedBuilding = Rxn<Building>();
  final selectedFloor = Rxn<Floor>();
  final selectedUnit = Rxn<Unit>();

  final projectsListData = <Property>[].obs;
  final buildingsList = <Building>[].obs;
  final floorsList = <Floor>[].obs;
  final unitsList = <Unit>[].obs;

  void getPropertyBuilding() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";

    final response = await DioClientServices.instance.dioGetCall(
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json"
      },
      url: getPropertyAndBuildingList,
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = response.data;
      projectsList.clear();
      print("dasjkjsd ${responseData}");
      for (var item in responseData) {
        projectsListData.add(Property.fromJson(item));
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  void getFloorsAndUnits(int buildingId) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    final response = await DioClientServices.instance.dioGetCall(
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json"
      },
      url: "$getFloorAndUnitList$buildingId/",
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = response.data['floors'];
      floorsList.clear();
      for (var item in responseData) {
        floorsList.add(Floor.fromJson(item));
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
    amenitiesList.clear();
    amountCntrl.value.clear();
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
    amenitiesList.clear();
    amountCntrl.value.clear();
  }

  void onFloorSelected(Floor? floor) {
    selectedFloor.value = floor;
    if (floor != null) {
      unitsList.value = floor.units;
    } else {
      unitsList.clear();
    }
    selectedUnit.value = null;
    amenitiesList.clear();
    amountCntrl.value.clear();
  }

  void onUnitSelected(Unit? unit) {
    selectedUnit.value = unit;
    if (unit != null) {
      // Pre-fill rent data
      amountCntrl.value.text = unit.unitRent.toString();
      isRentNegiosate.value = unit.isRentRnegotiable;
      // Populate amenities list
      amenitiesList.clear();
      for (var amenity in unit.amenities) {
        amenitiesList.add({
          'id': amenity.id,
          'name': amenity.name,
          'amount': TextEditingController(text: amenity.price.toString()),
          'isSelected': false,
        });
      }
    } else {
      amountCntrl.value.clear();
      amenitiesList.clear();
    }
  }

  ///'/
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

  onSubmitTapFromChoose() {
    print(
        "jksalkdlaskdlaskldsaldksald  ${selectedProperty} ${selectedBuilding} ${selectedFloor.value} ${selectedUnit}");

    if (selectedProperty.value != null) {
      if (selectedBuilding.value != null) {
        if (selectedFloor.value != null) {
          if (selectedUnit.value != null) {
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
          } else {
            customSnackBar(Get.context!, "Please Select the Unit");
          }
        } else {
          customSnackBar(Get.context!, "Please Select the Floor");
        }
      } else {
        customSnackBar(Get.context!, "Please Select the Building");
      }
    } else {
      customSnackBar(Get.context!, "Please Select the property");
    }
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

        customSnackBar(Get.context!, response.data['message']);

        if (response.data['tenant'] && response.data['documents']) {
          nameCntrl.value.text = response.data['data']['name'] ?? "";
          checkTanant.value = response.data['tenant'];
          documentUploaded.value = response.data['documents'];
        } else if (response.data['tenant'] == false) {
          Get.to(
            () => AddTenantScreen(),
            arguments: [
              true,
              {
                'phone': mobileCntrl.value.text,
              },
              {'isEdit': false}
            ],
          );
        } else if (response.data['tenant'] &&
            response.data['documents'] == false) {
          Get.off(() => TenantDocScreen(),
              arguments: [response.data['data']['id'], true,{'isEdit':false,'isConsent':true}]);
        }
      } else if (response.statusCode == 400) {
        customSnackBar(Get.context!, response.data['message']);

        // if(){

        // }

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
      body: isFromHome.value
          ? {
              "phone_code": phonecode.value,
              "phone": mobileCntrl.value.text.trim(),
              "name": nameCntrl.value.text.trim(),
              "unit": selectedUnit.value!.id,
              "property": selectedProperty.value!.id,
              "building": selectedBuilding.value!.id,
              "floor": selectedFloor.value!.id,
              "amenities": amenti,
              "rent_amount": double.parse(amountCntrl.value.text.trim()),
              "rent_type": seletentRentTypeId
                  .value, // (1, Advance) (2, Monthly) (3, Yearly)
              "rent_from": rentFromDate,
              "rent_to": rentToDate,
              "remarks": remarkCntrl.value.text.trim()
            }
          : {
              "phone_code": authCntrl.selectedItem.trim(),
              "phone": mobileCntrl.value.text.trim(),
              "name": nameCntrl.value.text.trim(),
              "unit": unitNameData['id'],
              "property": unitPropertyNameData['id'],
              "building": unitBuildingNameData['id'],
              "floor": unitFloorNameData['id'],
              "amenities": amenti,
              "rent_amount": double.parse(amountCntrl.value.text.trim()),
              "rent_type": seletentRentTypeId
                  .value, // (1, Advance) (2, Monthly) (3, Yearly)
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
        addTenantOtpVerify.value = false;
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
      body: isFromHome.value
          ? {
              "phone_code": phonecode.value,
              "phone": mobileCntrl.value.text.trim(),
              "otp": authCntrl.otpController1.value.text.trim() +
                  authCntrl.otpController2.value.text.trim() +
                  authCntrl.otpController3.value.text.trim() +
                  authCntrl.otpController4.value.text.trim(),
              "name": nameCntrl.value.text.trim(),
              "unit": selectedUnit.value!.id,
              "property": selectedProperty.value!.id,
              "building": selectedBuilding.value!.id,
              "floor": selectedFloor.value!.id,
              "amenities": amenti,
              "rent_amount": double.parse(amountCntrl.value.text.trim()),
              "rent_type": seletentRentTypeId
                  .value, // (1, Advance) (2, Monthly) (3, Yearly)
              "rent_from": rentFromDate,
              "rent_to": rentToDate,
              "remarks": remarkCntrl.value.text.trim()
            }
          : {
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
              "rent_type": seletentRentTypeId
                  .value, // (1, Advance) (2, Monthly) (3, Yearly)
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
          Get.back(result: true);
          Get.back(result: true);
        } else {
          Get.back(result: true);
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

class Property {
  final int id;
  final String title;
  final List<Building> buildings;

  Property({required this.id, required this.title, required this.buildings});

  factory Property.fromJson(Map<String, dynamic> json) {
    var buildingsFromJson = json['buildings'] as List?;
    List<Building> buildingsList =
        buildingsFromJson?.map((i) => Building.fromJson(i)).toList() ?? [];
    return Property(
      id: json['id'],
      title: json['title'],
      buildings: buildingsList,
    );
  }

  @override
  String toString() {
    return title; // Display the title in the dropdown
  }
}

// Similar overrides for Building, Floor, and Unit
class Building {
  final int id;
  final String name;
  final List<Floor> floors;

  Building({required this.id, required this.name, required this.floors});

  factory Building.fromJson(Map<String, dynamic> json) {
    var floorsFromJson = json['floors'] as List?;
    List<Floor> floorsList =
        floorsFromJson?.map((i) => Floor.fromJson(i)).toList() ?? [];
    return Building(
      id: json['id'],
      name: json['name'],
      floors: floorsList,
    );
  }

  @override
  String toString() {
    return name; // This will display the name in the dropdown or list
  }
}

class Floor {
  final int id;
  final String name;
  final List<Unit> units;

  Floor({required this.id, required this.name, required this.units});

  factory Floor.fromJson(Map<String, dynamic> json) {
    var unitsFromJson = json['units'] as List?;
    List<Unit> unitsList =
        unitsFromJson?.map((i) => Unit.fromJson(i)).toList() ?? [];
    return Floor(
      id: json['id'],
      name: json['name'],
      units: unitsList,
    );
  }

  @override
  String toString() {
    return name; // Display the floor name in the dropdown
  }
}

class Unit {
  final int id;
  final String name;
  final double unitRent;
  final bool isRentRnegotiable;
  final List<Amenity> amenities;

  Unit(
      {required this.id,
      required this.name,
      required this.unitRent,
      required this.isRentRnegotiable,
      required this.amenities});

  factory Unit.fromJson(Map<String, dynamic> json) {
    var amenitiesFromJson = json['amenities'] as List?;
    List<Amenity> amenitiesList =
        amenitiesFromJson?.map((i) => Amenity.fromJson(i)).toList() ?? [];
    return Unit(
      id: json['id'],
      name: json['name'],
      isRentRnegotiable: json['is_rent_negotiable'],
      unitRent: (json['unit_rent'] ?? 0).toDouble(),
      amenities: amenitiesList,
    );
  }

  @override
  String toString() {
    return name; // Display the unit name in the dropdown
  }
}

class Amenity {
  final int id;
  final String name;
  final String price;

  Amenity({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(
      id: json['id'],
      name: json['name'],
      price: (json['price'] ?? "0"), // Handle null value with a default
    );
  }

  @override
  String toString() {
    return name; // This will display the name in the dropdown or list
  }
}
