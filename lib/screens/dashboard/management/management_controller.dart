import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManagementController extends GetxController{
  //variable
  final selectedTenantName ='Select'.obs;
  final selectedProjectName ='Select'.obs;
  final selectedTowerName ='Select'.obs;
  final selectedFloorName ='Select'.obs;
  final selectedUnitName ='Select'.obs;
  final selectedRentType ='Select'.obs;

  final amountCntrl = TextEditingController().obs;
  final remarkCntrl = TextEditingController().obs;

  final rentFrom = Rxn<DateTime>();
  final rentTo = Rxn<DateTime>();

  final  amountFocus = FocusNode().obs;
  final  remarkFocus = FocusNode().obs;

  //List variables
  final tenantList=[
    'Select',
    'Tenant 1',
    'Tenant 2',
  ].obs;
  final projectsList=[
    'Select',
    'Project 1',
    'Project 2',
  ].obs;
final towerList=[
    'Select',
    'Tower 1',
    'Tower 2',
  ].obs;
final floorList=[
    'Select',
    'Floor 1',
    'Floor 2',
  ].obs;
final unitList=[
    'Select',
    'Unit 1',
    'Unit 2',
  ].obs;
final rentTypeList=[
    'Select',
    'Type 1',
    'Type 2',
  ].obs;

  final amenitiesList = <Map>[
    {
      'name':'Gas',
      'isSelected':true,
      'amount':'₹150'
    }, {
      'name':'Electricity',
      'isSelected':false,
      'amount':'₹100'
    }, {
      'name':'Garbage',
      'isSelected':false,
      'amount':'₹100'
    }, {
      'name':'Water',
      'isSelected':false,
      'amount':'₹120'
    },
    {
      'name':'Cable',
      'isSelected':false,
      'amount':'₹120'
    },
    {
      'name':'Internet',
      'isSelected':false,
      'amount':'₹120'
    },
  ].obs;


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

  onPaymentTypeTap(index){
    amenitiesList.value[index]['isSelected'] = !amenitiesList.value[index]['isSelected'];
    amenitiesList.refresh();
  }

  onSubmitTap(){

  }
}