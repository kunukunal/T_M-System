import 'package:get/get.dart';
import 'package:tanent_management/screens/notification/notification_receive/notification_receive_widget.dart';

class NotifReceiveController extends GetxController{
  final items =<Map> [
    {
      'type':'Receive',
      'transactionId': 'ICCI18189373292',
      'title' : 'John Apartments',
      'desc': 'Room no-26 (3rd floor), Banani super market, Banani C/A, P.O. Box: 1213',
      'recievedby':'Tenants A',
      'date': '18 March 2024',
      'price':'₹2500.00',
      'isOccupied':true

    },  {
      'type':'Receive',
      'transactionId': 'ICCI18189373292',
      'title' : 'John Apartments',
      'desc': 'Room no-26 (3rd floor), Banani super market, Banani C/A, P.O. Box: 1213',
      'recievedby':'Tenants A',
      'date': '18 March 2024',
      'price':'₹2500.00',
      'isOccupied':true

    },

  ].obs;

  onEditTap(){
    NotifReceiveWidget().declinePopup();
  }
}