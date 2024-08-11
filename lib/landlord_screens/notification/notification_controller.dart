import 'package:get/get.dart';
import 'package:tanent_management/landlord_screens/notification/notification_receive/notification_receive_view.dart';
import 'package:tanent_management/landlord_screens/notification/notification_receive/notification_receive_widget.dart';

class NotificationController extends GetxController{
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

    },
    {
      'type':'Request',
      'transactionId': '',
      'title' : 'Requested For John Apartments',
      'desc': '4140 Parker Rd. Allentown, New Mexico 31134',
      'recievedby':'Tenants A',
      'date': '',
      'price':'',
      'isOccupied':true

    },   {
      'type':'Regular',
      'transactionId': '',
      'title' : 'Document Verification',
      'desc': 'Lorem ipsum dolor sit amet, consectetur adipiscing eli.',
      'recievedby':'',
      'date': '',
      'price':'',
      'isOccupied':true

    }, {
      'type':'Regular',
      'transactionId': '',
      'title' : 'New Project A',
      'desc': 'Lorem ipsum dolor sit amet, consectetur adipiscing eli.',
      'recievedby':'',
      'date': '',
      'price':'',
      'isOccupied':true

    },{
      'type':'Paid',
      'transactionId': '',
      'title' : 'Unit 1',
      'desc': 'Lorem ipsum dolor sit amet, consectetur adipiscing eli.',
      'recievedby':'',
      'date': '',
      'price':'₹2500.00',
      'isOccupied':false

    },
  ].obs;

  onReceiveTap(){
    Get.to(()=>NotificationReceiveView());
  }

  onDeclineTap(){
  NotifReceiveWidget().declinePopup();
  }
}