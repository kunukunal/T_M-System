import 'package:get/get.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_property_view.dart';
import 'package:tanent_management/screens/dashboard/property/property_detail/property_detail_view.dart';

class PropertyListController extends GetxController{

  final propertyList= [
    {
      'propertyTitle': 'Azure House',
      'location': '39 Rue Louis Guiotton 44300 Nantes',
      'icon': 'assets/icons/location.png',
      'buildingIcon':'assets/icons/a.png',
      'isFeatured':true

    },
    {
      'propertyTitle': 'Tranquil Hut',
      'location': '27 Rue Octave Feuillet 44000 Nantes',
      'icon': 'assets/icons/location.png',
      'buildingIcon':'assets/icons/a.png',
      'isFeatured':true
    },
    {
      'propertyTitle': 'Mountain Fabric',
      'location': '3 Montée du Château 69720 Saint-Bonnet-de-Mure',
      'icon': 'assets/icons/location.png',
      'buildingIcon':'assets/icons/a.png',
      'isFeatured':true

    },
    {
      'propertyTitle': 'Azure House',
      'location': '39 Rue Louis Guiotton 44300 Nantes',
      'icon': 'assets/icons/location.png',
      'buildingIcon':'assets/icons/a.png',
      'isFeatured':true

    },
    {
      'propertyTitle': 'Tranquil Hut',
      'location': '27 Rue Octave Feuillet 44000 Nantes',
      'icon': 'assets/icons/location.png',
      'buildingIcon':'assets/icons/a.png',
      'isFeatured':true
    },
    {
      'propertyTitle': 'Mountain Fabric',
      'location': '3 Montée du Château 69720 Saint-Bonnet-de-Mure',
      'icon': 'assets/icons/location.png',
      'buildingIcon':'assets/icons/a.png',
      'isFeatured':true

    },

  ].obs;

  onAddTap(){
    Get.to(()=>
        AddPropertyView());
  }
  onItemTap(){
    Get.to(()=>
        PropertyDetailView());
  }
}