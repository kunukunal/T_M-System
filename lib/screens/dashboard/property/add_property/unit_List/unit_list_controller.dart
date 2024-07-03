import 'package:get/get.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_building/add_%20building_view.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_unit/add_unit_view.dart';

class UnitCntroller extends GetxController{
  final unitList= [
    {
      'buildingTitle': 'Unit 1',
      'floor': '83',
      'isOccupied':true

    },
    {
      'buildingTitle': 'Unit 2',
      'floor': '3',
      'isOccupied':false
    },
    {
      'buildingTitle': 'Unit 3',
      'floor': '101',
      'isOccupied':true

    },

  ].obs;

  onAddTap(){
    Get.to(()=>
        AddBuildingView());
  }

  onItemTap(){
    Get.to(()=>
        AddUnitView());
  }
}