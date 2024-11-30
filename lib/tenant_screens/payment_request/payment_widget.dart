import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/utils.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/onboarding/auth/personal_info/personal_info_widget.dart';
import 'package:tanent_management/tenant_screens/payment_request/payment_controller.dart';

class PaymentWidget {
  paymentContainer() {
    final paymntCntrl = Get.find<PaymentController>();

    return ListView.separated(
      shrinkWrap: true,
      itemCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Container(
        height: 100,
        decoration: BoxDecoration(
            color: index == 0
                ? HexColor("#FFCCCB")
                : index == 1
                    ? HexColor("#E8EEF8")
                    : HexColor("#FFFFC5"),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "₹ ${index == 0 ? paymntCntrl.totalduetillnow.value : index == 1 ? paymntCntrl.pendingthismonth.value : paymntCntrl.pendingprocessamount.value}",
                      style: TextStyle(
                          color: black,
                          fontSize: 20.sp - commonFontSize,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                      index == 0
                          ? "last_due".tr
                          : index == 1
                              ? "rent_due".tr
                              : "process_amount".tr,
                      style: TextStyle(
                          color: black,
                          fontSize: 15.sp - commonFontSize,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              if (paymntCntrl.rentBillUrl.value != "" && index == 1)
                IconButton(
                    onPressed: () {
                      //  Get.to(()=>PdfView(pdfUrl: paymntCntrl.rentBillUrl.value,));
                      saveNetworkPdf(paymntCntrl.rentBillUrl.value);
                    },
                    icon: const Icon(Icons.download))
            ],
          );
        }),
      ),
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 5.h,
        );
      },
    );
  }

  paymenRequestForm() {
    final paymntCntrl = Get.find<PaymentController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("payment_request_form".tr,
            style: TextStyle(
                color: black,
                fontSize: 16.sp - commonFontSize,
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: 10.h,
        ),
        PersonlInfoWidget.commomText('amount'.tr),
        customTextField(
            controller: paymntCntrl.ammountController.value,
            hintText: '${'type_here'.tr}...',
            isBorder: true,
            color: HexColor('#F7F7F7'),
            isFilled: false,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.phone),
        SizedBox(
          height: 5.h,
        ),
        PersonlInfoWidget.commomText('description'.tr),
        customTextField(
            controller: paymntCntrl.descriptionController.value,
            hintText: '${'type_here'.tr}...',
            isBorder: true,
            color: HexColor('#F7F7F7'),
            isFilled: false,
            maxLines: 3),
      ],
    );
  }

  unitContainer() {
    final paymntCntrl = Get.find<PaymentController>();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: HexColor('#EBEBEB')),
          borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRect(
                  child: Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        image: paymntCntrl.paymentUnitData['image'] != null
                            ? DecorationImage(
                                image: NetworkImage(
                                  paymntCntrl.paymentUnitData['image'],
                                ),
                                fit: BoxFit.cover)
                            : DecorationImage(
                                image: profileIconWithWidget.image)),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            paymntCntrl.paymentUnitData['name'] ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: CustomStyles.black14,
                          )),
                          Text(
                            "₹${paymntCntrl.paymentUnitData['rent'] ?? ""}",
                            style: CustomStyles.amountFA4343W700S12.copyWith(
                                color: Colors.red,
                                fontSize: 15.0 - commonFontSize),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        paymntCntrl.paymentUnitData['address'] ?? "",
                        style: CustomStyles.address050505w400s12,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
