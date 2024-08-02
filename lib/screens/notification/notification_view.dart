import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/notification/notification_controller.dart';
import 'package:tanent_management/screens/notification/notification_widget.dart';

class NotificationView extends StatelessWidget {
  
   NotificationView({super.key});

   final notifCntrl= Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: appBar(title: 'Notifications'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:notifCntrl.items.length,
              itemBuilder: (context, index) {
                return notifCntrl.items[index]['type']=='Receive'? NotificationWidget().notifReceiveList(
                  transactionId: notifCntrl.items[index]['transactionId'],
                  desc: notifCntrl.items[index]['desc'],
                  title: notifCntrl.items[index]['title'],
                  price : notifCntrl.items[index]['price'],
                  name: notifCntrl.items[index]['recievedby'],
                  date: notifCntrl.items[index]['date'],
                ):notifCntrl.items[index]['type']=='Request'?NotificationWidget().notifRequestList(

                  desc: notifCntrl.items[index]['desc'],
                  title: notifCntrl.items[index]['title'],

                  name: notifCntrl.items[index]['recievedby'],

                ):notifCntrl.items[index]['type']=='Paid'?NotificationWidget().notifPaidList(

                  price: notifCntrl.items[index]['price'],
                  title: notifCntrl.items[index]['title'],
                  isOccupied: notifCntrl.items[index]['isOccupied'],



                ): NotificationWidget().notifRegularList(

                  desc: notifCntrl.items[index]['desc'],
                  title: notifCntrl.items[index]['title'],



                );
              },

            ),
          )
      ],),
    );
  }
}
