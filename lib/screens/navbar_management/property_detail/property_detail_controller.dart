import 'package:get/get.dart';

import '../floor_detail/floor_detail_view.dart';

class PropertyDetailCntroller extends GetxController{
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

  },].obs;

  final floorList =<Map> [
  {
  'floorTitle': ' A',
  'floorrate' : '5/10'

  } , {
  'floorTitle': ' B',
  'floorrate' : '16/20'

  }  ,{
  'floorTitle': ' C',
  'floorrate' : '13/15'

  },  {
  'floorTitle': ' D',
  'floorrate' : '7/13'

  }].obs;

  final isExpand= false.obs;

  onBuildingTap(){
    Get.to(()=>
        FloorDetailView());
  }
}