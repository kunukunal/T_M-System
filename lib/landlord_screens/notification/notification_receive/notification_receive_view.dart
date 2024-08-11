import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/notification/notification_receive/notification_receive_widget.dart';

import 'notification_receive_controller.dart';

class NotificationReceiveView extends StatelessWidget {
   NotificationReceiveView({super.key});
  final notifReceiveCntrl = Get.put(NotifReceiveController());

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: appBar(title: 'Receive'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:notifReceiveCntrl.items.length,
              itemBuilder: (context, index) {
                return NotifReceiveWidget().notifReceiveList(
                  transactionId: notifReceiveCntrl.items[index]['transactionId'],
                  desc: notifReceiveCntrl.items[index]['desc'],
                  title: notifReceiveCntrl.items[index]['title'],
                  price : notifReceiveCntrl.items[index]['price'],
                  name: notifReceiveCntrl.items[index]['recievedby'],
                  date: notifReceiveCntrl.items[index]['date'],
                );
              },

            ),
          )
        ],),
    ));

  }
}
