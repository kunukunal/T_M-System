import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/onboarding/auth/personal_info/personal_info_widget.dart';
import 'package:tanent_management/tenant_screens/payment_request/payment_controller.dart';

class PaymentWidget {
  paymentContainer() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Container(
        height: 100,
        decoration: BoxDecoration(
            color: HexColor("#E8EEF8"),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("₹5000.00",
                style: TextStyle(
                    color: black,
                    fontSize: 20.sp - commonFontSize,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 3.h,
            ),
            Text("Payment Received",
                style: TextStyle(
                    color: black,
                    fontSize: 15.sp - commonFontSize,
                    fontWeight: FontWeight.w400)),
          ],
        ),
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
        Text("Payment Request Form",
            style: TextStyle(
                color: black,
                fontSize: 16.sp - commonFontSize,
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: 10.h,
        ),
        PersonlInfoWidget.commomText('Amount'),
        customTextField(
          controller: paymntCntrl.ammountController.value,
          hintText: 'Type Here...',
          isBorder: true,
          color: HexColor('#F7F7F7'),
          isFilled: false,
        ),
        SizedBox(
          height: 5.h,
        ),
        PersonlInfoWidget.commomText('Description'),
        customTextField(
            controller: paymntCntrl.descriptionController.value,
            hintText: 'Type Here...',
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
