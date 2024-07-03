import 'package:get/get.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_building/add_%20building_view.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/floor/floor_view.dart';

class PropertyAbCntroller extends GetxController{
  final propertyList= [
    {
      'buildingTitle': 'Building 1',
      'floor': '10',
      'isFeatured':true

    },
    {
      'buildingTitle': 'Building 2',
      'floor': '10',
      'isFeatured':true
    },
    {
      'buildingTitle': 'Building 3',
      'floor': '10',
      'isFeatured':true

    },

  ].obs;

  onAddTap(){
    Get.to(()=>
        AddBuildingView());
  }

  onListTap(){
    Get.to(()=>
        FloorView());
  }
}