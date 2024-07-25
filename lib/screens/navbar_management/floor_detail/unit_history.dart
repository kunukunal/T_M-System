import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/generated/assets.dart';
import 'package:tanent_management/screens/navbar_management/floor_detail/unit_history_controller.dart';

// Screen -21
class UnitHistory extends StatelessWidget {
  UnitHistory({super.key});
  final unitHistoryController = Get.put(UnitHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text("Unit History",
            style: CustomStyles.titleText
                .copyWith(fontWeight: FontWeight.w500, fontFamily: 'Inter')),
        centerTitle: true,
      ),
      body: Obx(() {
        return unitHistoryController.unitHistoryLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : unitHistoryController.items.isEmpty
                ? const Center(
                    child: Text("No History data found"),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        ListTile(
                          leading: Image.asset(
                            Assets.imagesApartment1Image,
                            height: 100.h,
                            width: 50.w,
                            fit: BoxFit.fill,
                          ),
                          title: Text(
                            unitHistoryController.unitName.value,
                            style: CustomStyles.titleText.copyWith(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter'),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Total Rent Received"),
                              Text("₹ ${unitHistoryController.totalRent}",
                                  style: CustomStyles.titleText.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Inter'))
                            ],
                          ),
                        ),
                        const Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        Text(
                          "${unitHistoryController.propertyName} | ${unitHistoryController.buildinName} | ${unitHistoryController.floorName}",
                          style: CustomStyles.d7,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Expanded(
                          child: unitHistoryController.items.isEmpty
                              ? const Center(
                                  child: Text("No History data found"),
                                )
                              : ListView.builder(
                                  itemCount: unitHistoryController.items.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => historyCard(
                                      tenantName: unitHistoryController.items[index]
                                              ['tenant_name'] ??
                                          "",
                                      mobileNumber: unitHistoryController.items[index]
                                              ['mobile'] ??
                                          "",
                                      transactionAmount:
                                          unitHistoryController.items[index]
                                                  ['transaction_amount'] ??
                                              "",
                                      dateFrom: unitHistoryController.items[index]
                                              ['date_from'] ??
                                          "",
                                      dateTo: unitHistoryController.items[index]
                                              ['date_to'] ??
                                          ""),
                                ),
                        )
                      ],
                    ),
                  );
      }),
    );
  }
}

// Sepreate class

Widget historyCard({
  String? tenantName,
  String? mobileNumber,
  String? transactionAmount,
  String? dateFrom,
  String? dateTo,
}) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(Assets.iconsProfile),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tenantName!,
                              style: CustomStyles.titleText.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter'),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(mobileNumber!)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "₹ $transactionAmount",
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.w500),
                )
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "From",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(dateFrom!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("To", style: TextStyle(fontSize: 16)),
                    Text(dateTo!,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.green))
                  ],
                ),
                SizedBox(
                  width: 30.w,
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: 10.h,
      )
    ],
  );
}
