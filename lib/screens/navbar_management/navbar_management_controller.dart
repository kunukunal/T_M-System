import 'package:get/get.dart';
import 'package:tanent_management/screens/dashboard/search/search_view.dart';
import 'package:tanent_management/screens/navbar_management/property_detail/property_detail_view.dart';

class NavBarManagementCntroller extends GetxController{

  final items =<Map> [
    {
      'propTitle': ' A',
      'propDesc' : '2118 Thornridge Cir. Syracuse, Connecticut',
      'availablityTitle': '20 Units(Available)',
      'occupiedTitle': '80 Units(Occupied)',

      'isOccupied':false

    }, {
      'propTitle': ' B',
      'propDesc' : '2464 Royal Ln. Mesa, New Jersey 45463',
      'availablityTitle': '20 Units(Available)',
      'occupiedTitle': '80 Units(Occupied)',

      'isOccupied':false

    },
    {
      'propTitle': ' C',
      'propDesc' : '2972 Westheimer Rd. Santa Ana, Illinois 854',
      'availablityTitle': '20 Units(Available)',
      'occupiedTitle': '80 Units(Occupied)',
      'isOccupied':false

    },

  ].obs;
  onSearchTap(){
    Get.to(()=>
        SearchView());
  }
  onItemTap(){
    Get.to(()=>
        PropertyDetailView());
  }

}