import 'package:get/get.dart';
import 'package:tanent_management/screens/dashboard/tenant/tenant_list/tenant_detail_view.dart';

import '../../../../common/constants.dart';
import '../../../../common/widgets.dart';

class TenantListController extends GetxController{
  //variables
  final tenantList= <Map<String, dynamic>>[
    {
      'name':'Darlene Robertson',
      'address':'4140 Parker Rd. Allentown, New Mexico 31134',
      'image': profileIconWithWidget
    },{
      'name':'Jerome Bell',
      'address':'2972 Westheimer Rd. Santa Ana, Illinois 85486 ',
      'image': profileIconWithWidget
    },{
      'name':'Jacob Jones',
      'address':'2118 Thornridge Cir. Syracuse, Connecticut 35624',
      'image': profileIconWithWidget
    },{
      'name':'Devon Lane',
      'address':'3891 Ranchview Dr. Richardson, California 62639',
      'image': profileIconWithWidget
    },
  ].obs;

  final tenantUnitList = <Map<String, dynamic>>[
    {
      'image': apartment1Image,
      'name':'John Apartments',
      'address':'Room no-26 (3rd floor), Banani super market, Banani C/A, P.O. Box: 1213',
      'rate':'₹2500.00',
      'amenities':['Basement','Rooftop','Drinking Water','Gas']
    },
    {
        'image': apartment2Image,
        'name':'Trade Winds Tower',
        'address':'Room no-26 (3rd floor), Banani super market, Banani C/A, P.O. Box: 1213',
        'rate':'₹1500.00',
        'amenities':['Basement','Rooftop','Drinking Water']
      },
    ].obs;

  final paymentList = <Map<String, dynamic>>[
    {
      'date':'21\nJan',
      'unitName':'John Apartments',
      'description':'Lorem ipsum is a placeholder text commonly used to demonstrate the visual',
      'amount':'₹500.00',
    },
    {
      'date':'10\nJan',
      'unitName':'Trade Winds Tower',
      'description':'Lorem ipsum is a placeholder text commonly used to demonstrate the visual',
      'amount':'₹1,800.00',
    }
  ].obs;

  //functions
  Future<bool> onTenantDelete() {
    return resgisterPopup(
      title: 'Delete',
      subtitle: 'Are you sure you want to delete',
      button1: 'Cancel',
      button2: 'Yes, Delete',
      onButton1Tap: () {
        Get.back();

        return false;
      },
      onButton2Tap: () {
        Get.back();
        return true;
      },

    );
  }

  onTenantTap(){
    Get.to(()=>TenantDetailScreen());
  }
}