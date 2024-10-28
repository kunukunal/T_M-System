import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/notification/notification_controller.dart';
import 'package:tanent_management/landlord_screens/notification/notification_widget.dart';

class NotificationView extends StatelessWidget {
  NotificationView({super.key});

  final notifCntrl = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Notifications'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return Expanded(
              child: notifCntrl.lanlordNotificationLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : notifCntrl.items.isEmpty
                      ? const Center(
                          child: Text("No notification found"),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: notifCntrl.items.length,
                          itemBuilder: (context, index) {
                            return notifCntrl.items[index]['notification_type'] ==
                                    2
                                ? NotificationWidget().notifReceiveList(
                                    transactionId: notifCntrl.items[index]
                                        ['transaction']['transaction_id'],
                                    tranId: notifCntrl.items[index]
                                        ['transaction']['id'],
                                    notificationId: notifCntrl.items[index]
                                        ['id'],
                                    desc: notifCntrl.items[index]
                                            ['description'] ??
                                        "",
                                    title: notifCntrl.items[index]['title'],
                                    price: notifCntrl.items[index]
                                            ['transaction']['amount']
                                        .toString(),
                                    name: notifCntrl.items[index]['transaction']
                                        ['tenant'],
                                    isRead: notifCntrl.items[index]['is_read'],
                                    date: notifCntrl.items[index]['created_at'],
                                  )
                                : notifCntrl.items[index]['notification_type'] ==
                                        3
                                    ? NotificationWidget().notifRequestList(
                                        desc: notifCntrl.items[index]
                                                ['description'] ??
                                            "",
                                        title: notifCntrl.items[index]['title'],
                                        name: notifCntrl.items[index]['unit']
                                            ['tenant'],
                                        notificationId: notifCntrl.items[index]
                                            ['id'],
                                        notifiCationTypeId: 3,
                                        processRequestId: notifCntrl.items[index]
                                            ['unit']['request_id'],
                                        unitId: notifCntrl.items[index]['unit']
                                            ['unit_id'],
                                        isRead: notifCntrl.items[index]
                                            ['is_read'],
                                        isTenantAlreadyAdded: notifCntrl.items[index]
                                            ['unit']['is_tenant_added'],
                                        tenantId: notifCntrl.items[index]
                                            ['unit']['tenant_id'],
                                        notifiCationId: notifCntrl.items[index]['id'],
                                        date: notifCntrl.items[index]['created_at'])
                                    : notifCntrl.items[index]['notification_type'] == 4
                                        ? NotificationWidget().notifRequestList(desc: notifCntrl.items[index]['description'] ?? "", notificationId: notifCntrl.items[index]['id'], isRead: notifCntrl.items[index]['is_read'], title: notifCntrl.items[index]['title'], tenantId: notifCntrl.items[index]['unit']['tenant_id'], name: notifCntrl.items[index]['unit']['tenant'], notifiCationTypeId: 4, processRequestId: notifCntrl.items[index]['unit']['rental_id'], unitId: notifCntrl.items[index]['unit']['unit_id'], isTenantAlreadyAdded: false, date: notifCntrl.items[index]['created_at'])
                                        : notifCntrl.items[index]['notification_type'] == 1
                                            ? NotificationWidget().notifRegularList(desc: notifCntrl.items[index]['description'], notificationId: notifCntrl.items[index]['id'], isRead: notifCntrl.items[index]['is_read'], title: notifCntrl.items[index]['title'], date: notifCntrl.items[index]['created_at'])
                                            : const SizedBox();

                            // notifCntrl.items[index]['type']=='Paid'?NotificationWidget().notifPaidList(

                            //   price: notifCntrl.items[index]['price'],
                            //   title: notifCntrl.items[index]['title'],
                            //   isOccupied: notifCntrl.items[index]['isOccupied'],

                            // ): NotificationWidget().notifRegularList(

                            //   desc: notifCntrl.items[index]['desc'],
                            //   title: notifCntrl.items[index]['title'],

                            // );
                          },
                        ),
            );
          })
        ],
      ),
    );
  }
}
