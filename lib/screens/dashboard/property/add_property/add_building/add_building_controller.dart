import 'package:get/get.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_amenities/add_amenities_view.dart';

class AddBuildingCntroller extends GetxController{
  final selectedProperty ='Property AB'.obs;
  final propertyList=[
    'Property AB',
    'Property AB1',
    'Property AB2',
  ].obs;
onAmenitiesTap(){
  Get.to(()=>AddAmentiesView());
}
}