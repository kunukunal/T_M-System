import 'package:get/get.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_building/add_%20building_view.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/unit_List/unit_list_view.dart';

class FloorCntroller extends GetxController{
  final floorList= [
    {
      'buildingTitle': 'Floor 1',
      'floor': '10',
      'isFeatured':true

    },
    {
      'buildingTitle': 'Floor 2',
      'floor': '10',
      'isFeatured':true
    },
    {
      'buildingTitle': 'Floor 3',
      'floor': '10',
      'isFeatured':true

    },

  ].obs;

  onAddTap(){}

  onFloorTap(){
    Get.to(()=>
        UnitView());
  }
}